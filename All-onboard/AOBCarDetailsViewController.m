//
//  AOBCarDetailsViewController.m
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "AOBCarDetailsViewController.h"
#import "AOBYoutubeViewController.h"
#import "AOBCarChannelViewController.h"

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
    self.carTitle.text = [NSString stringWithFormat:@"Welcome to %@ %@ guide",self.carDetails.carMake,self.carDetails.carModel];
    self.fuelType.text = self.carDetails.fuel_type;
    self.transmissionLabel.text = self.carDetails.gearing;
    [self.videoButton applyFlatDesignForUIButton];
    if(self.carDetails.carImage){
        self.carImage.image = [UIImage imageWithData:self.carDetails.carImage.imageData];
    }
    self.carImage.layer.masksToBounds = YES;
    self.carImage.layer.cornerRadius = 20;
    [self addChatButtonOnNavigationBar];
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

- (void) addChatButtonOnNavigationBar{
    UIBarButtonItem *chatItem = [[UIBarButtonItem alloc] initWithTitle:@"Chat >" style:UIBarButtonItemStylePlain target:self action:@selector(openChat)];
    self.navigationItem.rightBarButtonItem = chatItem;
}

- (void) openChat{
    [self performSegueWithIdentifier:@"openChannel" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"youtubeVideo"]){
        AOBYoutubeViewController *youtubeVideoPlayer = [segue destinationViewController];
        youtubeVideoPlayer.youtubeId = self.carDetails.intro_video_id;
    }else{
        AOBCarChannelViewController *carChannelVC = [segue destinationViewController];
        carChannelVC.entityCar = self.carDetails;
    }
}


- (IBAction)viewYoutubeVideo:(id)sender {
    if(self.carDetails.intro_video_id){
        [self performSegueWithIdentifier:@"youtubeVideo" sender:self];
    }else{
        [AOBBaseVIewHelper setAlertWithOkButton:kNoYoutubeLinkAvailable andAlertDelegate:self andTag:1 andTitle:@"Warning"];
    }
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
