//
//  AOBCarDetailsTableViewController.m
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "AOBCarDetailsTableViewController.h"

@interface AOBCarDetailsTableViewController ()

@property (nonatomic,strong) NSArray *cars;
@property (strong, nonatomic) IBOutlet UITableView *carsTable;

@end

@implementation AOBCarDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.cars = [AOBCarMapper findAll];
    self.carsTable.delegate = self;
    self.carsTable.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cars.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"carCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:identifier];
        //[cell applyColorForCells:YES andSecondaryColour:kFontColour];
    }
    
    Car *entityCar = [self.cars objectAtIndex:indexPath.row];
    
    cell.textLabel.text = entityCar.carMake;
    cell.textLabel.textColor = [UIColor colorFromHexString:kFontColour];
    cell.detailTextLabel.text = entityCar.carModel;
    cell.detailTextLabel.textColor = [UIColor colorFromHexString:kFontColour];
    return cell;
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
