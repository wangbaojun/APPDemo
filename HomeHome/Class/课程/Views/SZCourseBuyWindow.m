//
//  SZCourseBuyWindow.m
//  SZDT_Partents
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 szdt_jzZhang. All rights reserved.
//

#import "SZCourseBuyWindow.h"
#import "HHAppDelegate.h"

@interface SZCourseBuyWindow ()
{
    UIButton * _reduce;
    UIButton * _add;
}
@end

@implementation SZCourseBuyWindow

-(instancetype)init{
    self = [super init];
    if (self) {
        [self createUI];
    }
    
    return self;
}

+(instancetype)defaultBuyWindow{
    static SZCourseBuyWindow * window;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        window = [[self alloc] init];
    });
    
    return window;
}

-(void)createUI{
    self.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    self.windowLevel = 1000;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 150, kScreenW, kScreenH - 150)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, -20, 130, 130)];
    self.imageView.layer.cornerRadius = 10;
    self.imageView.clipsToBounds = YES;
    [bgView addSubview:self.imageView];
    
    UIButton * cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    cancel.frame = CGRectMake(kScreenW - 47, 10, 30, 30);
    [cancel setBackgroundImage:[UIImage imageNamed:@"course_buy_close"] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelBuy:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cancel];
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 45)];
    self.price.textColor = VTColor(255, 58, 0);
    self.price.font = [UIFont systemFontOfSize:28];
    [bgView addSubview:self.price];
    
    self.nameLbael = [[UILabel alloc] initWithFrame:CGRectMake(160, 40, kScreenW - 170, 40)];
    self.nameLbael.font = [UIFont systemFontOfSize:19];
    [bgView addSubview:self.nameLbael];
    
    self.subTitle = [[UILabel alloc] initWithFrame:CGRectMake(160, 73, kScreenW - 170, 40)];
    self.subTitle.font = [UIFont systemFontOfSize:14];
    self.subTitle.numberOfLines = 0;
    self.subTitle.textColor = [UIColor grayColor];
    [bgView addSubview:self.subTitle];
    
    UILabel * line1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, kScreenW - 30, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [bgView addSubview:line1];
    
    UILabel * buyNum = [[UILabel alloc] initWithFrame:CGRectMake(15, 141, 100, 30)];
    buyNum.text = @"购买数量";
    [bgView addSubview:buyNum];
    
    [self createAccessoryViewForView:bgView];
    
    UILabel * line2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 191, kScreenW - 30, 1)];
    line2.backgroundColor = [UIColor grayColor];
    [bgView addSubview:line2];
    
    UIButton * confirm = [UIButton buttonWithType:UIButtonTypeSystem];
    confirm.backgroundColor = VTColor(255, 80, 1);
    [confirm setTitle:@"确认" forState:UIControlStateNormal];
    [confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirm.frame = CGRectMake(0, kScreenH - 49, kScreenW, 49);
    [confirm addTarget:self action:@selector(confirmBuy:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirm];
    
}

-(void)createAccessoryViewForView:(UIView *)bgView{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(kScreenW - 120, 140, 102, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    _reduce = [UIButton buttonWithType:UIButtonTypeSystem];
    _reduce.backgroundColor = VTColor(251, 251, 251);
    [_reduce setBackgroundImage:[UIImage imageNamed:@"course_buy_Reduction2"] forState:UIControlStateNormal];
    _reduce.frame = CGRectMake(0, 0, 30, 30);
    [_reduce addTarget:self action:@selector(reduce:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_reduce];
    
    self.buyCount = [[UILabel alloc] initWithFrame:CGRectMake(31, 0, 40, 30)];
    self.buyCount.backgroundColor = VTColor(245, 245, 245);
    self.buyCount.adjustsFontSizeToFitWidth = YES;
    self.buyCount.text = @"1";
    self.buyCount.textAlignment = NSTextAlignmentCenter;
    [view addSubview:self.buyCount];
    
    _add = [UIButton buttonWithType:UIButtonTypeSystem];
    _add.backgroundColor = VTColor(245, 245, 245);
    _add.frame = CGRectMake(72, 0, 30, 30);
    [_add setBackgroundImage:[UIImage imageNamed:@"course_buy_add"] forState:UIControlStateNormal];
    [_add addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_add];
    
    [bgView addSubview:view];
    
}

-(void)initUIWithDic:(NSDictionary *)courseInfo{
    
    SZCourseBuyWindow * window = [SZCourseBuyWindow defaultBuyWindow];
    
    [window.imageView sd_setImageWithURL:[NSURL URLWithString:courseInfo[@"cover"]] placeholderImage:nil];
    
    NSString * price = [NSString stringWithFormat:@"¥%@", courseInfo[@"price"]];
    NSMutableAttributedString * mPrice = [[NSMutableAttributedString alloc] initWithString:price];
    [mPrice setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]} range:NSMakeRange(0, 1)];
    [mPrice setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:28]} range:NSMakeRange(1, price.length - 1)];
    window.price.attributedText = mPrice;
    
    window.nameLbael.text = courseInfo[@"title"];
    window.subTitle.text = courseInfo[@"descript"];
    window.maxBuyCount = [courseInfo[@"recruitNum"] intValue];
    
    
}

/**
 *  取消购买
 *
 *
 */
-(void)cancelBuy:(UIButton *)calcel{
    [self hideSelf];
}

/**
 *  确认购买
 *
 *  @param confirm
 */
-(void)confirmBuy:(UIButton *)confirm{
    
    if (self.isBuy) {
        [self.buyWindowDelegate buyNow];
    }else{
        [self.buyWindowDelegate addToShoppingCart];
    }
}

/**
 *  减少购买数量
 *
 *  @param reduce
 */
-(void)reduce:(UIButton *)reduce{
    int count = [self.buyCount.text intValue];
    
    if (count == 1) {
        
    }else{
        
        self.buyCount.text = [NSString stringWithFormat:@"%d", --count];
    }
}

/**
 *  增加购买数量
 *
 *  @param add
 */
-(void)add:(UIButton *)add{
    int count = [self.buyCount.text intValue];
    
    if (count < self.maxBuyCount) {
        self.buyCount.text = [NSString stringWithFormat:@"%d", ++count];
    }
}

//-(void)setAddOrReduceBtnImage{
//    int count = [self.buyCount.text intValue];
//
//    if (count == 1) {
//    
//        [_reduce setBackgroundImage:[UIImage imageNamed:@"Reduction2"] forState:UIControlStateNormal];
//        [_add setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
//    }
//    
//    if (count == self.maxBuyCount) {
//        [_add setBackgroundImage:[UIImage imageNamed:@"add2"] forState:UIControlStateNormal];
//        
//        if (count != 1) {
//            [_reduce setBackgroundImage:[UIImage imageNamed:@"Reduction"] forState:UIControlStateNormal];
//        }else{
//            [_reduce setBackgroundImage:[UIImage imageNamed:@"Reduction2"] forState:UIControlStateNormal];
//        }
//    }
//}

-(void)hideSelf{
    [self resignKeyWindow];
    HHAppDelegate * delegate = (HHAppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window makeKeyAndVisible];
    self.hidden = YES;
    self.buyCount.text = @"1";
}

@end
