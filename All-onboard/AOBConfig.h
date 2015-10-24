//
//  AOBConfig.h
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AOBConfig : NSObject

extern NSString * const kBackgroundColor;
extern NSString * const kButtonBackgroundColor;
extern NSString * const kFontColour;
extern NSString * const kBorderColour;
extern NSString * const kApiUrl;
extern NSInteger  const kFlickerDelay;
extern NSInteger  const kTimesDiscovered;
extern float const kAccelerationThreshold;
extern NSString * const kBluetoothIsOff;
extern NSString * const kBeaconUUID;
extern NSString * const kBeaconStartDetection;
extern NSString * const kNoYoutubeLinkAvailable;
extern NSString * const kLoadingYoutubeVideo;

@end
