//
//  LSCOperatingSystemInfo.h
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSCOperatingSystemInfo : NSObject

+ (BOOL) isiOS7;
+ (BOOL) isIOS8;
+ (BOOL) isLaterThaniOS7;
+ (BOOL)isIOS9;

@end
