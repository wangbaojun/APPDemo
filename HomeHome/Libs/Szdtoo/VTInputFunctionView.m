//
//  VTInputFunctionView.m
//  TextField
//
//  Created by 杨胜超 on 15/5/20.
//  Copyright (c) 2015年 杨胜超. All rights reserved.
//

#import "VTInputFunctionView.h"
#import "Mp3Recorder.h"
#import "UUProgressHUD.h"
#import "ACMacros.h"
//#import "MLSelectPhoto.h"
//#import "MLSelectPhotoAssets.h"
//#import "MLSelectPhotoPickerAssetsViewController.h"
//#import "MLSelectPhotoBrowserViewController.h"
#import "SCRecorder.h"
#import "SCRecordSessionManager.h"
#import "MBProgressHUD.h"
#import "WechatShortVideoConfig.h"
#import "WechatShortVideoController.h"
#define FRAME_HEIGHT 200
@interface VTInputFunctionView ()<UITextViewDelegate,Mp3RecorderDelegate,SCRecorderDelegate, SCAssetExportSessionDelegate, MBProgressHUDDelegate,WechatShortVideoDelegate>
{
    BOOL isbeginVoiceRecord;
    
    Mp3Recorder *MP3;
    
    NSInteger playTime;
    
    NSTimer *playTimer;
    
    NSMutableArray *_imageArr;
    
    UILabel *placeHold;
    
    UIScrollView *imageScrollView;
    
    
    
}



@property (nonatomic,strong)UIButton *sendAndAddButton;

@property (nonatomic,strong)UIButton *vtVoiceButton;

@property (nonatomic,strong)UIView *voiceView;

@property (nonatomic,strong)UIView *imageView;

//@property (nonatomic,strong)UIButton *sendButton;

@end


@implementation VTInputFunctionView


- (void)makeImageView
{
    //发视频
    self.imageView = [[UIView alloc]initWithFrame:CGRectMake(0, 300,Main_Screen_Width, 260)];
    self.imageView.userInteractionEnabled = YES;
    [self addSubview:self.imageView];
}


- (id)initWithTwoSuperVC:(UIViewController *)superVC
{
    self.superVC= superVC;
    
    CGRect frame = CGRectMake(0, Main_Screen_Height - 40, Main_Screen_Width, 300);
    self = [super initWithFrame:frame];
    if (self)
    {
        MP3 = [[Mp3Recorder alloc]initWithDelegate:self];
        _imageArr = [NSMutableArray arrayWithCapacity:0];
        self.backgroundColor = [UIColor colorWithRed:235/255.0 green:236/255.0 blue:238/255.0 alpha:1];
        //左边的语音输入框
        self.btnChangeVoiceState = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnChangeVoiceState.frame = CGRectMake(5, 5, 30, 30);
        isbeginVoiceRecord = NO;
        [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"callBack_voice_record"] forState:UIControlStateNormal];
        self.btnChangeVoiceState.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btnChangeVoiceState addTarget:self action:@selector(changeToVoice) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnChangeVoiceState];
        self.btnChangeVoiceState.selected = NO;
        
        //录像的按钮
        self.sendAndAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sendAndAddButton setImage:[UIImage imageNamed:@"callBack_video"] forState:UIControlStateNormal];
        self.sendAndAddButton.frame = CGRectMake(CGRectGetMaxX(self.btnChangeVoiceState.frame), 5, 40, 30);
        self.sendAndAddButton.layer.masksToBounds = YES;
        self.sendAndAddButton.layer.cornerRadius = 15;;
        self.sendAndAddButton.layer.borderWidth = 0.3;
        self.sendAndAddButton.layer.borderColor = [UIColor whiteColor].CGColor;
        self.sendAndAddButton.selected = NO;
        [self addSubview:self.sendAndAddButton];
        
        [self.sendAndAddButton addTarget:self action:@selector(btnAndAddButton) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.TextViewInput = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.sendAndAddButton.frame)+5, 5, Main_Screen_Width-70 - CGRectGetMaxX(self.sendAndAddButton.frame) - 5, 30)];
        self.TextViewInput.layer.cornerRadius = 4;
        self.TextViewInput.layer.masksToBounds = YES;
        self.TextViewInput.delegate = self;
        self.TextViewInput.layer.borderWidth = 1;
        self.TextViewInput.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
        [self addSubview:self.TextViewInput];
        self.TextViewInput.returnKeyType = UIReturnKeySend;
        
        //输入框的提示语
        placeHold = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 30)];
        placeHold.text = @"输入回复";
        placeHold.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
        [self.TextViewInput addSubview:placeHold];
        
        self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sendButton.frame = CGRectMake(Main_Screen_Width-60, 5, 50, 30);
        [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
        self.sendButton.titleLabel.font = [UIFont systemFontOfSize:13];
        self.sendButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:159/255.0 blue:238/255.0 alpha:1];
        self.sendButton.layer.masksToBounds = YES;
        self.sendButton.layer.cornerRadius = 3;
        [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.sendButton];
        
        //分割线
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
        
        [self makeVocieView];
        
        [self makeImageView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}


