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

@property (weak, nonatomic) IBOutlet UIImageView *findMyCarImage;
@property (weak, nonatomic) IBOutlet FUIButton *selectFromListButton;
@property (weak, nonatomic) IBOutlet UILabel *searchingCarLabel;
@property (nonatomic,strong) AOBBeaconDetectionManager *beaconDetectionManager;
@property (nonatomic,strong) AOBCustomProgressHUD *progressHud;
@property (nonatomic,strong) NSNumber *beaconMajor;
@property (nonatomic,strong) UIView *pulseView;

@end

@implementation AOBSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.selectFromListButton applyFlatDesignForUIButton];
    self.beaconDetectionManager = [[AOBBeaconDetectionManager alloc] init];
    self.beaconDetectionManager.delegate = self;
    self.beaconDetectionManager.datasource = self;
    self.beaconDetectionManager.typeOfScan = ABOBeaconNonFilterScan;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.searchingCarLabel.text = kSearchingLabel;
    [self createAnimationForCarImage:kAnimatingScannerColor];
    self.findMyCarImage.alpha = 1;
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.beaconDetectionManager startSearchingForBeacons];
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
    [self makeCarRun];
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

- (void) makeCarRun{
    [CATransaction begin];
    self.searchingCarLabel.text = kCarFoundLabel;
    [self createAnimationForCarImage:kAnimatingScannerBeaconFoundColor];
    CGSize deviceSize = [LSCDeviceDetails getDimensionsOfDevice];
    CGPoint point0 = self.findMyCarImage.layer.position;
    CGPoint point1 = { deviceSize.width+self.findMyCarImage.image.size.width + 20, point0.y };
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.x"];
    anim.fromValue    = @(point0.x);
    anim.toValue  = @(point1.x);
    anim.duration   = 1.5f;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    self.findMyCarImage.layer.position = point1;
    [CATransaction setCompletionBlock:^{
        [self.beaconDetectionManager stopSearchingForBeacons];
        [self performSegueWithIdentifier:@"carBeaconDetected" sender:self];
    }];
    [self.findMyCarImage.layer  addAnimation:anim forKey:@"position.x"];
    [CATransaction commit];
}

- (void) createAnimationForCarImage:(NSString *)animatedColor{
    if(self.pulseView){
        [self.pulseView removeFromSuperview];
    }
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    
    CAAnimationGroup *beaconAnimations = [CAAnimationGroup animation];
    [beaconAnimations setAnimations:[NSArray arrayWithObjects:opacityAnimation,scaleAnimation,nil]];
    [beaconAnimations setRemovedOnCompletion:YES];
    [beaconAnimations setFillMode:kCAFillModeForwards];
    beaconAnimations.repeatCount = HUGE_VAL;
    
    self.pulseView = [[UIView alloc] initWithFrame:CGRectMake(-10,-20, 80, 80)];
    self.pulseView.layer.cornerRadius = 40;
    beaconAnimations.duration = 1.3;
    
    self.pulseView.backgroundColor = [UIColor colorFromHexCode:animatedColor];
    self.pulseView.alpha = 0.5;
    self.pulseView.tag = 1;
    self.pulseView.userInteractionEnabled = YES;
    
    [self.pulseView.layer addAnimation:beaconAnimations forKey:@"scale"];
    [self.findMyCarImage addSubview:self.pulseView];
}

- (IBAction)selectFromListClicked:(id)sender {
    [self.beaconDetectionManager stopSearchingForBeacons];
}


@end
