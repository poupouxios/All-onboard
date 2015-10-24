//
//  AOBCarMapper.m
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "AOBCarMapper.h"

@implementation AOBCarMapper

+ (NSArray *)findAll{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSArray *Cars = [Car MR_findAll];
    for (Car *entityItem  in Cars) {
        [results addObject:entityItem];
    }
    return results;
}

+ (Car *) findOneById:(NSNumber *) entityId{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"carId == %@",entityId]];
    Car *entity = nil;
    NSArray *entities = [Car MR_findAllWithPredicate:predicate];
    if([entities count] > 0){
        entity = [entities objectAtIndex:0];
    }
    return entity;
}

+ (Car *) findOneByCarMajor:(NSNumber *) CarMajor{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"major == %@",CarMajor]];
    Car *entity = nil;
    NSArray *entities = [Car MR_findAllWithPredicate:predicate];
    if([entities count] > 0){
        entity = [entities objectAtIndex:0];
    }
    return entity;
}

+ (void) printData{
    
}

+ (id) addToDatabase:(NSDictionary *) properties{
    [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"Adding to Car Table.."]];
    NSNumber *contentId = [properties objectForKey:@"id"];
    Car *entityCar = [self findOneById:contentId];
    if(entityCar == nil){
        NSManagedObjectContext *moc = [NSManagedObjectContext MR_contextForCurrentThread];
        entityCar = [Car MR_createInContext:moc];
        [self creatingModel:entityCar andProperties:properties];
        [moc MR_saveToPersistentStoreAndWait];
    }
    return entityCar;
}

+ (id) updateRecord:(NSDictionary *) properties{
    [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"Updating Cars Table.."]];
    NSManagedObjectContext *moc = [NSManagedObjectContext MR_contextForCurrentThread];
    Car *entityCar = [self findOneById:[properties objectForKey:@"id"]];
    if(entityCar == nil){
        entityCar = [Car MR_createInContext:moc];
    }
    [self creatingModel:entityCar andProperties:properties];
    [moc MR_saveToPersistentStoreAndWait];
    return entityCar;
}

+ (void) deleteRecord:(NSDictionary *) properties{
    NSString *entityId = [properties objectForKey:@"id"];
    [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"Deleting Car with id  %@",entityId]];
    NSManagedObjectContext *moc = [NSManagedObjectContext MR_contextForCurrentThread];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"CarId== %@",entityId]];
    [Car MR_deleteAllMatchingPredicate:predicate inContext:moc];
    [moc MR_saveToPersistentStoreAndWait];
}

+ (void) creatingModel:(Car *) entity andProperties:(NSDictionary *) properties{
    entity.carId = [properties objectForKey:@"id"];
    entity.carMake = [AOBBaseMapper getValueOfField:[properties objectForKey:@"make"] andAssigningField:entity.carMake];
    entity.carModel= [AOBBaseMapper getValueOfField:[properties objectForKey:@"model"] andAssigningField:entity.carModel];
    entity.beacon_major = [AOBBaseMapper convertStringToNumber:[properties objectForKey:@"beacon_major"]];
    entity.intro_video_id = [AOBBaseMapper getValueOfField:[properties objectForKey:@"intro_video_id"] andAssigningField:entity.intro_video_id];
    entity.carDescription = [AOBBaseMapper getValueOfField:[properties objectForKey:@"description"] andAssigningField:entity.carDescription];
    entity.layout = [AOBBaseMapper getValueOfField:[properties objectForKey:@"layout"] andAssigningField:entity.layout];
    entity.fuel_type = [AOBBaseMapper getValueOfField:[properties objectForKey:@"fuel_type"] andAssigningField:entity.fuel_type];
    entity.gearing = [AOBBaseMapper getValueOfField:[properties objectForKey:@"gearing"] andAssigningField:entity.gearing];
}


@end
