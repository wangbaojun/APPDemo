//
//  VTJpushTools.m
//  SZDT_Partents
//
//  Created by szdt on 15/3/20.
//  Copyright (c) 2015年 szdt. All rights reserved.
//

#import "VTJpushTools.h"
#import "JPUSHService.h"
@implementation VTJpushTools
+ (void)setupWithOptions:(NSDictionary *)launchOptions {
    // ios8之后可以自定义category
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];    }
    
    // Required
    [JPUSHService setupWithOption:launchOptions appKey:JpushKey channel:@"Victor" apsForProduction:YES];
    return;
}

+ (void)registerDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
    return;
}

+ (void)handleRemoteNotification:(NSDictionary *)userInfo completion:(void (^)(UIBackgroundFetchResult))completion {
    [JPUSHService handleRemoteNotification:userInfo];

    if (completion) {
        completion(UIBackgroundFetchResultNewData);
    }
    return;
}

+ (void)showLocalNotificationAtFront:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
    return;
}


@end
