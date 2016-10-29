//
//  SZCourseOrderListCell.h
//  SZDT_Partents
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 szdt_jzZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZCourseShoppingCartModel.h"

@class SZCourseOrderListCell;

@protocol SZCourseOrderListCellDelegate <NSObject>

@optional
-(void)SZCourseOrderListCell:(SZCourseOrderListCell *)cell selectButtonClicked:(UIButton *)selected;

-(void)SZCourseOrderListCell:(SZCourseOrderListCell *)cell deleteButtonClicked:(UIButton *)deleteButton;

@end

@interface SZCourseOrderListCell : UITableViewCell
@property (nonatomic,strong)UILabel *countLabel;//"数量"
@property(nonatomic, strong) UIImageView *courseImage;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *price;
@property(nonatomic, strong) UILabel *count;
@property(nonatomic, strong) UIButton *selectOrder;
@property(nonatomic, strong) NSIndexPath *indexPath;

@property(nonatomic, assign) id<SZCourseOrderListCellDelegate> courseOrderListCellDelegate;

-(void)configCellWithModel:(SZCourseShoppingCartModel *)model withIndexPath:(NSIndexPath *)indexPath;

@end
