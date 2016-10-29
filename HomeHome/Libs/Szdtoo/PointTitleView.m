//
//  PointTitleView.m
//  SZDT_Partents
//
//  Created by szdt on 15/5/13.
//  Copyright (c) 2015年 szdt. All rights reserved.
//

#import "PointTitleView.h"

#import "DMCAlertCenter.h"
@implementation PointTitleView
//
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super init];
//    if (self)
//    {
//        
//    }
//    return self;
//}
//
//+ (PointTitleView *)shareInstance
//{
//    static PointTitleView *shareInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        shareInstance = [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    });
//    return shareInstance;
//}
/**
 *  自动消失的提示消息
 *
 *  @param title 消息名
 */

+ (void)showPointWithTitle:(NSString *)title
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[DMCAlertCenter defaultCenter]postAlertWithMessage:title];
    });
    
//    UIWindow * window = [UIApplication sharedApplication].keyWindow;
//    UIView *showview =  [[UIView alloc]init];
//    showview.backgroundColor = [UIColor blackColor];
//    showview.frame = CGRectMake(1, 1, 1, 1);
//    showview.alpha = 1.0f;
//    showview.layer.cornerRadius = 5.0f;
//    showview.layer.masksToBounds = YES;
//    [window addSubview:showview];
//    
//    UILabel *label = [[UILabel alloc]init];
//    CGSize LabelSize = [title sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
//    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
//    label.text = (NSString *)title;
//    label.textColor = [UIColor whiteColor];
//    label.textAlignment = 1;
//    label.backgroundColor = [UIColor clearColor];
//    label.font = [UIFont boldSystemFontOfSize:15];
//    [showview addSubview:label];
//    showview.frame = CGRectMake((kScreenW - LabelSize.width - 20)/2, kScreenH - 100, LabelSize.width+20, LabelSize.height+10);
//    [UIView animateWithDuration:1.5 animations:^{
//        showview.alpha = 0;
//    } completion:^(BOOL finished) {
//        [showview removeFromSuperview];
//    }];
    
    
}

@end
