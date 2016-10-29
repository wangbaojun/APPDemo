//
//  SZCourseDetailCell.m
//  SZDT_Partents
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 szdt_jzZhang. All rights reserved.
//

#import "SZCourseDetailCell.h"
#define FONT_18 [UIFont systemFontOfSize:18]
#define FONT_20 [UIFont systemFontOfSize:20.5]

@interface SZCourseDetailCell ()
{
    UILabel * _label1;//"仅剩"
    UILabel * _label2;//"天"
    UILabel * _label3;//"时"
    UILabel * _label4;//"分"
    UILabel * _line1;//"仅剩"前面的一条线
    UILabel * _line2;//"分"后面的一条线
}
@end

@implementation SZCourseDetailCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if ([reuseIdentifier isEqualToString:@"section_one"]) {
            [self createUIForSectionOne];
            [self initUIForSectionOne];
            
        }else if ([reuseIdentifier isEqualToString:@"section_three"]){
            [self createUIForSectionThree];
            [self initUIForSectionThree];
        }
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

-(void)createUIForSectionOne{
    self.priceNow = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 70, 45)];
    self.priceNow.textColor = VTColor(255, 58, 0);
    self.priceNow.font = [UIFont systemFontOfSize:28];
    [self.contentView addSubview:self.priceNow];
    
    self.priceAgo = [[UILabel alloc] initWithFrame:CGRectMake(100, 18, 60, 25)];
    self.priceAgo.textColor = [UIColor grayColor];
    self.priceAgo.font = [UIFont italicSystemFontOfSize:23];;
    [self.contentView addSubview:self.priceAgo];
    
    self.shareBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.shareBtn.frame = CGRectMake(kScreenW - 110, 10, 100, 40);
    self.shareBtn.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.shareBtn];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, kScreenW - 30, 40)];
    self.nameLabel.font = [UIFont systemFontOfSize:19];
    [self.contentView addSubview:self.nameLabel];
    
    self.subName = [[UILabel alloc] initWithFrame:CGRectMake(20, 75, kScreenW - 30, 60)];
    self.subName.font = [UIFont systemFontOfSize:18];
    self.subName.numberOfLines = 0;
    self.subName.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.subName];
    
    [self createRestTimeLabelWithY:135];
}

