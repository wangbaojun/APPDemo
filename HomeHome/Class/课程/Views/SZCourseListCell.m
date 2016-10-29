//
//  SZCourseListCell.m
//  SZDT_Partents
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 szdt_jzZhang. All rights reserved.
//

#import "SZCourseListCell.h"

#define FONT_18 [UIFont systemFontOfSize:18]
#define FONT_20 [UIFont systemFontOfSize:20.5]
#define FONT_15 [UIFont systemFontOfSize:15]
#define FONT_17 [UIFont systemFontOfSize:17]

@interface SZCourseListCell ()
{
    UILabel * _line;
    SZCourseListModel * _model;
    
    UILabel * _label1;//仅剩
    UILabel * _label2;//天
    UILabel * _label3;//时
    UILabel * _label4;//分
    
}

@end
@implementation SZCourseListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
        
        [self initUI];
    }
    
    return self;
}


-(void)createUI{
    self.courseName = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, kScreenW - 135, 40)];
    self.courseName.font = [UIFont systemFontOfSize:19];
    [self.contentView addSubview:self.courseName];
    
    [self createRestTimeLabel];
    
    self.priceNow = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW - 110, 5, 100, 45)];
    self.priceNow.textColor = VTColor(255, 58, 0);
    self.priceNow.textAlignment = NSTextAlignmentRight;
    self.priceNow.font = [UIFont systemFontOfSize:28];
    [self.contentView addSubview:self.priceNow];
    
    self.priceAgo = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW - 70, 45, 60, 25)];
    self.priceAgo.textColor = [UIColor grayColor];
    self.priceAgo.textAlignment = NSTextAlignmentRight;
    self.priceAgo.font = [UIFont italicSystemFontOfSize:21];;
    [self.contentView addSubview:self.priceAgo];
    
    self.mainImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 77, kScreenW, 173)];
    [self.contentView addSubview:self.mainImage];
    
    self.isLootAll = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW/2 - 65, 21.5, 130, 130)];
    self.isLootAll.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    self.isLootAll.text = @"抢光了";
    self.isLootAll.textColor = [UIColor whiteColor];
    self.isLootAll.font = [UIFont systemFontOfSize:23];
    self.isLootAll.layer.cornerRadius = 65;
    self.isLootAll.clipsToBounds = YES;
    self.isLootAll.textAlignment = NSTextAlignmentCenter;
    [self.mainImage addSubview:self.isLootAll];
    
    self.finishLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW - 40, 77, 40, 40)];
    self.finishLabel.textColor = [UIColor whiteColor];
    self.finishLabel.adjustsFontSizeToFitWidth = YES;
    self.finishLabel.numberOfLines = 0;
    self.finishLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.finishLabel];
}

-(void)createRestTimeLabel{
    
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 37, 40, 35)];
    _label1.text = @"仅剩";
    _label1.font = FONT_18;
    _label1.textColor = [UIColor grayColor];
    [self.contentView addSubview:_label1];
    
    self.day1 = [[UILabel alloc] initWithFrame:CGRectMake(60, 46, 15, 16)];
    self.day1.backgroundColor = [UIColor blackColor];
    self.day1.textColor = [UIColor whiteColor];
    self.day1.font = FONT_20;
    self.day1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.day1];
    
    self.day2 = [[UILabel alloc] initWithFrame:CGRectMake(76, 46, 15, 16)];
    self.day2.backgroundColor = [UIColor blackColor];
    self.day2.textColor = [UIColor whiteColor];
    self.day2.font = FONT_20;
    self.day2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.day2];
    
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(95, 37, 20, 35)];
    _label2.textColor = [UIColor grayColor];
    _label2.font = FONT_18;
    _label2.text = @"天";
    [self.contentView addSubview:_label2];
    
    self.hour1 = [[UILabel alloc] initWithFrame:CGRectMake(119, 46, 15, 16)];
    self.hour1.backgroundColor = [UIColor blackColor];
    self.hour1.textColor = [UIColor whiteColor];
    self.hour1.font = FONT_20;
    self.hour1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.hour1];
    
    self.hour2 = [[UILabel alloc] initWithFrame:CGRectMake(135, 46, 15, 16)];
    self.hour2.backgroundColor = [UIColor blackColor];
    self.hour2.textColor = [UIColor whiteColor];
    self.hour2.font = FONT_20;
    self.hour2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.hour2];
    
    _label3 = [[UILabel alloc] initWithFrame:CGRectMake(154, 37, 20, 35)];
    _label3.textColor = [UIColor grayColor];
    _label3.font = FONT_18;
    _label3.text = @"时";
    [self.contentView addSubview:_label3];
    
    self.min1 = [[UILabel alloc] initWithFrame:CGRectMake(178, 46, 15, 16)];
    self.min1.backgroundColor = [UIColor blackColor];
    self.min1.textColor = [UIColor whiteColor];
    self.min1.font = FONT_20;
    self.min1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.min1];
    
    self.min2 = [[UILabel alloc] initWithFrame:CGRectMake(194, 46, 15, 16)];
    self.min2.backgroundColor = [UIColor blackColor];
    self.min2.textColor = [UIColor whiteColor];
    self.min2.font = FONT_20;
    self.min2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.min2];
    
    _label4 = [[UILabel alloc] initWithFrame:CGRectMake(213, 37, 20, 35)];
    _label4.textColor = [UIColor grayColor];
    _label4.font = FONT_18;
    _label4.text = @"分";
    [self.contentView addSubview:_label4];
}

