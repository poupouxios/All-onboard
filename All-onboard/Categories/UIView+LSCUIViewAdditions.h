//
//  UIView+LLMUIViewAdditions.h
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LSCUIViewAdditions)

- (void)sizeToFitWithAlignmentCenter:(CGRect)mainViewFrame;
- (void) adjustWidthOfObjectToBeTheSameLikeScroller:(CGRect)mainViewFrame andAlignCenter:(BOOL)allowCenterAlignment;

@end