#pragma mark - keyboard.notification
- (void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        if (_imageArr.count == 0)
        {
            self.frame = CGRectMake(0, Main_Screen_Height-40-64, Main_Screen_Width, 40);
        }
        else
        {
            self.frame = CGRectMake(0, Main_Screen_Height-40-64-150, Main_Screen_Width, 200);
        }
        self.frame = CGRectMake(0, Main_Screen_Height-40-64-keyboardF.size.height, Main_Screen_Width, keyboardF.size.height);
    }];
}

- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        if (_imageArr.count == 0)
        {
            self.frame = CGRectMake(0, Main_Screen_Height-40-64, Main_Screen_Width, 40);
        }
        else
        {
            self.frame = CGRectMake(0, Main_Screen_Height-40-64-150, Main_Screen_Width, 200);
        }
        
    }];
}

- (void)makeVocieView
{
    
    self.voiceView = [[UIView alloc]initWithFrame:CGRectMake(0, 300,Main_Screen_Width, 260)];
    [self addSubview:self.voiceView];
    self.voiceView.userInteractionEnabled = YES;
    
    UILabel *voiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, Main_Screen_Width, 20)];
    voiceLabel.text = @"按住说话";
    voiceLabel.textColor = [UIColor lightGrayColor];
    voiceLabel.textAlignment = NSTextAlignmentCenter;
    [self.voiceView addSubview:voiceLabel];
    
    self.vtVoiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.vtVoiceButton.frame = CGRectMake((Main_Screen_Width - 120)/2, CGRectGetMaxY(voiceLabel.frame)+10, 120, 120);
    self.vtVoiceButton.layer.masksToBounds = YES;
    self.vtVoiceButton.layer.cornerRadius = 60;
    [self.vtVoiceButton setImage:[UIImage imageNamed:@"callBack_voice_recoder_white"] forState:UIControlStateNormal];
    self.vtVoiceButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:173/255.0 blue:242/255.0 alpha:1];
    [self.vtVoiceButton addTarget:self action:@selector(beginRecordVoice:) forControlEvents:UIControlEventTouchDown];
    //结束录音
    [self.vtVoiceButton addTarget:self action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
    //取消录音
    [self.vtVoiceButton addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    //上滑取消
    [self.vtVoiceButton addTarget:self action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
    //松手发送
    [self.vtVoiceButton addTarget:self action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    [self.voiceView addSubview:self.vtVoiceButton];
    
    
}


/**
 *  左边的语音按钮图片
 */
- (void)changeToVoice
{
    
    [self.TextViewInput resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, Main_Screen_Height - 349, Main_Screen_Width, 300);
        self.voiceView.frame = CGRectMake(0, 40, Main_Screen_Width, 260);
    }];
//
//    //yes
//    if (!self.btnChangeVoiceState.selected)
//    {
//        [self.btnChangeVoiceState setImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
//        [self.TextViewInput becomeFirstResponder];
//        [UIView animateWithDuration:0.3 animations:^{
//            
////            self.imageView.frame = CGRectMake(0, 300, Main_Screen_Width, 260);
//            self.voiceView.frame = CGRectMake(0, 300, Main_Screen_Width, 260);
//        }];
//        
//    }
//    else
//    {
//        [self.TextViewInput resignFirstResponder];
//        [self.btnChangeVoiceState setImage:[UIImage imageNamed:@"headImage"] forState:UIControlStateNormal];
//        [UIView animateWithDuration:0.3 animations:^{
//  //          self.imageView.frame = CGRectMake(0, 300, Main_Screen_Width, 260);
//            self.voiceView.frame = CGRectMake(0, 40, Main_Screen_Width, 260);
//        }];
//        
//    }
//    self.btnChangeVoiceState.selected = !self.btnChangeVoiceState.selected;
    
    
}

- (void)btnAndAddButton
{
    [self.TextViewInput resignFirstResponder];
//    [self.delegate goVideoRecorder];
        MBProgressHUD *mbp =[[MBProgressHUD alloc]initWithView:self.superVC.view];
        [mbp showAnimated:YES whileExecutingBlock:^{
            WechatShortVideoController *wechatShortVideoController = [[WechatShortVideoController alloc] init];
            wechatShortVideoController.delegate = self;
            [self.superVC.view.window.rootViewController presentViewController:wechatShortVideoController animated:YES completion:nil];
        } completionBlock:^{
            mbp.hidden = YES;
        }];
        

    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, Main_Screen_Height - 40, Main_Screen_Width, 40);
        
        
    }];
    
    
    
    //    self.sendAndAddButton.selected = !self.sendAndAddButton.selected;
    //    if (!self.sendAndAddButton.selected)
    //    {
    //        [self.sendAndAddButton setImage:[UIImage imageNamed:@"chat_animation_white1"] forState:UIControlStateNormal];
    //        [self.TextViewInput becomeFirstResponder];
    //        [UIView animateWithDuration:0.3 animations:^{
    //            self.voiceView.frame = CGRectMake(0, 300, Main_Screen_Width, 260);
    //            self.imageView.frame = CGRectMake(0, 300, Main_Screen_Width, 260);
    //        }];
    //
    //    }
    //    else
    //    {
    //
    //        [self.sendAndAddButton setImage:[UIImage imageNamed:@"chat_send_message"] forState:UIControlStateNormal];
    //        [self.TextViewInput resignFirstResponder];
    //        [UIView animateWithDuration:0.3 animations:^{
    //            self.voiceView.frame = CGRectMake(0, 300, Main_Screen_Width, 260);
    //            self.imageView.frame = CGRectMake(0, 40, Main_Screen_Width, 300);
    //        }];
    //
    //    }
}



