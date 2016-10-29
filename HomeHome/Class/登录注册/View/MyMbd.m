//
//

#import "MyMbd.h"
#import "MBProgressHUD.h"

@implementation MyMbd

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        MBProgressHUD *mbd = [[MBProgressHUD alloc] initWithView:self];
        //mbd.labelText = @"加载中...";
        if (self.text)
        {
            mbd.labelText = self.text;
        }
        mbd.labelFont = [UIFont systemFontOfSize:11];
        mbd.color = [UIColor blackColor];
        mbd.alpha = 0.5;
        mbd.layer.masksToBounds = YES;
        mbd.layer.cornerRadius = 20;
        [self addSubview:mbd];
        [mbd show:YES];
        self.tag = 12345;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
