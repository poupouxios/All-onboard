//
//  LSCImageEntityMapper.m
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//


#import "AOBImageEntityMapper.h"

@implementation AOBImageEntityMapper

+ (NSArray *)findAll{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSArray *cis = [ImageEnt MR_findAll];
    for (ImageEnt *entityItem  in cis) {
        [results addObject:entityItem];
    }
    return results;
}

+ (ImageEnt *)findOneByImageName:(NSString *)imageName{
    if(imageName == nil){
        return nil;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"imageName == '%@'",imageName]];
    ImageEnt *entity = nil;
    NSArray *entities = [ImageEnt MR_findAllWithPredicate:predicate];
    if([entities count] > 0){
        entity = [entities objectAtIndex:0];
    }
    return entity;
}

+ (id) addToDatabase:(NSDictionary *) properties{
    [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"Adding to ImageEntity Table.."]];
    NSString *imageName = [properties objectForKey:@"imageName"];
    ImageEnt *entityItem = [self findOneByImageName:imageName];
    if(entityItem == nil){
        NSManagedObjectContext *moc = [NSManagedObjectContext MR_contextForCurrentThread];
        entityItem = [ImageEnt MR_createInContext:moc];
        [self creatingModel:entityItem andProperties:properties];
        [moc MR_saveToPersistentStoreAndWait];
    }
    return entityItem;
}

+ (void) creatingModel:(ImageEnt *) entity andProperties:(NSDictionary *) properties{
    NSURL *imageUrl = [NSURL URLWithString:[properties objectForKey:@"imageUrl"]];
    entity.imageData = [NSData dataWithContentsOfURL:imageUrl];
    entity.imageFilename = [self getImageName:imageUrl];
}

+ (NSString *) getImageName:(NSURL *)imageUrl{
    NSString *fileExtension = [[[NSMutableString stringWithString:[imageUrl lastPathComponent]] componentsSeparatedByString:@"."] lastObject];
    NSString *fileName = [[[NSMutableString stringWithString:[imageUrl lastPathComponent]] componentsSeparatedByString:@"."] firstObject];
    return [NSString stringWithFormat:@"%@.%@",fileName,fileExtension];
}


+ (ImageEnt *) generateImage:(NSString *)imageUrl{
    ImageEnt *entityImage = nil;
    [LSCLoggingWrapper outputMessage:[NSString stringWithFormat:@"Adding image = %@",imageUrl]];
    if(![imageUrl isEqual:[NSNull null]] && imageUrl.length > 0){
        entityImage = [AOBImageEntityMapper addToDatabase:@{@"imageUrl":[NSString stringWithFormat:@"%@/%@",kApiUrl,imageUrl]}];
    }
    return entityImage;
}

@end
