//
//  AOBConfig.m
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "AOBConfig.h"

@implementation AOBConfig

NSString * const kBackgroundColor = @"#ffffff";
NSString * const kButtonBackgroundColor = @"#e1e1e1";
NSString * const kFontColour = @"#0494d1";
NSString * const kBorderColour = @"#6b6c6e";
NSString * const kApiUrl = @"http://192.168.225.29:4000/api/";
NSInteger  const kFlickerDelay = 1;
NSInteger const kTimesDiscovered = 3;
float  const kAccelerationThreshold = 1.80;
NSString * const kBluetoothIsOff = @"Bluetooth is off";
NSString * const kBeaconUUID = @"BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB";
NSString * const kBeaconStartDetection = @"Finding nearest car..";
NSString * const kNoYoutubeLinkAvailable = @"There is not video available";
NSString * const kLoadingYoutubeVideo = @"Loading video..";

@end
