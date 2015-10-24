//
//  LSCUIDeviceIdentifier.h
//  Situate
//
//  Created by Valentinos Papasavvas on 21/11/2014.
//  Copyright (c) 2014 Llamadigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSCUIDeviceIdentifier : NSObject

+ (NSString *) platform;
+ (BOOL) isBluetoothLowEnergySupported;
+ (NSString *) getDeviceCode;
+ (BOOL) isIpad;
+ (BOOL) isIphone6Plus;

@end
