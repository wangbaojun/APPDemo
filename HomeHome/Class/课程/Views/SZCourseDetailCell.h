//
//  SZCourseDetailCell.h
//  SZDT_Partents
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 szdt_jzZhang. All rights reserved.
//

#import <UIKit/UIKit.h>



/*******************************未使用*********************************/


@interface SZCourseDetailCell : UITableViewCell
//上半部分
@property(nonatomic, strong) UILabel *priceNow;
@property(nonatomic, strong) UILabel *priceAgo;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *subName;
@property(nonatomic, strong) UIButton *shareBtn;
/**
 *  上半部分剩余时间
 */
@property(nonatomic, strong) UILabel *day1;
@property(nonatomic, strong) UILabel *day2;
@property(nonatomic, strong) UILabel *hour1;
@property(nonatomic, strong) UILabel *hour2;
@property(nonatomic, strong) UILabel *min1;
@property(nonatomic, strong) UILabel *min2;


//下半部分
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *teacher;
@property(nonatomic, strong) UILabel *beginTime;
@property(nonatomic, strong) UILabel *appointmentNum;
@property(nonatomic, strong) UILabel *desLabel;

+(CGFloat)calculateHeightForSectionOneWithString:(NSString *)str;

+(CGFloat)calculateHeightForSectionThreeWithString:(NSString *)str;
@end
