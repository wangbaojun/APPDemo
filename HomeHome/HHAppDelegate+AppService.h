//
//  HHAppDelegate+AppService.h
//  HomeHome
//
//  Created by Victor on 16/3/4.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "HHAppDelegate.h"

@interface HHAppDelegate (AppService)


/**
 *  进入图片浏览器
 */
//- (void)phontoBroserPush:(NSNotification *)note;

/**
 *  bug日志反馈
 */
- (void)registerBugly;

/**
 *  基本配置
 */
- (void)configurationLaunchUserOption;

/**
 *  友盟注册
 */
- (void)registerUmeng;
/**
 *  Mob注册
 */

- (void)registerMob;

/**
 *  检查更新
 */
- (void)checkAppUpDataWithshowOption:(BOOL)showOption;

/**
 *  上传用户设备信息
 */
- (void)upLoadMessageAboutUser;

/**
 *  检查黑名单用户
 */
-(void)checkBlack;

@end
