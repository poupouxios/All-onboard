//
//  NSArray+LSCArrayAdditions.m
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import "NSArray+LSCArrayAdditions.h"

@implementation NSArray (LSCArrayAdditions)

+ (NSArray *) sortArray:(NSArray *)unsortedArray BasedOnObjectAttributeStringName:(NSString *) attribute{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:attribute ascending:YES];
    return [unsortedArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

@end
