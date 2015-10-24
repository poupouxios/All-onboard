//
//  UITableView+iOS7TableTopSeparator.m
//  iOS7-TableTopSeparator
//
//  Created by Yasuhiro Inami on 2013/11/28.
//  Copyright (c) 2013年 Yasuhiro Inami. All rights reserved.
//

#import "UITableView+iOS7TableTopSeparator.h"
#import "JRSwizzle.h"
#import <objc/runtime.h>

#define IS_IOS_AT_LEAST(ver)    ([[[UIDevice currentDevice] systemVersion] compare:ver] != NSOrderedAscending)

#if defined(__IPHONE_7_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
#define IS_FLAT_DESIGN          IS_IOS_AT_LEAST(@"7.0")
#else
#define IS_FLAT_DESIGN          NO
#endif

static const char __showsTopSeparatorKey;
static const char __topSeparatorViewKey;


@implementation UITableView (iOS7TableTopSeparator)

+ (void)load
{
    [UITableView jr_swizzleMethod:@selector(reloadData)
                       withMethod:@selector(iOS7TableTopSeparator_reloadData)
                            error:NULL];
    
    //
    // TODO: check for insert/delete/reload/move methods & swizzle if necessary
    //
}

- (void)iOS7TableTopSeparator_reloadData
{
    [self iOS7TableTopSeparator_reloadData];
    
    if (!IS_FLAT_DESIGN) return;
    
    [self _removeTopSeparatorViewIfPossible];
    [self _addTopSeparatorViewIfPossible];
}

- (void)_removeTopSeparatorViewIfPossible
{
    if (self.iOS7TopSeparatorView) {
        [self.iOS7TopSeparatorView removeFromSuperview];
        [self _setIOS7TopSeparatorView:nil];
    }
}

- (void)_addTopSeparatorViewIfPossible
{
    if (!self.showsIOS7TopSeparator) return;
    if (self.style == UITableViewStyleGrouped) return;
    if ([self numberOfSections] == 0) return;
    if ([self numberOfRowsInSection:0] == 0) return;
    
    CGRect frame = CGRectMake(0, [self rectForSection:0].origin.y-0.5, self.bounds.size.width, 0.5);
    frame = UIEdgeInsetsInsetRect(frame, self.separatorInset);
    
    UIView* topSeparatorView = [[UIView alloc] initWithFrame:frame];
    topSeparatorView.backgroundColor = self.separatorColor;
    topSeparatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:topSeparatorView];
    
    [self _setIOS7TopSeparatorView:topSeparatorView];
}

#pragma mark -

#pragma mark Accessors

- (BOOL)showsIOS7TopSeparator
{
    BOOL shows = [objc_getAssociatedObject(self, &__showsTopSeparatorKey) boolValue];
    return shows;
}

- (void)setShowsIOS7TopSeparator:(BOOL)shows
{
    objc_setAssociatedObject(self, &__showsTopSeparatorKey, @(shows), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView*)iOS7TopSeparatorView
{
    UIView* topSeparatorView = objc_getAssociatedObject(self, &__topSeparatorViewKey);
    return topSeparatorView;
}

- (void)_setIOS7TopSeparatorView:(UIView*)topSeparatorView
{
    objc_setAssociatedObject(self, &__topSeparatorViewKey, topSeparatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

#pragma mark Install

+ (void)installIOS7TableTopSeparator
{
    [UITableView jr_swizzleMethod:@selector(initWithFrame:style:)
                       withMethod:@selector(iOS7TableTopSeparator_initWithFrame:style:)
                            error:NULL];
    
    [UITableView jr_swizzleMethod:@selector(initWithCoder:)
                       withMethod:@selector(iOS7TableTopSeparator_initWithCoder:)
                            error:NULL];
}

- (id)iOS7TableTopSeparator_initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    typeof(self) self2 = [self iOS7TableTopSeparator_initWithFrame:frame style:style];
    self2.showsIOS7TopSeparator = YES;
    return self2;
}

- (id)iOS7TableTopSeparator_initWithCoder:(NSCoder *)aDecoder
{
    typeof(self) self2 = [self iOS7TableTopSeparator_initWithCoder:aDecoder];
    self2.showsIOS7TopSeparator = YES;
    return self2;
}

@end
