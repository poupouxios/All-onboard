//
//  ABOBeaconDetectionViewController.h
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AOBBeaconWordingConstants.h"
#import <CoreMotion/CoreMotion.h>
@import CoreBluetooth;

typedef NS_ENUM(NSInteger, ABOBeaconScanType)
{
    ABOBeaconNonFilterScan,
    ABObeaconRangingScan,
    ABOBeaconMonitoringScan
};

@protocol AOBBeaconDetectionManagerDelegate <NSObject>

@required
- (void) aboBeaconDetectionManagerDelegateDidFailToAccess:(NSString *)failedMessage andTitleMessage:(NSString *)titleMessage;
- (void) aboBeaconDetectionManagerDelegateStartDetectingBeacons;
- (void) aboBeaconDetectionManagerDelegateClosestBeaconFound:(NSNumber *)beaconMajor;
- (void) aboBeaconDetectionManagerDelegateBluetoothIsOff;

@optional
- (void) aboBeaconDetectionManagerdelegateNoBeaconsDetected;
- (void) aboBeaconDetectionManagerDelegateShakeDetected;
- (void) aboBeaconDetectionManagerDelegateBeaconEnteredRegion:(CLBeaconRegion *)regionDetected;
- (void) aboBeaconDetectionManagerDelegateBeaconExitregion:(CLBeaconRegion *)regionDetected;

@end

@protocol AOBBeaconDetectionManagerDatasource <NSObject>

@required
- (NSUUID *) getUUID;
- (NSString *) getUniqueName;
- (NSArray *) getListOfBeaconsToSearch;

@end

@interface AOBBeaconDetectionManager : NSObject <ESTBeaconManagerDelegate, ESTUtilityManagerDelegate, CBCentralManagerDelegate>

@property (nonatomic,strong) NSNumber *parentId;
@property (nonatomic,strong) ESTBeaconManager *beaconManager;
@property (nonatomic,strong) ESTUtilityManager *beaconNonFilterManager;
@property (nonatomic,strong) CLBeaconRegion *region;
@property (assign, nonatomic) int countBeaconDetections;
@property (nonatomic,strong) NSNumber *currentBeacon;
@property (strong, nonatomic) CMMotionManager *motionManager;
@property (nonatomic,assign) ABOBeaconScanType typeOfScan;

@property (nonatomic,weak) id <AOBBeaconDetectionManagerDelegate> delegate;
@property (nonatomic,weak) id <AOBBeaconDetectionManagerDatasource> datasource;

- (void) startSearchingForBeacons;
- (void) stopSearchingForBeacons;

@end
