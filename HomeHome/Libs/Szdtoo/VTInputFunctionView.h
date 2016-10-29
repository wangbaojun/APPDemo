//
//  VTInputFunctionView.h
//  TextField
//
//  Created by 杨胜超 on 15/5/20.
//  Copyright (c) 2015年 杨胜超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VTInputFunctionView;



@protocol VTInputFunctionViewDelegate <NSObject>

- (void)VTInputFunctionView:(VTInputFunctionView *)funcView sendMessage:(NSString *)message;

- (void)VTinputFunctionView:(VTInputFunctionView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second;

- (void)VTInputFunctionView:(VTInputFunctionView *)funcView sendVideo:(NSString *)fileUrl;
@end


@interface VTInputFunctionView : UIView<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UIButton *btnSendMessage;

@property (nonatomic,strong)UIButton *btnChangeVoiceState;

@property (nonatomic,strong)UIButton *sendButton;

@property (nonatomic,strong)UIButton *btnVoiceRecord;

@property (nonatomic,strong)UITextView *TextViewInput;

@property (nonatomic,assign)BOOL isAbleToSendTextMessage;



@property (nonatomic,strong)UIViewController *superVC;

@property (nonatomic,assign)id<VTInputFunctionViewDelegate>v_delegate;

- (id)initWithSuperVC:(UIViewController *)superVC;

- (id)initWithTwoSuperVC:(UIViewController *)superVC;

- (void)changeSendBtnWithPhoto:(BOOL)isPhoto;


@end
