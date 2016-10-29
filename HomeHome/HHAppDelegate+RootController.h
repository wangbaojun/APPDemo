//
//  HHAppDelegate+RootController.h
//  HomeHome
//
//  Created by Victor on 16/3/4.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "HHAppDelegate.h"

@interface HHAppDelegate (RootController)
/**
 *  首次启动轮播图
 */
- (void)createLoadingScrollView;
/**
 *  tabbar实例
 */
- (void)setTabbarController;

/**
 *  window实例
 */
- (void)setAppWindows;

/**
 *  根视图
 */
- (void)setRootViewController;

@end
