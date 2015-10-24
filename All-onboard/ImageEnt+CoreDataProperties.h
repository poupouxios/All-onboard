//
//  ImageEnt+CoreDataProperties.h
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ImageEnt.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageEnt (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *imageData;
@property (nullable, nonatomic, retain) NSString *imageFilename;
@property (nullable, nonatomic, retain) Car *car;

@end

NS_ASSUME_NONNULL_END
