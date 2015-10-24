//
//  NSArray+LSCArrayAdditions.h
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (LSCArrayAdditions)

+ (NSArray *) sortArray:(NSArray *)unsortedArray BasedOnObjectAttributeStringName:(NSString *) attribute;

@end
