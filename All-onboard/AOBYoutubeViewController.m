//
//  AOBYoutubeViewController.m
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "AOBYoutubeViewController.h"

@interface AOBYoutubeViewController () <YTPlayerViewDelegate>

@property (nonatomic,strong) AOBCustomProgressHUD *progressHud;

@end

@implementation AOBYoutubeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.playerView.delegate = self;
    [self.playerView loadWithVideoId:self.youtubeId];
    self.progressHud = [[AOBCustomProgressHUD alloc] initWithView:self.navigationController.view andMessage:kLoadingYoutubeVideo andHudMode:MBProgressHUDModeIndeterminate andDisplayButton:NO];
    [self.progressHud show:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playerViewDidBecomeReady:(YTPlayerView *)playerView{
    [self.playerView playVideo];
    [self.progressHud hide:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
