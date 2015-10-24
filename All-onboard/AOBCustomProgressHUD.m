//
//  CustomProgressHUD.m
//  OQD Express Mobile
//
//  Created by Valentinos Papasavvas on 07/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "AOBCustomProgressHUD.h"

@interface AOBCustomProgressHUD()

@end

@implementation AOBCustomProgressHUD

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithView:(UIView *)mainView andMessage:(NSString *)message andHudMode:(MBProgressHUDMode)hudMode andDisplayButton:(BOOL)shouldDisplayButton{
    self = [super initWithView:mainView];
    
    if (self) {
        self.dimBackground = true;
        self.labelText = message;
        self.mode = hudMode;
        [mainView addSubview:self];
        if(shouldDisplayButton){
            self.buttonTitle = @"Cancel";
            self.buttonTitleColor = [UIColor colorFromHexString:@"#aaaaaa"];
        }

    }
    
    return self;
}

@end
