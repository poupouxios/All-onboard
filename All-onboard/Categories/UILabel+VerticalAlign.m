//
//  UILabel+VerticalAlign.m
//  Situate
//
//  Created by Valentinos Papasavvas on 15/08/2014.
//  Copyright (c) 2014 Llamadigital. All rights reserved.
//

#import "UILabel+VerticalAlign.h"

@implementation UILabel (VerticalAlign)

- (void)alignTop {
    CGRect tempRect = [self textRectForBounds:self.bounds limitedToNumberOfLines:999];
    CGRect f = self.frame;
    f.size.height = tempRect.size.height;
    self.frame = f;
    [self setNeedsDisplay];
    
}

@end
