//
//  AOBYoutubeViewController.h
//  All-onboard
//
//  Created by Valentinos Papasavvas on 24/10/2015.
//  Copyright © 2015 Llamadigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AOBYoutubeViewController : UIViewController

@property (nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property (nonatomic,strong) NSString *youtubeId;

@end
