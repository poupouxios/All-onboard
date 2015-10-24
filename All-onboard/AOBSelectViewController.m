//
//  AOBSelectViewController.m
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "AOBSelectViewController.h"
#import "AOBBeaconDetectionManager.h"
#import "AOBCarDetailsViewController.h"

@interface AOBSelectViewController () <AOBBeaconDetectionManagerDatasource,AOBBeaconDetectionManagerDelegate>

@property (weak, nonatomic) IBOutlet FUIButton *findMyCarButton;
@property (weak, nonatomic) IBOutlet FUIButton *selectFromListButton;
@property (nonatomic,strong) AOBBeaconDetectionManager *beaconDetectionManager;
@property (nonatomic,strong) AOBCustomProgressHUD *progressHud;
@property (nonatomic,strong) NSNumber *beaconMajor;

@end

@implementation AOBSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self styleButtons];
    self.beaconDetectionManager = [[AOBBeaconDetectionManager alloc] init];
    self.beaconDetectionManager.delegate = self;
    self.beaconDetectionManager.datasource = self;
    self.beaconDetectionManager.typeOfScan = ABOBeaconNonFilterScan;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void) styleButtons{
    [self.findMyCarButton applyFlatDesignForUIButton];
    [self.selectFromListButton applyFlatDesignForUIButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Beacon Delegate

- (void)aboBeaconDetectionManagerDelegateBluetoothIsOff{
    [AOBBaseVIewHelper setAlertWithOkButton:@"Warning" andAlertDelegate:self andTag:1 andTitle:kBluetoothIsOff];
    [self.progressHud hide:YES];
}

- (void)aboBeaconDetectionManagerDelegateClosestBeaconFound:(NSNumber *)beaconMajor{
    self.beaconMajor = beaconMajor;
    [self.beaconDetectionManager stopSearchingForBeacons];
    [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"closest beacon is %@",beaconMajor]];
    [self.progressHud hide:YES];
    [self performSegueWithIdentifier:@"carBeaconDetected" sender:self];
}

- (void)aboBeaconDetectionManagerDelegateDidFailToAccess:(NSString *)failedMessage andTitleMessage:(NSString *)titleMessage{
    [AOBBaseVIewHelper setAlertWithOkButton:titleMessage andAlertDelegate:self andTag:1 andTitle:failedMessage];
    [self.progressHud hide:YES];
}

- (void)aboBeaconDetectionManagerdelegateNoBeaconsDetected{
    
}

- (void)aboBeaconDetectionManagerDelegateShakeDetected{
    
}

- (void)aboBeaconDetectionManagerDelegateStartDetectingBeacons{
    
}

#pragma mark - Beacon Datasource

- (NSArray *)getListOfBeaconsToSearch{
    NSArray *cars = [AOBCarMapper findAll];
    NSMutableArray *beacons = [[NSMutableArray alloc] init];
    for (Car *entityCar in cars) {
        if(entityCar.beacon_major && entityCar.beacon_major.integerValue > 0){
            [beacons addObject:entityCar.beacon_major];
        }
    }
    return beacons;
}

- (NSString *)getUniqueName{
    return @"allonboard";
}

- (NSUUID *)getUUID{
    NSUUID *beaconUUID = [[NSUUID alloc] initWithUUIDString:kBeaconUUID];
    return beaconUUID;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)findMyCarClicked:(id)sender {
    [self.beaconDetectionManager startSearchingForBeacons];
    self.progressHud = [[AOBCustomProgressHUD alloc] initWithView:self.view andMessage:kBeaconStartDetection andHudMode:MBProgressHUDModeIndeterminate andDisplayButton:NO];
    [self.progressHud show:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"carBeaconDetected"]){
        AOBCarDetailsViewController *carDetailsVC = [segue destinationViewController];
        NSArray *cars = [AOBCarMapper findAll];
        for (Car *entityCar in cars) {
            if([entityCar.beacon_major isEqualToNumber:self.beaconMajor]){
                carDetailsVC.carDetails = entityCar;
                break;
            }
        }
    }
}

@end
