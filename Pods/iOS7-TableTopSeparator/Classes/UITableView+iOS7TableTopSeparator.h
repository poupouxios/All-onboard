//
//  UITableView+iOS7TableTopSeparator.h
//  iOS7-TableTopSeparator
//
//  Created by Yasuhiro Inami on 2013/11/28.
//  Copyright (c) 2013年 Yasuhiro Inami. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (iOS7TableTopSeparator)

@property (nonatomic) BOOL showsIOS7TopSeparator;
@property (nonatomic, readonly) UIView* iOS7TopSeparatorView;

+ (void)installIOS7TableTopSeparator;   // sets showsIOS7TopSeparator=YES on UITableView-init

@end
