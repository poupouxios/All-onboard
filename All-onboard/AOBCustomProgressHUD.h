//
//  AOBCustomProgressHUD.h
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import "MBProgressHUD.h"

@interface AOBCustomProgressHUD : MBProgressHUD

- (id)initWithView:(UIView *)mainView andMessage:(NSString *)message andHudMode:(MBProgressHUDMode)hudMode andDisplayButton:(BOOL)shouldDisplayButton;

@end
