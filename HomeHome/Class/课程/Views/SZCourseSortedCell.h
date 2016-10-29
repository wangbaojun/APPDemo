//
//  SZCourseSortedCell.h
//  SZDT_Partents
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 szdt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZCourseSortedCell : UITableViewCell
//分类学科
@property(nonatomic, strong) UILabel *subject;
//选中该学科的标志:竖线
@property(nonatomic, strong) UILabel *selectFlag;

@end
