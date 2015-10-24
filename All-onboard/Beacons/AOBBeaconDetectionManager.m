//
//  ABOBeaconDetectionViewController.m
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "AOBBeaconDetectionManager.h"

@interface AOBBeaconDetectionManager ()

@property (nonatomic,strong) NSMutableDictionary *totalTimesBeaconFound;
@property (nonatomic,strong) CBCentralManager *bluetoothManager;
@property (nonatomic,assign) BOOL bluetoothEnabled;
@property (nonatomic,assign) BOOL alreadyShownAlertMessage;
@property (nonatomic,strong) NSMutableArray *regions;
@property (nonatomic,strong) NSArray *listOfBeaconToSearchOnly;
@property (nonatomic,assign) CLAuthorizationStatus authorizationStatus;

@end

@implementation AOBBeaconDetectionManager

- (id) init{
    self = [super init];
    if (self) {
        self.bluetoothEnabled = YES;
        self.regions = [[NSMutableArray alloc] init];
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.accelerometerUpdateInterval = .1;
        self.totalTimesBeaconFound = [[NSMutableDictionary alloc] init];
        self.currentBeacon = [NSNumber numberWithInt:-1];
        self.countBeaconDetections = kFlickerDelay - 1;
        self.typeOfScan = ABOBeaconNonFilterScan;
        UIApplication *application = [UIApplication sharedApplication];
        if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        }
        
    }
    return self;
}

#pragma Bluetooth Method Events

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStatePoweredOff:
            self.bluetoothEnabled = NO;
            [self.delegate aboBeaconDetectionManagerDelegateBluetoothIsOff];
            break;
        case CBCentralManagerStatePoweredOn:
            self.bluetoothEnabled = YES;
            break;
        case CBCentralManagerStateResetting:
            self.bluetoothEnabled = NO;
            break;
        case CBCentralManagerStateUnauthorized:
            self.bluetoothEnabled = NO;
            [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"CoreBluetooth BLE state is unauthorized"]];
            break;
        case CBCentralManagerStateUnknown:
            self.bluetoothEnabled = NO;
            [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"CoreBluetooth BLE state is unknown"]];
            break;
        case CBCentralManagerStateUnsupported:
            [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"CoreBluetooth BLE state is not supported"]];
            self.bluetoothEnabled = NO;
            break;
        default:
            break;
    }
}

- (void)beaconManager:(id)manager didEnterRegion:(CLBeaconRegion *)region{
    if([self.delegate respondsToSelector:@selector(aboBeaconDetectionManagerDelegateBeaconEnteredRegion:)]){
        [self.delegate aboBeaconDetectionManagerDelegateBeaconEnteredRegion:region];
    }
}

- (void)beaconManager:(id)manager didExitRegion:(CLBeaconRegion *)region{
    if([self.delegate respondsToSelector:@selector(aboBeaconDetectionManagerDelegateBeaconExitregion:)]){
        [self.delegate aboBeaconDetectionManagerDelegateBeaconExitregion:region];
    }
}

- (void)beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    NSArray *finalFilteredBeacons = [self filterBeaconsBasedOnListProvided:beacons];
    self.countBeaconDetections++;
    if([finalFilteredBeacons count] > 0)
    {
        if(self.countBeaconDetections >= kFlickerDelay){
            [self findClosestBeacon:finalFilteredBeacons];
        }
    }else{
        if([self.delegate respondsToSelector:@selector(aboBeaconDetectionManagerdelegateNoBeaconsDetected)]){
            [self.delegate aboBeaconDetectionManagerdelegateNoBeaconsDetected];
        }
        if([self.currentBeacon isEqualToNumber:@-1]){
            self.countBeaconDetections = 0;
        }
    }
}

- (void)utilityManager:(ESTUtilityManager *)manager didDiscoverBeacons:(NSArray *)beacons{
    NSArray *finalFilteredBeacons = [self filterBeaconsBasedOnListProvided:beacons];
    self.countBeaconDetections++;
    if([finalFilteredBeacons count] > 0)
    {
        if(self.countBeaconDetections >= kFlickerDelay){
            [self findClosestBeacon:finalFilteredBeacons];
        }
    }else{
        if([self.delegate respondsToSelector:@selector(aboBeaconDetectionManagerdelegateNoBeaconsDetected)]){
            [self.delegate aboBeaconDetectionManagerdelegateNoBeaconsDetected];
        }
        if([self.currentBeacon isEqualToNumber:@-1]){
            self.countBeaconDetections = 0;
        }
    }
}

- (NSArray *) filterBeaconsBasedOnListProvided:(NSArray *)beaconDetected{
    if(self.listOfBeaconToSearchOnly.count == 0){
        return beaconDetected;
    }else{
        NSMutableArray *filteredBeacons = [[NSMutableArray alloc] init];
        for (CLBeacon *entityBeacon in beaconDetected) {
            [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"beacon found = %@",entityBeacon.major]];
            if([self.listOfBeaconToSearchOnly containsObject:entityBeacon.major]){
                [filteredBeacons addObject:entityBeacon];
            }
        }
        return filteredBeacons;
    }
}

