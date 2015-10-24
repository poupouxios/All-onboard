//
//  AOBSelectViewController.m
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "AOBSelectViewController.h"

@interface AOBSelectViewController ()

@property (weak, nonatomic) IBOutlet FUIButton *findMyCarButton;
@property (weak, nonatomic) IBOutlet FUIButton *selectFromListButton;

@end

@implementation AOBSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self styleButtons];
    // Do any additional setup after loading the view.
}

- (void) styleButtons{
    [self.findMyCarButton applyFlatDesignForUIButton];
    [self.selectFromListButton applyFlatDesignForUIButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
