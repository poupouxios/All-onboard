//
//  AOBBaseVIewHelper.m
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "AOBBaseVIewHelper.h"

@implementation AOBBaseVIewHelper

+ (void) setAlertWithOkButton:(NSString *)warningMessage andAlertDelegate:(id)sender andTag:(NSInteger)alertTag  andTitle:(NSString *)alertTitle{
    FUIAlertView *av = [[FUIAlertView alloc] initWithTitle:alertTitle message:warningMessage delegate:sender cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [av applyFlatDesignForUIAlert:kBackgroundColor andBackgroundColour:kBorderColour andSecondaryColour:kButtonBackgroundColor andFontColour:kFontColour];
    av.tag = alertTag;
    [av show];
}

@end