-(void)startRangingBeacons
{
    if(self.bluetoothEnabled){
        if(self.typeOfScan == ABOBeaconNonFilterScan) {
            [self initiateBeaconDetection];
            return;
        }
        if([LSCOperatingSystemInfo isIOS8]){
            self.authorizationStatus = [ESTBeaconManager authorizationStatus];
            if ([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
            {
                [self.beaconManager requestAlwaysAuthorization];
                self.alreadyShownAlertMessage = NO;
            }
            else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)
            {
                [self initiateBeaconDetection];
                self.alreadyShownAlertMessage = NO;
            }
            else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusDenied && !self.alreadyShownAlertMessage)
            {
                [self.delegate aboBeaconDetectionManagerDelegateDidFailToAccess:LOCATION_SERVICES_DENYING_ACCESS andTitleMessage:@"Location Access Denied"];
                self.alreadyShownAlertMessage = YES;
            }
            else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusRestricted && !self.alreadyShownAlertMessage)
            {
                [self.delegate aboBeaconDetectionManagerDelegateDidFailToAccess:LOCATION_SERVICES_NO_ACCESS andTitleMessage:@"Location Not Available"];
                self.alreadyShownAlertMessage = YES;
            }
        }else{
            if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusDenied && !self.alreadyShownAlertMessage)
            {
                [self.delegate aboBeaconDetectionManagerDelegateDidFailToAccess:LOCATION_SERVICES_DENYING_ACCESS andTitleMessage:@"Location Access Denied"];
                self.alreadyShownAlertMessage = YES;
            }
            else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusRestricted && !self.alreadyShownAlertMessage)
            {
                [self.delegate aboBeaconDetectionManagerDelegateDidFailToAccess:LOCATION_SERVICES_NO_ACCESS andTitleMessage:@"Location Not Available"];
                self.alreadyShownAlertMessage = YES;
            }else if(!self.alreadyShownAlertMessage){
                [self initiateBeaconDetection];
                self.alreadyShownAlertMessage = NO;
            }
        }
    }
}

- (void) startSearchingForBeacons{
    [self prepareForBeaconDetection];
    switch (self.typeOfScan) {
        case ABOBeaconMonitoringScan:
            [self startSearchingForBeaconsWithMonitoringMethod];
            break;
            
        case ABOBeaconNonFilterScan:
            [self startSearchingForBeaconsWithNonFilterManager];
            break;
        
        case ABObeaconRangingScan:
            [self startSearchingForBeaconsWithRangingBeaconDetection];
            break;
            
        default:
            [self startSearchingForBeaconsWithNonFilterManager];
            break;
    }
    [self startRangingBeacons];
}

- (void) prepareForBeaconDetection{
    self.alreadyShownAlertMessage = NO;
    [self clearingAllBeaconData];
    self.bluetoothManager = [[CBCentralManager alloc]
                             initWithDelegate:self
                             queue:dispatch_get_main_queue()
                             options:@{CBCentralManagerOptionShowPowerAlertKey: @(NO)}];
    self.listOfBeaconToSearchOnly = [self.datasource getListOfBeaconsToSearch];
}

- (void) startSearchingForBeaconsWithNonFilterManager{
    self.beaconNonFilterManager = [[ESTUtilityManager alloc] init];
    self.beaconNonFilterManager.delegate = self;
}

- (void) startSearchingForBeaconsWithRangingBeaconDetection{
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    self.beaconManager.avoidUnknownStateBeacons = YES;
    NSUUID *appUUID = [self.datasource getUUID];
    self.region = [[CLBeaconRegion alloc] initWithProximityUUID:appUUID identifier:[self.datasource getUniqueName]];
    self.region.notifyEntryStateOnDisplay = YES;
}

- (void) startSearchingForBeaconsWithMonitoringMethod{
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    self.beaconManager.avoidUnknownStateBeacons = YES;
    NSUUID *appUUID = [self.datasource getUUID];
    self.region = [[CLBeaconRegion alloc] initWithProximityUUID:appUUID identifier:[self.datasource getUniqueName]];
    self.region.notifyEntryStateOnDisplay = YES;
}

- (void) stopSearchingForBeacons{
    switch (self.typeOfScan) {
        case ABOBeaconMonitoringScan:
            [self stopSearchingForBeaconsWithMonitoringMethod];
            break;
            
        case ABOBeaconNonFilterScan:
            [self stopSearchingForBeaconsWithNonFilterManager];
            break;
            
        case ABObeaconRangingScan:
            [self stopSearchingForBeaconsWithRangingBeaconMethod];
            break;
            
        default:
            [self stopSearchingForBeaconsWithNonFilterManager];
            break;
    }
    [self prepareForStoppingBeaconDetection];
}

- (void) prepareForStoppingBeaconDetection{
    [self.motionManager stopAccelerometerUpdates];
    [self doResetTotalTimesBeaconFound:YES];
}

