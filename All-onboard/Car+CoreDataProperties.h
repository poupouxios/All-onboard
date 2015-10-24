//
//  Car+CoreDataProperties.h
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Car.h"

NS_ASSUME_NONNULL_BEGIN

@interface Car (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *carId;
@property (nullable, nonatomic, retain) NSNumber *beacon_major;
@property (nullable, nonatomic, retain) NSString *carMake;
@property (nullable, nonatomic, retain) NSString *carModel;

@end

NS_ASSUME_NONNULL_END