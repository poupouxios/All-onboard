//
//  AOBLoadViewController.m
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "AOBLoadViewController.h"

@interface AOBLoadViewController () <AOBApiHandlerDelegate>

@property (nonatomic,strong) AOBApiHandler *apiHandler;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (nonatomic,assign) float numberOfUpdates;

@end

@implementation AOBLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.apiHandler = [[AOBApiHandler alloc] init];
    self.apiHandler.delegate = self;
    self.numberOfUpdates = 0.0;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.apiHandler getAllCarData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Api Handler Delegates

- (void)aobAPiHandlerNextUpdate{
    [self performSelectorInBackground:@selector(updateProgressBar) withObject:nil];
}

- (void)aobAPIHandlerDidFinishSuccessfully{
    [self performSegueWithIdentifier:@"firstScreen" sender:self];
}

- (void)aobAPiHAndlerGetNumberOfUpdates:(float)numberOfUpdates{
    self.numberOfUpdates += numberOfUpdates;
}

- (void)aobAPIHandlerDidFailUpdate:(NSString *)failedMessage{
    [AOBBaseVIewHelper setAlertWithOkButton:failedMessage andAlertDelegate:self andTag:1 andTitle:@"Error"];
    NSArray *cars = [AOBCarMapper findAll];
    if(cars.count > 0){
        [self performSegueWithIdentifier:@"firstScreen" sender:self];
    }
}

- (void) updateProgressBar{
    self.progressBar.progress += (1 / self.numberOfUpdates);
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
