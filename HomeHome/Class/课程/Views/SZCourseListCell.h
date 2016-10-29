//
//  SZCourseListCell.h
//  SZDT_Partents
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 szdt_jzZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZCourseListModel.h"

@interface SZCourseListCell : UITableViewCell

@property(nonatomic, strong) UILabel *courseName;
@property(nonatomic, strong) UILabel *restTimeLabel;
@property(nonatomic, strong) UILabel *priceNow;
@property(nonatomic, strong) UILabel *priceAgo;
@property(nonatomic, strong) UIImageView *mainImage;
@property(nonatomic, strong) UILabel *finishLabel;
@property(nonatomic, strong) UILabel *isLootAll;
@property(nonatomic, strong) UILabel *day1;
@property(nonatomic, strong) UILabel *day2;
@property(nonatomic, strong) UILabel *hour1;
@property(nonatomic, strong) UILabel *hour2;
@property(nonatomic, strong) UILabel *min1;
@property(nonatomic, strong) UILabel *min2;

-(void)confingCellWithModel:(SZCourseListModel *)courseListModel;

/**
 *  计算剩余时间,刷新UI
 */
-(void)freshRestTime;

/**
 *  搜索界面中将课程名变成红色
 */
-(void)setCourseTitleRedColorWithSearchText:(NSString *)searchText;
@end
