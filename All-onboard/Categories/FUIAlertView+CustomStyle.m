//
//  FUIAlertView+CustomStyle.m
//  OQD Express Mobile
//
//  Created by Valentinos Papasavvas on 08/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "FUIAlertView+CustomStyle.h"

@implementation FUIAlertView (CustomStyle)

- (void) applyFlatDesignForUIAlert:(NSString *)primaryColour
               andBackgroundColour:(NSString *)backgroundColour
                andSecondaryColour:(NSString *)secondaryColour
                     andFontColour:(NSString *)fontColour{
    self.defaultButtonTitleColor = [UIColor colorFromHexString:fontColour];
    self.titleLabel.textColor = [UIColor colorFromHexString:fontColour];
    self.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    self.messageLabel.textColor = [UIColor colorFromHexString:fontColour];
    self.messageLabel.font = [UIFont flatFontOfSize:14];
    self.backgroundOverlay.backgroundColor = [[UIColor colorFromHexString:backgroundColour] colorWithAlphaComponent:0.7];
    
    self.alertContainer.backgroundColor = [UIColor colorFromHexString:primaryColour];
    
    self.defaultButtonColor = [UIColor colorFromHexString:secondaryColour];
    self.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    self.defaultButtonShadowHeight = 0.0f;
}

@end
