//
//  AOBCarDetailsViewController.m
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "AOBCarDetailsViewController.h"
#import "AOBYoutubeViewController.h"

@interface AOBCarDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *carImage;
@property (weak, nonatomic) IBOutlet UILabel *carTitle;
- (IBAction)viewYoutubeVideo:(id)sender;
@property (weak, nonatomic) IBOutlet FUIButton *videoButton;
@property (weak, nonatomic) IBOutlet UILabel *fuelType;
@property (weak, nonatomic) IBOutlet UILabel *transmissionLabel;

@end

@implementation AOBCarDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent= NO;
    self.carTitle.text = [NSString stringWithFormat:@"Welcome to %@ %@",self.carDetails.carMake,self.carDetails.carModel];
    self.fuelType.text = self.carDetails.fuel_type;
    self.transmissionLabel.text = self.carDetails.gearing;
    [self.videoButton applyFlatDesignForUIButton];
    if(self.carDetails.carImage){
        self.carImage.image = [UIImage imageWithData:self.carDetails.carImage.imageData];
    }
    self.carImage.layer.masksToBounds = YES;
    self.carImage.layer.cornerRadius = self.carImage.image.size.height / 6;
    // Do any additional setup after loading the view.
}

-  (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AOBYoutubeViewController *youtubeVideoPlayer = [segue destinationViewController];
    youtubeVideoPlayer.youtubeId = self.carDetails.intro_video_id;
}


- (IBAction)viewYoutubeVideo:(id)sender {
    if(self.carDetails.intro_video_id){
        [self performSegueWithIdentifier:@"youtubeVideo" sender:self];
    }else{
        [AOBBaseVIewHelper setAlertWithOkButton:@"Warning" andAlertDelegate:self andTag:1 andTitle:kNoYoutubeLinkAvailable];
    }
}
@end