#pragma mark - WechatShortVideoDelegate
- (void)finishWechatShortVideoCapture:(NSURL *)filePath
{
    // [self sendVideo:filePath withDic:@{@"userId":[UserInfo getId],@"type":@"4"}];
    NSLog(@"filePath = %@",filePath);
    dispatch_async(dispatch_get_main_queue(), ^{
            [self getMp4:filePath];
    });
//    if ([self.v_delegate respondsToSelector:@selector(VTInputFunctionView:sendVideo:)])
//    {
//        [self.v_delegate VTInputFunctionView:self sendVideo:filePath];
//    }
}

/**
 *  转码
 */
- (void)getMp4:(NSURL *)videoURL
{
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSString *mp4Path = [NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
    exportSession.outputURL = [NSURL fileURLWithPath: mp4Path];
    exportSession.outputFileType = AVFileTypeMPEG4;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        switch ([exportSession status]) {
            case AVAssetExportSessionStatusFailed:
            {
                
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"错误"
                                                                message:[[exportSession error] localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
                [alert show];
                break;
            }
                
            case AVAssetExportSessionStatusCancelled:
                NSLog(@"Export canceled");
                
                break;
            case AVAssetExportSessionStatusCompleted:
                //                NSLog(@"Successful!");
                //                NSLog(@"mp4Path = %@",mp4Path);
                //                NSLog(@"mp4Url = %@",[NSURL URLWithString:mp4Path]);
                //                NSLog(@"size = %@", [NSString stringWithFormat:@"%ld kb", (long)[self getFileSize:mp4Path]]);
                NSLog(@"mp4Path = %@",mp4Path);
//                [self sendMp4Video:mp4Path];
                if ([self.v_delegate respondsToSelector:@selector(VTInputFunctionView:sendVideo:)])
                {
                    [self.v_delegate VTInputFunctionView:self sendVideo:mp4Path];
                }
    
                break;
            default:
                break;
        }
    }];
}


