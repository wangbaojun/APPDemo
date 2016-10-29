//
//  VTFunctionItem.m
//  HomeHome
//
//  Created by Victor on 16/3/28.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "VTFunctionItem.h"
#import "lame.h"
@interface VTFunctionItem ()<AVAudioRecorderDelegate>


@property (nonatomic,strong)UIButton *recordButton;

@property (nonatomic,strong)UITextView *textView;

@property (nonatomic,strong)UIButton *videoButton;

@end


@implementation VTFunctionItem

- (instancetype)initWithFrame:(CGRect)frame itemtype:(funtionItem)funtionItem
{
    if (self = [super initWithFrame:frame])
    {
        switch (funtionItem)
        {
            case 0:
            {
                //语音
                
                
                [self initAudio];
                break;
            }
            case 1:
            {
                //文字输入
                [self initMessage];
                break;
            }
            case 2:
            {
                //小视频录
                
                [self initVideo];
                break;
            }
            default:
                break;
        }
    }
    return self;
}

- (void)initAudio
{
    self.recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recordButton.frame = self.bounds;
    [self.recordButton setImage:[UIImage imageNamed:@"community_voice"] forState:UIControlStateNormal];
    
    [self addSubview:self.recordButton];
}

- (void)initMessage
{

}

- (void)initVideo
{
    
}

@end
