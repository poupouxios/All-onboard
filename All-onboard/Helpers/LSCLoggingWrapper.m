//
//  LLMLoggingWrapper.m
//  Situate
//
//  Created by Valentinos Papasavvas on 16/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import "LSCLoggingWrapper.h"

@implementation LSCLoggingWrapper

+ (void)outputMessage:(NSString *)message{
    
    if(IS_PRODUCTION == 0){
        NSLog(@"%@",message);
    }
}


@end
