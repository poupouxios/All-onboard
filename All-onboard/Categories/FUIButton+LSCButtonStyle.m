//
//  FUIButton+LLMButtonStyle.m
//  Situate
//
//  Created by Valentinos Papasavvas on 26/03/2015.
//  Copyright (c) 2015 Llamadigital. All rights reserved.
//

#import "FUIButton+LSCButtonStyle.h"

@implementation FUIButton (LSCButtonStyle)

- (void) applyFlatDesignForUIButton{
    self.buttonColor = [UIColor colorFromHexString:kButtonBackgroundColor];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.layer.cornerRadius = 5.0f;
    self.layer.borderColor = [[UIColor colorFromHexCode:kBorderColour]CGColor];
    self.layer.borderWidth = 2.0f;
    
    [self setTitleColor:[UIColor colorFromHexString:kFontColour] forState:UIControlStateNormal];
}

@end