-(void)createRestTimeLabelWithY:(float)Y{
    /**
     *  labelY numY坐标相差9
     */
    float labelY = Y;
    float numY = Y + 9;
    
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(20 + (kScreenW/2 - 126.5), labelY, 40, 35)];
    _label1.text = @"仅剩";
    _label1.font = FONT_18;
    _label1.textColor = [UIColor grayColor];
    [self.contentView addSubview:_label1];
    
    self.day1 = [[UILabel alloc] initWithFrame:CGRectMake(60 + (kScreenW/2 - 126.5), numY, 15, 16)];
    self.day1.backgroundColor = [UIColor blackColor];
    self.day1.textColor = [UIColor whiteColor];
    self.day1.font = FONT_20;
    self.day1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.day1];
    
    self.day2 = [[UILabel alloc] initWithFrame:CGRectMake(76 + (kScreenW/2 - 126.5), numY, 15, 16)];
    self.day2.backgroundColor = [UIColor blackColor];
    self.day2.textColor = [UIColor whiteColor];
    self.day2.font = FONT_20;
    self.day2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.day2];
    
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(95 + (kScreenW/2 - 126.5), labelY, 20, 35)];
    _label2.textColor = [UIColor grayColor];
    _label2.font = FONT_18;
    _label2.text = @"天";
    [self.contentView addSubview:_label2];
    
    self.hour1 = [[UILabel alloc] initWithFrame:CGRectMake(119 + (kScreenW/2 - 126.5), numY, 15, 16)];
    self.hour1.backgroundColor = [UIColor blackColor];
    self.hour1.textColor = [UIColor whiteColor];
    self.hour1.font = FONT_20;
    self.hour1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.hour1];
    
    self.hour2 = [[UILabel alloc] initWithFrame:CGRectMake(135 + (kScreenW/2 - 126.5), numY, 15, 16)];
    self.hour2.backgroundColor = [UIColor blackColor];
    self.hour2.textColor = [UIColor whiteColor];
    self.hour2.font = FONT_20;
    self.hour2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.hour2];
    
    _label3 = [[UILabel alloc] initWithFrame:CGRectMake(154 + (kScreenW/2 - 126.5), labelY, 20, 35)];
    _label3.textColor = [UIColor grayColor];
    _label3.font = FONT_18;
    _label3.text = @"时";
    [self.contentView addSubview:_label3];
    
    self.min1 = [[UILabel alloc] initWithFrame:CGRectMake(178 + (kScreenW/2 - 126.5), numY, 15, 16)];
    self.min1.backgroundColor = [UIColor blackColor];
    self.min1.textColor = [UIColor whiteColor];
    self.min1.font = FONT_20;
    self.min1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.min1];
    
    self.min2 = [[UILabel alloc] initWithFrame:CGRectMake(194 + (kScreenW/2 - 126.5), numY, 15, 16)];
    self.min2.backgroundColor = [UIColor blackColor];
    self.min2.textColor = [UIColor whiteColor];
    self.min2.font = FONT_20;
    self.min2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.min2];
    
    _label4 = [[UILabel alloc] initWithFrame:CGRectMake(213 + (kScreenW/2 - 126.5), labelY, 20, 35)];
    _label4.textColor = [UIColor grayColor];
    _label4.font = FONT_18;
    _label4.text = @"分";
    [self.contentView addSubview:_label4];
    
    _line1 = [[UILabel alloc] initWithFrame:CGRectMake(20, labelY + 17, (kScreenW - 213)/2 - 20 - 10, 1)];
    _line1.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_line1];
    
    _line2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW /2 + 213/2 + 10, labelY + 17, (kScreenW - 213)/2 - 20 - 10, 1)];
    _line2.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_line2];
}

-(void)createUIForSectionThree{
    float labelH = 25;
    float top = 5;
    float Yspace = 5;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, top, kScreenW - 35, labelH)];
    self.titleLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.teacher = [[UILabel alloc] initWithFrame:CGRectMake(15, labelH + top + Yspace, kScreenW - 35, labelH)];
    self.teacher.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.teacher];
    
    self.beginTime = [[UILabel alloc] initWithFrame:CGRectMake(15, (labelH + Yspace)*2 + top, kScreenW - 35, labelH)];
    self.beginTime.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.beginTime];
    
    self.appointmentNum = [[UILabel alloc] initWithFrame:CGRectMake(15, (labelH + Yspace)*3 + top, kScreenW - 35, labelH)];
    self.appointmentNum.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.appointmentNum];
    
    self.desLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, (labelH + Yspace)*4 + top, kScreenW - 35, labelH)];
    self.desLabel.textColor = [UIColor grayColor];
    self.desLabel.numberOfLines = 0;
    [self.contentView addSubview:self.desLabel];
}

#pragma mark ----------configCell
-(void)initUIForSectionOne{
    
    self.nameLabel.text = @"中考英语冲刺班";
    NSString * subname = @"中考英语辅导冲刺(主要讲解中考英语听力、阅读理解以及作文的解题技巧)中考英语辅导冲刺(主要讲解中考英语听力、阅读理解以及作文的解题技巧)";
    self.subName.text = subname;
    CGRect rect = self.subName.frame;
    rect.size.height = [subname boundingRectWithSize:CGSizeMake(kScreenW - 30, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil].size.height;
    self.subName.frame = rect;
    [self freshRestTimeLabelPositionWithY:CGRectGetMaxY(rect)];
    
    NSMutableAttributedString * priceNow = [[NSMutableAttributedString alloc] initWithString:@"¥599"];
    [priceNow setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:21]} range:NSMakeRange(0, 1)];
    [priceNow setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:28]} range:NSMakeRange(1, @"¥599".length - 1)];
    self.priceNow.attributedText = priceNow;
    
    NSMutableAttributedString * priceAgo = [[NSMutableAttributedString alloc] initWithString:@"¥780"];
    [priceAgo setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} range:NSMakeRange(0, 1)];
    [priceAgo addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:NSMakeRange(0, @"¥780".length)];
    self.priceAgo.attributedText = priceAgo;
    
    self.day1.text = @"0";
    self.day2.text = @"2";
    self.hour1.text = @"2";
    self.hour2.text = @"2";
    self.min1.text = @"5";
    self.min2.text = @"7";
}

