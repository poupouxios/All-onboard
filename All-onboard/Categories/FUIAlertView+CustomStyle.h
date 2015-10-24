//
//  FUIAlertView+CustomStyle.h
//  OQD Express Mobile
//
//  Created by Valentinos Papasavvas on 08/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "FUIAlertView.h"

@interface FUIAlertView (CustomStyle)

- (void) applyFlatDesignForUIAlert:(NSString *)primaryColour
               andBackgroundColour:(NSString *)backgroundColour
                andSecondaryColour:(NSString *)secondaryColour
                     andFontColour:(NSString *)fontColour;
@end
