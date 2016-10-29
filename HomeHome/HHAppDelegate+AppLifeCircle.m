//
//  HHAppDelegate+AppLifeCircle.m
//  HomeHome
//
//  Created by Victor on 16/3/4.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "HHAppDelegate+AppLifeCircle.h"
#import "UMSocial.h"
#import "HHApi.h"
#import "VTJpushTools.h"
#import <AlipaySDK/AlipaySDK.h>
#import "SZMessageViewController.h"

@implementation HHAppDelegate (AppLifeCircle)


-(void)applicationDidEnterBackground:(UIApplication *)application{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{//收到本地通知
    //[VTJpushTools showLocalNotificationAtFront:notification];
    application.applicationIconBadgeNumber = 0;
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"通知推送错误为: %@", error);
}


#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
     [VTJpushTools handleRemoteNotification:userInfo completion:completionHandler];
    [SZNotificationCenter postNotificationName:@"GETNotifation" object:nil];
    [SZUserDefault setBool:YES forKey:@"GETNotifation"];
    [SZUserDefault synchronize];
    
    NSString *flag = [userInfo valueForKey:@"flag"];
    NSString *url = [userInfo valueForKey:@"url"];
    RDVTabBarController *tabbar = (RDVTabBarController *)self.viewController;
    
    if (application.applicationState == UIApplicationStateActive)
    {
        
    }
    else
    {
       
        [JPUSHService handleRemoteNotification:userInfo];
    }
    return;
}
#endif


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{//6.0收到通知
    [VTJpushTools handleRemoteNotification:userInfo completion:nil];
    application.applicationIconBadgeNumber = 0;
    
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [VTJpushTools registerDeviceToken:deviceToken];
    NSString *pushToken = [[[[deviceToken description]stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]                           stringByReplacingOccurrencesOfString:@" " withString:@""];
    [SZUserDefault setObject:pushToken forKey:@"deviceToken"];
    
}

- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{//禁止横屏
    return UIInterfaceOrientationMaskPortrait;
}
#pragma mark - App挑选回调
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([url.description hasPrefix:@""]) {
        //课程分享出去的链接打开应用
        return YES;
        
    }else{
        return  [UMSocialSnsService handleOpenURL:url];
    }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
    if ([url.host isEqualToString:@"safepay"]) {
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"支付result = %@",resultDic);
            
        }];
    }
    
    
    if([url.host isEqualToString:@"alipayclient"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"支付result = %@",resultDic);
            
        }];
    }
    
    
    
    if ([url.description hasPrefix:@"mingsi:"]) {
        
        NSString * courseId = [[url.description componentsSeparatedByString:@"id="] lastObject];
        
        //课程分享出去的链接打开应用并跳转到课程详情页面
        RDVTabBarController *tabbar = (RDVTabBarController *)self.viewController;
        tabbar.selectedIndex = 3;
        //如果程序没有启动,界面是接收不到通知的,从而无法跳转
        [SZUserDefault setObject:@{@"courseId":courseId} forKey:@"sharedCourseID"];
        [SZUserDefault synchronize];
        
        //如果程序启动,而且在后台(页面不会走viewWillAppear方法),发送通知
        [SZNotificationCenter postNotificationName:@"shareCourse" object:@{@"courseId":courseId}];
    }else{
        return  [UMSocialSnsService handleOpenURL:url];
    }
    
    return YES;
    
}
@end