- (void) stopSearchingForBeaconsWithRangingBeaconMethod{
    [self.beaconManager stopRangingBeaconsInRegion:self.region];
}

- (void) stopSearchingForBeaconsWithMonitoringMethod{
    [self.beaconManager stopMonitoringForRegion:self.region];
}

- (void) stopSearchingForBeaconsWithNonFilterManager{
    [self.beaconNonFilterManager stopEstimoteBeaconDiscovery];
}

- (void) initiateBeaconDetection{
    [self clearingAllBeaconData];
    [self.delegate aboBeaconDetectionManagerDelegateStartDetectingBeacons];
    switch (self.typeOfScan) {
        case ABOBeaconMonitoringScan:
            [self initiateBeaconDetectionWithMonitoringMethod];
            break;
            
        case ABOBeaconNonFilterScan:
            [self initiateBeaconDetectionWithNonFilterManager];
            break;
            
        case ABObeaconRangingScan:
            [self initiateBeaconDetectionWithRangingMethod];
            break;
            
        default:
            [self initiateBeaconDetectionWithNonFilterManager];
            break;
    }
    [self setupMotionResetBeacons];
}

- (void) initiateBeaconDetectionWithNonFilterManager{
    [self.beaconNonFilterManager startEstimoteBeaconDiscoveryWithUpdateInterval:0.4f];
}

- (void) initiateBeaconDetectionWithRangingMethod{
    [self.beaconManager startRangingBeaconsInRegion:self.region];
}

- (void) initiateBeaconDetectionWithMonitoringMethod{
    self.region.notifyOnEntry = YES;
    self.region.notifyOnExit = YES;
    [self.beaconManager startMonitoringForRegion:self.region];
}

- (void) setupMotionResetBeacons{
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                                 [self outputAccelerationData:accelerometerData.acceleration];
                                                 if(error){
                                                     [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"%@", error]];
                                                 }
                                             }];
}

- (void) clearingAllBeaconData{
    self.currentBeacon = [NSNumber numberWithInt:-1];
    [self.totalTimesBeaconFound removeAllObjects];
}

- (void)beaconManager:(ESTBeaconManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(self.authorizationStatus != status){
        [self startRangingBeacons];
    }
}

-(void)outputAccelerationData:(CMAcceleration)acceleration
{
    if(acceleration.x > kAccelerationThreshold || acceleration.y > kAccelerationThreshold){
        if([self.delegate respondsToSelector:@selector(aboBeaconDetectionManagerDelegateShakeDetected)]){
            [self.delegate aboBeaconDetectionManagerDelegateShakeDetected];
        }
        [self doResetTotalTimesBeaconFound:YES];
        self.countBeaconDetections = kFlickerDelay-2;
    }
}

- (void) findClosestBeacon:(NSArray *)finalBeacons{
    NSInteger minimumRSSI = -200;
    NSNumber *closestBeacon = @0;
    if(finalBeacons.count == 0){
        return;
    }
    for (CLBeacon *entityBeacon  in finalBeacons) {
        if(entityBeacon.rssi > minimumRSSI){
            minimumRSSI = entityBeacon.rssi;
            closestBeacon = entityBeacon.major;
        }
    }
    
    if(![self isBeaconReachedTheTotalDiscoveries:closestBeacon]){
        return;
    }
    self.countBeaconDetections = 0;
    [self.delegate aboBeaconDetectionManagerDelegateClosestBeaconFound:closestBeacon];
    return;
}

- (BOOL) isBeaconReachedTheTotalDiscoveries:(NSNumber *) beaconMajor{
    if(beaconMajor == nil){
        return NO;
    }
    BOOL isTimeToChange = false;
    BOOL resetCounts = false;
    NSNumber *totalTimesFound = [self.totalTimesBeaconFound objectForKey:beaconMajor];
    if(totalTimesFound == nil){
        [self.totalTimesBeaconFound setObject:@1 forKey:beaconMajor];
    }else{
        totalTimesFound = [NSNumber numberWithInt:totalTimesFound.intValue + 1];
        [self.totalTimesBeaconFound setObject:totalTimesFound forKey:beaconMajor];
        if(totalTimesFound.intValue >= kTimesDiscovered){
            resetCounts = true;
            if([beaconMajor isEqualToNumber:self.currentBeacon]){
                [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"current beacon is %@",self.currentBeacon]];
                isTimeToChange = false;
            }else{
                self.currentBeacon = beaconMajor;
                isTimeToChange = true;
            }
        }
    }
    [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"total times found each beacon = %@",self.totalTimesBeaconFound]];
    [self doResetTotalTimesBeaconFound:resetCounts];
    return isTimeToChange;
}

- (void) doResetTotalTimesBeaconFound:(BOOL)resetCounts{
    if(resetCounts){
        NSArray *allKeys = [self.totalTimesBeaconFound allKeys];
        for (NSNumber *key in allKeys) {
            [self.totalTimesBeaconFound setObject:@0 forKey:key];
        }
    }
}

@end
