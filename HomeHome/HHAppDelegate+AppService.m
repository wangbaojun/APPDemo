//
//  HHAppDelegate+AppService.m
//  HomeHome
//
//  Created by Victor on 16/3/4.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "HHAppDelegate+AppService.h"
#import "JPUSHService.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"

#import <Bugly/CrashReporter.h>
 #import <SMS_SDK/SMSSDK.h>
@interface HHAppDelegate ()<UIAlertViewDelegate>

@end

@implementation HHAppDelegate (AppService)


- (void)registerBugly
{
    [[CrashReporter sharedInstance] enableLog:YES];
    [[CrashReporter sharedInstance] installWithAppId:CrashReportAppKey];
    [[CrashReporter sharedInstance] setBlockMonitorJudgementLoopTimeout:10];
    [[CrashReporter sharedInstance]setUserId:[NSString stringWithFormat:@"schoolID=%@,userId%@,userType=%@",[HHUserInfo getSchoolId],[HHUserInfo getUserId],[HHUserInfo getUserType]]];
}

- (void)configurationLaunchUserOption
{
    
    NSString *schoolId = [[[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SchoolConfig.plist" ofType:nil]] objectForKey:@"SchoolId"];
    NSString *versonNum = [[[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SchoolConfig.plist" ofType:nil]] objectForKey:@"VersionNum"];//VersionNum
    [SZUserDefault setObject:[JPUSHService registrationID] forKey:@"registrationId"];
    [SZUserDefault setObject:schoolId forKey:@"schoolId"];
    [SZUserDefault setObject:versonNum forKey:@"VersionNum"];
    [SZUserDefault synchronize];
}

- (void)registerMob
{
    [SMSSDK registerApp:SMSMobAppKeyTest
             withSecret:SMSMobAppSecretTest];
}

- (void)registerUmeng
{
    [UMSocialData setAppKey:UmengAppKey];
    [UMSocialQQHandler setQQWithAppId:ShareQQAppID appKey:ShareQQAppKey url:@"http://xiaozhangkeji.szdtoo.com.cn"];
    [UMSocialWechatHandler setWXAppId:WetChatAppId appSecret:WetChatAppSecret url:@"http://xiaozhangkeji.szdtoo.com.cn"];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
}

-(void)checkBlack
{
    
}


- (void)upLoadMessageAboutUser
{

}

- (void)checkAppUpDataWithshowOption:(BOOL)showOption
{
   
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 400)
    {
        [HHUserInfo clearUserInfo];
        [[self.viewController rdv_tabBarController]setTabBarHidden:YES animated:YES];
        //VersionTwoLoginViewController *log=[[VersionTwoLoginViewController alloc]init];
      //  UINavigationController *login=[[UINavigationController alloc]initWithRootViewController:log];
//        [self.viewController presentViewController:login animated:YES completion:nil];
    }
    if (alertView.tag == 401)
    {
        //跳绑定列表
        [HHUserInfo refreshUserMessageWithKey:@"stuId" value:@""];
        [[self.viewController rdv_tabBarController]setTabBarHidden:YES animated:YES];
     //   VersionTwoLoginViewController *log=[[VersionTwoLoginViewController alloc]init];
       // [self.viewController.navigationController pushViewController:log animated:YES];
    }
    
}

@end
