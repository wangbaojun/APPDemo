//
//  HHAppDelegate.h
//  HomeHome
//
//  Created by Victor on 16/1/5.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@interface HHAppDelegate : UIResponder<UIApplicationDelegate,MWPhotoBrowserDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic)UIViewController * viewController;

+ (UINavigationController *)rootNavigationController;

@end
