//
//  UISlider+SliderTouchPoint.m
//  Situate
//
//  Created by Valentinos Papasavvas on 09/06/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import "UISlider+SliderTouchPoint.h"

@implementation UISlider (SliderTouchPoint)

- (BOOL)pointInside:(CGPoint)point withDX:(float)dX andDY:(float)dY andwithEvent:(UIEvent*)event {
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, dX, dY);
    return CGRectContainsPoint(bounds, point);
}

@end
