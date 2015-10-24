//
//  LSCGeneralHelpersCoreLibraries.h
//  Situate
//
//  Created by Valentinos Papasavvas on 28/07/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#ifndef IS_PRODUCTION
    #ifdef DEBUG
        #define IS_PRODUCTION 0
    #else
        #define IS_PRODUCTION 1
    #endif
#endif

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_LATER_THAN_IOS7    ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0)
#define IS_OS_7    ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_OS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

#import <Foundation/Foundation.h>
#import "LSCLoggingWrapper.h"
#import "LSCOperatingSystemInfo.h"
#import "LSCUIDeviceIdentifier.h"
#import "LSCDeviceDetails.h"
#import "UIImageView+LSCImageViewAdditions.h"
#import "UIView+LSCUIViewAdditions.h"
#import "UISlider+SliderTouchPoint.h"
#import "NSString+LSCStringAdditions.h"
#import "UILabel+LSCLabelAdditions.h"
#import "NSURL+LSCURLAdditions.h"
#import "LSCDeviceDetails.h"
#import "UIImage+LLMImageAdditions.h"
#import "NSArray+LSCArrayAdditions.h"
#import "LSCConnectivityManager.h"
#import "FUIButton+LSCButtonStyle.h"
#import "UITableViewCell+LLMTableCellAdditions.h"

@interface LSCGeneralHelpersCoreLibraries : NSObject

@end