-(void)initUIForSectionThree{
    self.titleLabel.text = @"名称:  中考英语冲刺";
    self.teacher.text = @"老师:  张鸥(听力练习) 李霞(读写练习)";
    self.appointmentNum.text = @"预购人数:  120人";
    
    NSString * beginTime = @"开课时间:  2016-01-27 — 2016-01-29";
    NSMutableAttributedString * beginTimeAttStr = [[NSMutableAttributedString alloc] initWithString:beginTime];
    [beginTimeAttStr setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} range:NSMakeRange(7, beginTime.length - 7)];
    self.beginTime.attributedText = beginTimeAttStr;

    //8个空格
    NSString * des = @"        突出重点群体，以农村学生升学和参军进入城镇的人口、在城镇就业和居住5年以上和举家迁徙的农业转移人口等4类群体为重点，逐一研究落户政策，逐一提出解决方案。突出重点地区，各地特别是大城市和东部地区城镇要在准确把握城市定位的基础上，因地制宜制定落户政策，积极探索实施分区域分阶段落户对于人们普遍关心的特大城市、大城市的户籍政策，公安部副部长黄明在部署会上表示，要抓紧建立完善积分落户制度，坚持以合法稳定就业和合法稳定住所（含租赁）、参加城镇社会保险年限、连续居住年限等为主要指标，重点解决在城镇就业和居住5年以上和举家迁徙的农业转移人口落户问题";
    
    CGRect rect = self.desLabel.frame;
    rect.size.height = [des boundingRectWithSize:CGSizeMake(kScreenW - 35, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
    self.desLabel.frame = rect;
    self.desLabel.text = des;
}

/**
 *  更改剩余时间label的坐标
    Y:subName的MaxY
 */
-(void)freshRestTimeLabelPositionWithY:(float)Y{
    /**
     *  labelY numY坐标相差9
     */
    float labelY = Y;
    float numY = Y + 9;
    _label1.frame = CGRectMake(20 + (kScreenW/2 - 126.5), labelY, 40, 35);
    self.day1.frame = CGRectMake(60 + (kScreenW/2 - 126.5), numY, 15, 17);
    self.day2.frame = CGRectMake(76 + (kScreenW/2 - 126.5), numY, 15, 17);
    _label2.frame = CGRectMake(95 + (kScreenW/2 - 126.5), labelY, 20, 35);
    self.hour1.frame = CGRectMake(119 + (kScreenW/2 - 126.5), numY, 15, 17);
    self.hour2.frame = CGRectMake(135 + (kScreenW/2 - 126.5), numY, 15, 17);
    _label3.frame = CGRectMake(154 + (kScreenW/2 - 126.5), labelY, 20, 35);
    self.min1.frame = CGRectMake(178 + (kScreenW/2 - 126.5), numY, 15, 17);
    self.min2.frame = CGRectMake(194 + (kScreenW/2 - 126.5), numY, 15, 17);
    _label4.frame = CGRectMake(213 + (kScreenW/2 - 126.5), labelY, 20, 35);
    _line1.frame = CGRectMake(20, labelY + 17, (kScreenW - 213)/2 - 20 - 10, 1);
    _line2.frame = CGRectMake(kScreenW /2 + 213/2 + 10, labelY + 17, (kScreenW - 213)/2 - 20 - 10, 1);
}

#pragma mark -------------计算cell高度

+(CGFloat)calculateHeightForSectionOneWithString:(NSString *)str{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(kScreenW - 30, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil];
    return rect.size.height + 120 + 0.01;
}

+(CGFloat)calculateHeightForSectionThreeWithString:(NSString *)str{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(kScreenW - 35, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    return rect.size.height + 145 + 0.01;
}
@end
