//
//  UISlider+SliderTouchPoint.h
//  Situate
//
//  Created by Valentinos Papasavvas on 09/06/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISlider (SliderTouchPoint)

- (BOOL)pointInside:(CGPoint)point withDX:(float)dX andDY:(float)dY andwithEvent:(UIEvent*)event;

@end
