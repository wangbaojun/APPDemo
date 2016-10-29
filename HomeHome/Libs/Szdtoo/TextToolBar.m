//
//  TextToolBar.m
//  HomeHome
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 Victor. All rights reserved.
//
#import "HHUserInfo.h"
#import "HPGrowingTextView.h"
#import "TextToolBar.h"

@interface TextToolBar ()<HPGrowingTextViewDelegate>
{
    HPGrowingTextView * _textView;
}

@end

@implementation TextToolBar

-(id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        [self initUI];
        NSLog(@"self.islogin==%d",self.isLogin);
        //键盘出现/消失的通知
        [SZNotificationCenter addObserver:self selector:@selector(keyboardWillShow1:) name:UIKeyboardWillShowNotification object:nil];
        [SZNotificationCenter addObserver:self selector:@selector(keyboardWillHide1:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

-(void)initUI
{
    self.backgroundColor =[UIColor whiteColor];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 1)];
    line.backgroundColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:229/255.0 alpha:1.0];
    [self addSubview:line];

   UIImageView *head=[[UIImageView alloc]initWithFrame:CGRectMake(4, 5, 30, 30)];
   head.tag=12307;
   [head.layer setCornerRadius:15];
   [head.layer setMasksToBounds:YES];
   if (_isLogin==YES)
   {
     [head sd_setImageWithURL:[NSURL URLWithString:[HHUserInfo getUserHead]]];
    }
   else
   {
      head.image=[UIImage imageNamed:@"info-headportrait2"];
   }
   [self addSubview:head];

   _textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(36, 3, kScreenW-103, 10)];
   _textView.isScrollable = NO;

   _textView.minNumberOfLines = 1;
   _textView.maxNumberOfLines = 6;
   _textView.returnKeyType = UIReturnKeyDefault;
   _textView.font = [UIFont systemFontOfSize:15.0f];
   _textView.delegate = self;
   _textView.backgroundColor = [UIColor clearColor];
   _textView.layer.masksToBounds = YES;
   _textView.layer.cornerRadius = 5;
   _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
   _textView.layer.borderWidth = 0.1;
   _textView.placeholder = @"我也说两句";
   _textView.placeholderColor = [UIColor lightGrayColor];
   _textView.font = [UIFont systemFontOfSize:16];
   _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
   [self addSubview:_textView];

//  if (self.isCom) {
//    [_textView becomeFirstResponder];
//  }

    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   doneBtn.tag=12306;
   doneBtn.frame = CGRectMake(self.frame.size.width - 65, 5, 60, 30);
   doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
   if (_isLogin ==YES)
   {
      [doneBtn setTitle:@"发送" forState:UIControlStateNormal];
       
   }else{
    [doneBtn setTitle:@"未登录" forState:UIControlStateNormal];
}

   [doneBtn setBackgroundImage:[[UIImage imageNamed:@"button_send_comment.png"] stretchableImageWithLeftCapWidth:3 topCapHeight:22] forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [doneBtn addTarget:self action:@selector(sendSomeThing) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:doneBtn];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    self.frame = r;
}

-(void)configBar:(BOOL)isLogin
{
    [self initUI];
}

/**
 *  登陆成功后,修改ToolBar
 */
-(void)createToolBar2
{
    if(_isLogin)
    {
        UIButton *btn=(UIButton *)[self viewWithTag:12306];
        [btn setTitle:@"发送" forState:UIControlStateNormal];
        UIImageView *head=(UIImageView *)[self viewWithTag:12307];
        [head sd_setImageWithURL:[NSURL URLWithString:[HHUserInfo getUserHead]]];
    }
}
/**
 *  发送评论
 */
- (void)sendSomeThing
{
    [_textView resignFirstResponder];
     if (_textView.text.length == 0)
    {
        [HHPointHUD showErrorWithTitle:@"不能发送空消息"];
    }
    else if (_textView.text.length >75)
    {
        [HHPointHUD showErrorWithTitle:@"最多不能超过75个字"];
    }
    else
    {
        
        if ([self.btnClick_delegate respondsToSelector:@selector(sendSongThing:)])
        {
            
            [self.btnClick_delegate sendSongThing:_textView.text];
            _textView.text =@"";
         }

        
    }

}


#pragma mark - keyboard.notifation
/**
 *  键盘即将显示的时候调用
 */
- (void)keyboardWillShow1:(NSNotification *)note
{
    // 1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        //_chatBackView.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
        self.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height-10);
        
    }];
}

/**
 *  键盘即将退出的时候调用
 */
- (void)keyboardWillHide1:(NSNotification *)note
{
    // 1.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        // _chatBackView.transform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformIdentity;
    }];
}


@end
