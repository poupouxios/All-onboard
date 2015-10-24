//
//  AOBBaseVIewHelper.h
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AOBBaseVIewHelper : NSObject

+ (void) setAlertWithOkButton:(NSString *)warningMessage andAlertDelegate:(id)sender andTag:(NSInteger)alertTag  andTitle:(NSString *)alertTitle;

@end
