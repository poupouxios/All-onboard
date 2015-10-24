//
//  LSCUIDeviceIdentifier.m
//  Situate
//
//  Created by Valentinos Papasavvas on 21/11/2014.
//  Copyright (c) 2014 Llamadigital. All rights reserved.
//

#import "LSCUIDeviceIdentifier.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation LSCUIDeviceIdentifier

+ (NSString *) platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+ (BOOL) isBluetoothLowEnergySupported{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return NO;
    if ([platform isEqualToString:@"iPhone1,2"])    return NO;
    if ([platform isEqualToString:@"iPhone2,1"])    return NO;
    if ([platform isEqualToString:@"iPhone3,1"])    return NO;
    if ([platform isEqualToString:@"iPhone3,3"])    return NO;
    if ([platform isEqualToString:@"iPod1,1"])      return NO;
    if ([platform isEqualToString:@"iPod2,1"])      return NO;
    if ([platform isEqualToString:@"iPod3,1"])      return NO;
    if ([platform isEqualToString:@"iPod4,1"])      return NO;
    if ([platform isEqualToString:@"iPad1,1"])      return NO;
    if ([platform isEqualToString:@"iPad2,1"])      return NO;
    if ([platform isEqualToString:@"iPad2,2"])      return NO;
    if ([platform isEqualToString:@"iPad2,3"])      return NO;
    if ([platform isEqualToString:@"i386"])         return NO;
    if ([platform isEqualToString:@"x86_64"])       return NO;
    return YES;
}

+ (NSString *) getDeviceCode{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 568){
            return @"i-568";
        }else{
            return @"i-2x";
        }
    }else{
        return @"i-2x";
    }
}

+ (BOOL) isIpad{
    if ( [(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"] ) {
        return YES;
    }
    return NO;
}

+ (BOOL) isIphone{
    if ( [(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPhone"] ) {
        return YES;
    }
    return NO;
}


+ (BOOL) isIphone6Plus{
    CGFloat greaterPixelDimension = (CGFloat) fmaxf(((float)[[UIScreen mainScreen]bounds].size.height),
                                                    ((float)[[UIScreen mainScreen]bounds].size.width));
    
    switch ((NSInteger)greaterPixelDimension) {
        case 736:
            return YES;
        default:
            return NO;
    }
}


@end
