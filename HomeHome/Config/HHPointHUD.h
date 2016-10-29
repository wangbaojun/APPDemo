//
//  HHPointHUD.h
//  HomeHome
//
//  Created by Victor on 16/1/5.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SeletedSheetButtonIndex)(NSInteger Buttonindex);



@interface HHPointHUD : NSObject

/**
 *  提示文字
 */
+ (void)showMessageWithTitle:(NSString *)title time:(NSInteger)time;


/**
 *  错误提示
 */
+ (void)showErrorWithTitle:(NSString *)title;

/**
 *  成功提示
 */
+ (void)showSuccessWithTitle:(NSString *)title;

/**
 *  等待框
 */
+ (void)showWaitViewWithTitle:(NSString *)title;


+ (void)hideHUD;


@end
