//
//  LSCOperatingSystemInfo.m
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import "LSCOperatingSystemInfo.h"

@implementation LSCOperatingSystemInfo

+ (BOOL)isiOS7{
    if(IS_OS_7){
        return true;
    }else{
        return false;
    }
}

+ (BOOL) isLaterThaniOS7{
    if(IS_LATER_THAN_IOS7){
        return true;
    }else{
        return false;
    }
}

+ (BOOL)isIOS8{
    if(IS_OS_8_OR_LATER) {
        return true;
    }else{
        return false;
    }
}

+ (BOOL)isIOS9{
    if(IS_OS_9_OR_LATER) {
        return true;
    }else{
        return false;
    }
}


@end
