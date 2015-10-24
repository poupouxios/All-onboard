//
//  LLMDeviceDetails.h
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LLMOrientation)
{
    LLMPortrait,
    LLMLandscape
};

@interface LSCDeviceDetails : NSObject

+ (CGFloat) getScreenHeight;
+ (CGFloat) getScreenWidth;
+ (LLMOrientation) getDeviceOrientation;
+ (CGSize) getDimensionsOfDevice;
+ (NSString *) getUniqueIdentifier;

@end