- (id)initWithSuperVC:(UIViewController *)superVC
{
    self.superVC = superVC;
    CGRect frame = CGRectMake(0, Main_Screen_Height-40, Main_Screen_Width, 40);
    self = [super initWithFrame:frame];
    if (self)
    {
        MP3 = [[Mp3Recorder alloc]initWithDelegate:self];
        _imageArr = [NSMutableArray arrayWithCapacity:0];
        self.backgroundColor = [UIColor whiteColor];
        /**
         *  发送图文消息
         */
        self.btnSendMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSendMessage.frame = CGRectMake(Main_Screen_Width-40, 5, 30, 30);
        self.isAbleToSendTextMessage = NO;
        [self.btnSendMessage setTitle:@"" forState:UIControlStateNormal];
        [self.btnSendMessage setBackgroundImage:[UIImage imageNamed:@"Chat_take_picture"] forState:UIControlStateNormal];
        self.btnSendMessage.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btnSendMessage addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnSendMessage];
        
        //改变状态（语音、文字）
        self.btnChangeVoiceState = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnChangeVoiceState.frame = CGRectMake(5, 5, 30, 30);
        isbeginVoiceRecord = NO;
        [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
        self.btnChangeVoiceState.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btnChangeVoiceState addTarget:self action:@selector(voiceRecord:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnChangeVoiceState];
        
        //语音录入键
        self.btnVoiceRecord = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnVoiceRecord.frame = CGRectMake(70, 5, Main_Screen_Width-70*2, 30);
        self.btnVoiceRecord.hidden = YES;
        [self.btnVoiceRecord setBackgroundImage:[UIImage imageNamed:@"chat_message_back"] forState:UIControlStateNormal];
        [self.btnVoiceRecord setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.btnVoiceRecord setTitleColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [self.btnVoiceRecord setTitle:@"按住 说话" forState:UIControlStateNormal];
        [self.btnVoiceRecord setTitle:@"松手 发送" forState:UIControlStateHighlighted];
        //开始录音
        [self.btnVoiceRecord addTarget:self action:@selector(beginRecordVoice:) forControlEvents:UIControlEventTouchDown];
        //结束录音
        [self.btnVoiceRecord addTarget:self action:@selector(endRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
        //取消录音
        [self.btnVoiceRecord addTarget:self action:@selector(cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        //
        [self.btnVoiceRecord addTarget:self action:@selector(RemindDragExit:) forControlEvents:UIControlEventTouchDragExit];
        [self.btnVoiceRecord addTarget:self action:@selector(RemindDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
        [self addSubview:self.btnVoiceRecord];
        
        //输入框
        self.TextViewInput = [[UITextView alloc]initWithFrame:CGRectMake(45, 5, Main_Screen_Width-2*45, 30)];
        self.TextViewInput.layer.cornerRadius = 4;
        self.TextViewInput.layer.masksToBounds = YES;
        self.TextViewInput.delegate = self;
        self.TextViewInput.layer.borderWidth = 1;
        self.TextViewInput.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
        [self addSubview:self.TextViewInput];
        self.TextViewInput.returnKeyType = UIReturnKeyGo;
        
        //输入框的提示语
        placeHold = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 30)];
        placeHold.text = @"输入回复";
        placeHold.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
        [self.TextViewInput addSubview:placeHold];
        
        
        //分割线
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
        
        //多选的图片显示框
        imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40+60, self.frame.size.width, 80)];
        [self addSubview:imageScrollView];
        imageScrollView.scrollEnabled = YES;
        imageScrollView.contentSize = CGSizeMake(10000, 100);
        
        
        //添加通知  结束编辑
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidEndEditing:) name:UIKeyboardWillHideNotification object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
    
}

/**
 *  分开写  键盘打开---frame 高度变成40
 键盘关闭---frame 高度变成200
 *
 *  @param notification
 */
-(void)keyboardChange:(NSNotification *)notification
{
    NSLog(@"11111");
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect newFrame = self.frame;
    newFrame.origin.y = keyboardEndFrame.origin.y-newFrame.size.height;
    self.frame = newFrame;
    
    [UIView commitAnimations];
    
}

#pragma mark - 录音touch事件
- (void)beginRecordVoice:(UIButton *)button
{
    [MP3 startRecord];
    playTime = 0;
    playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
    [UUProgressHUD show];
}

- (void)endRecordVoice:(UIButton *)button
{
    if (playTimer) {
        [MP3 stopRecord];
        [playTimer invalidate];
        playTimer = nil;
    }
}


- (void)cancelRecordVoice:(UIButton *)button
{
    if (playTimer) {
        [MP3 cancelRecord];
        [playTimer invalidate];
        playTimer = nil;
    }
    [UUProgressHUD dismissWithError:@"取消发送"];
}

- (void)RemindDragExit:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"松开手指 取消发送"];
}

- (void)RemindDragEnter:(UIButton *)button
{
    [UUProgressHUD changeSubTitle:@"手指上滑 取消发送"];
}
/**
 *  录音时间  如果超过60秒 直接结束
 */
- (void)countVoiceTime
{
    playTime ++;
    if (playTime>=60)
    {
        [self endRecordVoice:nil];
    }
}


#pragma mark - Mp3RecorderDelegate

//回调录音资料
- (void)endConvertWithData:(NSData *)voiceData
{
    [self.v_delegate VTinputFunctionView:self sendVoice:voiceData time:playTime+1];
    [UUProgressHUD dismissWithSuccess:@"成功"];
    
    //缓冲消失时间 (最好有block回调消失完成)
    self.btnVoiceRecord.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btnVoiceRecord.enabled = YES;
    });
}
/**
 *  失败的情况---时间太短
 */
