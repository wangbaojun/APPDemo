//
//  HHPointHUD.m
//  HomeHome
//
//  Created by Victor on 16/1/5.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "HHPointHUD.h"

@implementation HHPointHUD


+ (void)showErrorWithTitle:(NSString *)title
{
    [LCProgressHUD showFailure:title];
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(hideHUD)
                                   userInfo:nil
                                    repeats:NO];
}

+ (void)showMessageWithTitle:(NSString *)title time:(NSInteger)time
{
    [LCProgressHUD showMessage:title];
    
    if (time == 0) {
        time = 0.5;
    }
    
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(hideHUD)
                                   userInfo:nil
                                    repeats:NO];
}

+ (void)hideHUD
{
    [LCProgressHUD hide];
}

+ (void)showSuccessWithTitle:(NSString *)title
{
    [LCProgressHUD showSuccess:title];
}

+ (void)showWaitViewWithTitle:(NSString *)title
{
    [LCProgressHUD showLoading:title];
}

@end
