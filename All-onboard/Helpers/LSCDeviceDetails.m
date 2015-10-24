//
//  LLMDeviceDetails.m
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import "LSCDeviceDetails.h"

@implementation LSCDeviceDetails

+ (CGFloat) getScreenHeight{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.height;
}

+ (CGFloat) getScreenWidth{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect.size.width;
}

+ (NSString *) getUniqueIdentifier{
    NSUUID *userUUID = [[UIDevice currentDevice] identifierForVendor];
    return [userUUID UUIDString];
}

+ (LLMOrientation) getDeviceOrientation{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(orientation == 0){
        return LLMPortrait;
    }else if(orientation == UIInterfaceOrientationPortrait){
        return LLMPortrait;
    }else if(orientation == UIInterfaceOrientationLandscapeLeft){
        return LLMLandscape;
    }else if(orientation == UIInterfaceOrientationLandscapeRight){
        return LLMLandscape;
    }
    return LLMPortrait;
}

+ (CGSize) getDimensionsOfDevice{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    LLMOrientation orientation = [LSCDeviceDetails getDeviceOrientation];
    if(([LSCOperatingSystemInfo isLaterThaniOS7] || [LSCOperatingSystemInfo isiOS7]) && ![LSCOperatingSystemInfo isIOS8] && orientation == LLMLandscape){
        screenWidth = screenRect.size.height;
        screenHeight = screenRect.size.width;
    }
    return CGSizeMake(screenWidth, screenHeight);
}

@end