-(void)initUI{
}

-(void)confingCellWithModel:(SZCourseListModel *)courseListModel{
    
    _model = courseListModel;
    
    self.courseName.text =courseListModel.title;
    
    NSString * price = [NSString stringWithFormat:@"¥%@", courseListModel.price];
    NSMutableAttributedString * priceNow = [[NSMutableAttributedString alloc] initWithString:price];
    [priceNow setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:21]} range:NSMakeRange(0, 1)];
    [priceNow setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:28]} range:NSMakeRange(1, price.length - 1)];
    self.priceNow.attributedText = priceNow;
    
    NSString * orignalPrice = [NSString stringWithFormat:@"¥%@", courseListModel.originalPrice];
    NSMutableAttributedString * priceAgo = [[NSMutableAttributedString alloc] initWithString:orignalPrice];
    [priceAgo setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(0, 1)];
    [priceAgo addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:NSMakeRange(0, orignalPrice.length)];
    self.priceAgo.attributedText = priceAgo;
    
    if ([courseListModel.isLootAll intValue] == 0) {
        self.isLootAll.hidden = YES;
    }else{
        self.isLootAll.hidden = NO;
    }

    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:courseListModel.cover] placeholderImage:[UIImage imageNamed:@"123"]];
    
    [self freshRestTime];
    
    //课程首页  需要对页面做些调整
    if ([self.reuseIdentifier isEqualToString:@"courseHomePage"]) {
        self.priceNow.frame = CGRectMake(kScreenW - 110 - 80, 5, 100, 45);
        self.priceAgo.frame = CGRectMake(kScreenW - 70 - 80, 45, 60, 25);
        self.mainImage.frame = CGRectMake(0, 77, kScreenW - 80, 173);
        self.finishLabel.frame = CGRectMake(kScreenW - 40 - 80, 77, 40, 40);
        self.isLootAll.frame = CGRectMake(kScreenW/2 - 65 - 40, 21.5, 130, 130);
        
        if (kScreenW == 320) {
            [self adjustFor5s];
        }else if (kScreenW == 375){
            [self adjustFro6];
        }
        
    }else{
        
        
    }

}
#pragma mark --------adjust  调整页面, 适配5s, 6
-(void)adjustFor5s{
    
    self.finishLabel.frame = CGRectMake(kScreenW - 40 - 65, 67, 40, 40);

    self.mainImage.frame = CGRectMake(0, 67, kScreenW - 65, 183);
    
    self.courseName.frame = CGRectMake(10, 5, kScreenW - 160, 40);
    self.courseName.font = [UIFont systemFontOfSize:17];
    
    self.priceNow.frame = CGRectMake(kScreenW - 135, 5, 67, 35);
    self.priceNow.font = [UIFont systemFontOfSize:25];
    
    self.priceAgo.frame = CGRectMake(kScreenW - 70 - 56, 40, 60, 25);
    self.priceAgo.font = [UIFont systemFontOfSize:20];
    
    _label1.frame = CGRectMake(10, 37, 30, 25);
    _label1.font = FONT_15;
    
    self.day1.frame = CGRectMake(43, 42, 15, 15);
    self.day1.font = FONT_17;
    
    self.day2.frame = CGRectMake(59, 42, 15, 15);
    self.day2.font = FONT_17;
    
    _label2.frame = CGRectMake(78, 37, 20, 25);
    _label2.font = FONT_15;

    
    self.hour1.frame = CGRectMake(96, 42, 15, 15);
    self.hour1.font = FONT_17;
    
    self.hour2.frame = CGRectMake(112, 42, 15, 15);
    self.hour2.font = FONT_17;
    
    _label3.frame = CGRectMake(130, 37, 20, 25);
    _label3.font = FONT_15;
    
    self.min1.frame = CGRectMake(149, 42, 15, 15);
    self.min1.font = FONT_17;
    
    self.min2.frame = CGRectMake(165, 42, 15, 15);
    self.min2.font = FONT_17;
    
    _label4.frame = CGRectMake(182, 37, 20, 25);
    _label4.font = FONT_15;
}

