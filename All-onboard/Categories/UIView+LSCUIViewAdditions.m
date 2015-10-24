//
//  UIView+LLMUIViewAdditions.m
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import "UIView+LSCUIViewAdditions.h"

@implementation UIView (LSCUIViewAdditions)


- (void)sizeToFitWithAlignmentCenter:(CGRect)mainViewFrame{
    CGRect afterFrame = self.frame;
    self.frame = CGRectMake((mainViewFrame.size.width - afterFrame.size.width) / 2, afterFrame.origin.y, afterFrame.size.width, afterFrame.size.height);
}

- (void) adjustWidthOfObjectToBeTheSameLikeScroller:(CGRect)mainViewFrame andAlignCenter:(BOOL)allowCenterAlignment{
    CGRect beforeFrame = self.frame;
    self.frame = CGRectMake(beforeFrame.origin.x, beforeFrame.origin.y, mainViewFrame.size.width-10, beforeFrame.size.height);
    
    if(allowCenterAlignment) {
        [self sizeToFitWithAlignmentCenter:mainViewFrame];
    }
}

@end
