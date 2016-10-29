//
//  SZCourseCouponsListCell.h
//  SZDT_Partents
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 szdt_jzZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZCourseCouponsListModel.h"

@class SZCourseCouponsListCell;

@protocol  SZCourseCouponsListCellDelegate<NSObject>

-(void)SZCourseCouponsListCell:(SZCourseCouponsListCell *)cell clickSelctBtn:(UIButton *)selectBtn atIndexPath:(NSIndexPath *)indexPath;

@end

@interface SZCourseCouponsListCell : UITableViewCell

@property(nonatomic, strong) UIImageView *bgImageView;
@property(nonatomic, strong) UIButton *selectBtn;
@property(nonatomic, strong) UILabel *useDes;
@property(nonatomic, strong) UILabel *useTime;
@property(nonatomic, strong) UILabel *price;

@property (nonatomic,strong)UIImageView * statusImg;

@property(nonatomic, assign) id delegate;

-(void)configCellWithModel:(SZCourseCouponsListModel *)model andIndexPath:(NSIndexPath *)indexPath;

-(void)configMyCouponsCellWithModel:(SZCourseCouponsListModel *)model withType:(NSString *)type;

@end