-(void)adjustFro6{

}

#pragma mark --------public methods
-(void)freshRestTime{
    long long beginTime = [_model.beginTime longLongValue] / 1000;
    long long endTime = [_model.endTime longLongValue] / 1000;
    long long now = [[NSDate date] timeIntervalSinceDate:[NSDate dateWithTimeIntervalSince1970:0]];
    long long restTime = endTime - now;
    long long durationTime = endTime - beginTime;
    
    if (restTime  <= 0) {//剩余时间<=0
        self.finishLabel.hidden = NO;
        self.finishLabel.text = @"已经\n结束";
        self.finishLabel.backgroundColor = VTColor(255, 129, 72);
        self.day1.text = @"0";
        self.day2.text = @"0";
        self.hour1.text = @"0";
        self.hour2.text = @"0";
        self.min1.text = @"0";
        self.min2.text = @"0";
        return;
    }
    
    double rate = (double)restTime/durationTime;
    if (rate <= 0.1) {//即将结束
        self.finishLabel.hidden = NO;
        self.finishLabel.text = @"即将\n结束";
        self.finishLabel.backgroundColor = VTColor(255, 129, 72);
        
    }else if (rate >= 0.9){//刚刚开始
        self.finishLabel.hidden = NO;
        self.finishLabel.text = @"刚刚\n开始";
        self.finishLabel.backgroundColor = VTColor(152, 194, 52);
        
    }else{
        self.finishLabel.hidden = YES;
    }
    
    long long day = restTime / 86400;
    long long hour = (restTime - day * 86400) / 3600;
    long long min = (restTime - day * 86400 - hour * 3600) / 60;
    
    NSString * dayStr = [NSString stringWithFormat:@"%.2lld", day];
    NSString * hourStr = [NSString stringWithFormat:@"%.2lld", hour];
    NSString * minStr = [NSString stringWithFormat:@"%.2lld", min];

    self.day1.text = [dayStr substringWithRange:NSMakeRange(0, 1)];
    self.day2.text = [dayStr substringWithRange:NSMakeRange(1, 1)];
    self.hour1.text = [hourStr substringWithRange:NSMakeRange(0, 1)];
    self.hour2.text = [hourStr substringWithRange:NSMakeRange(1, 1)];
    self.min1.text = [minStr substringWithRange:NSMakeRange(0, 1)];
    self.min2.text = [minStr substringWithRange:NSMakeRange(1, 1)];
}

-(void)setCourseTitleRedColorWithSearchText:(NSString *)searchText{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_model.title];
    NSString *newStr = _model.title;
    NSString *temp = nil;
    for(int i =0; i < [newStr length]; i++)
    {
        if (i+searchText.length <= _model.title.length)
        {
            temp = [newStr substringWithRange:NSMakeRange(i, searchText.length)];
            if ([temp isEqualToString:searchText])
            {
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(i,searchText.length)];
                
            }
        }
    }
    
    
    self.courseName.attributedText = str;
}

@end
