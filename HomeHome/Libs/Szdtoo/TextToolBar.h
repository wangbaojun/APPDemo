//
//  TextToolBar.h
//  HomeHome
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendBtnClickDelegate <NSObject>

-(void)sendSongThing:(NSString *)content;

@end

@interface TextToolBar : UIView
@property (nonatomic,strong)id<SendBtnClickDelegate>btnClick_delegate;
@property (nonatomic,assign)BOOL isLogin;
-(void)configBar:(BOOL)isLogin;
@end