- (void)failRecord
{
    [UUProgressHUD dismissWithSuccess:@"多说点儿"];
    
    //缓冲消失时间 (最好有block回调消失完成)
    self.btnVoiceRecord.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btnVoiceRecord.enabled = YES;
    });
}

//改变输入与录音状态
/**
 *  进入文本或者语音输入状态
 *
 *  @param
 */
- (void)voiceRecord:(UIButton *)sender
{
    self.btnVoiceRecord.hidden = !self.btnVoiceRecord.hidden;
    self.TextViewInput.hidden  = !self.TextViewInput.hidden;
    isbeginVoiceRecord = !isbeginVoiceRecord;
    if (isbeginVoiceRecord) {
        [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_ipunt_message"] forState:UIControlStateNormal];
        [self.TextViewInput resignFirstResponder];
    }else{
        [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
        [self.TextViewInput becomeFirstResponder];
    }
}

- (void)sendMessage:(UIButton *)sender
{
    if (self.TextViewInput.text.length == 0)
    {
        NSLog(@"不能发送空内容");
    }
    else
    {
        
        [self.v_delegate VTInputFunctionView:self sendMessage:self.TextViewInput.text];
    }
    
}


#pragma mark - TextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        [self.v_delegate VTInputFunctionView:self sendMessage:textView.text];
        return NO;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    placeHold.hidden = self.TextViewInput.text.length > 0;
}

- (void)textViewDidChange:(UITextView *)textView
{
    //开始编辑
    //[self changeSendBtnWithPhoto:textView.text.length>0?NO:YES];
    placeHold.hidden = textView.text.length>0;
}

- (void)changeSendBtnWithPhoto:(BOOL)isPhoto
{
    self.isAbleToSendTextMessage = !isPhoto;
    [self.btnSendMessage setTitle:isPhoto?@"":@"send" forState:UIControlStateNormal];
    self.btnSendMessage.frame = RECT_CHANGE_width(self.btnSendMessage, isPhoto?30:35);
    UIImage *image = [UIImage imageNamed:isPhoto?@"Chat_take_picture":@"chat_send_message"];
    [self.btnSendMessage setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    placeHold.hidden = self.TextViewInput.text.length > 0;
}




@end
