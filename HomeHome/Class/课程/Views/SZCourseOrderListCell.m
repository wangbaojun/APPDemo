//
//  SZCourseOrderListCell.m
//  SZDT_Partents
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 szdt_jzZhang. All rights reserved.
//

#import "SZCourseOrderListCell.h"

@interface SZCourseOrderListCell ()
{
    UIView * _contentView;
    
    UIButton * _deleteOrder;
    

}

@end

@implementation SZCourseOrderListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createContentUI];
        
        if ([reuseIdentifier isEqualToString:@"shoppingCart"]) {
            [self adjustFramForShoppingCart];
            
        }else if ([reuseIdentifier isEqualToString:@"confirmOrder"]){
            [self adjustFramForConfirmOrder];
        }
        
        [self initUI];
    }
    
    return self;
}

#pragma mark ---------UI
-(void)createContentUI{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.selectOrder = [UIButton buttonWithType:UIButtonTypeSystem];
    self.selectOrder.frame = CGRectMake(10, 45, 20, 20);
    [self.selectOrder setBackgroundImage:[UIImage imageNamed:@"course_choose"] forState:UIControlStateNormal];
    [self.selectOrder setBackgroundImage:[UIImage imageNamed:@"course_choose_pre"]  forState:UIControlStateSelected];
    self.selectOrder.tintColor = [UIColor whiteColor];
    [self.selectOrder addTarget:self action:@selector(selectSelf:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectOrder];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenW - 50, 80)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_contentView];
    
    self.courseImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 80)];
    [_contentView addSubview:self.courseImage];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 3, kScreenW - 50 - 130 - 24, 15)];
    self.nameLabel.textColor = [UIColor grayColor];
    [_contentView addSubview:self.nameLabel];
    
    _deleteOrder = [UIButton buttonWithType:UIButtonTypeSystem];
    _deleteOrder.frame = CGRectMake(kScreenW - 50 - 22, 0, 20, 20);
    [_deleteOrder addTarget:self action:@selector(deleteSelf:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteOrder setImage:[[UIImage imageNamed:@"course_shoppingCart_delete"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    
    [_contentView addSubview:_deleteOrder];
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(130, 25, 100, 30)];
    self.price.textColor = VTColor(255, 58, 0);
    [_contentView addSubview:self.price];
    
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 65, 40, 15)];
    _countLabel.text = @"数量";
    _countLabel.textColor = [UIColor grayColor];
    [_contentView addSubview:_countLabel];
    
    self.count = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW - 50 - 100, 65, 100, 20)];
    self.count.textAlignment = NSTextAlignmentRight;
    self.count.textColor = [UIColor grayColor];
    [_contentView addSubview:self.count];
}


/**
 *  购物车页面中,调整contentView的fram
 */
-(void)adjustFramForShoppingCart{
    _contentView.frame = CGRectMake(40, 15, kScreenW - 50, 80);
    _deleteOrder.hidden = NO;
}

/**
 *  确认订单页面中,调整contentView的fram
 */
-(void)adjustFramForConfirmOrder{
    _contentView.frame = CGRectMake(10, 15, kScreenW - 50, 80);
    self.nameLabel.frame = CGRectMake(130, 3, kScreenW - 50 - 130, 15);
    _deleteOrder.hidden = YES;
}

-(void)initUI{
    

    
}


#pragma mark ----------btnMethod
/**
 *  选中该课程
 *
 *  @param button 
 */
-(void)selectSelf:(UIButton *)button{
    
    if ([self.courseOrderListCellDelegate respondsToSelector:@selector(SZCourseOrderListCell:selectButtonClicked:)]) {
        [self.courseOrderListCellDelegate SZCourseOrderListCell:self selectButtonClicked:button];
    }
}


/**
 *  删除该课程
 *
 *  @param button
 */
-(void)deleteSelf:(UIButton *)button{
    if ([self.courseOrderListCellDelegate respondsToSelector:@selector(SZCourseOrderListCell:deleteButtonClicked:)]) {
        [self.courseOrderListCellDelegate SZCourseOrderListCell:self deleteButtonClicked:button];
    }
}

-(void)configCellWithModel:(SZCourseShoppingCartModel *)model withIndexPath:(NSIndexPath *)indexPath{
    
    self.indexPath = indexPath;
    
    self.nameLabel.text = model.title;
#warning placeHolderImage
    [self.courseImage sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"123"]];
    
    self.count.text = [NSString stringWithFormat:@"x%d",[model.buyNum intValue]];
    
    NSString *price = [NSString stringWithFormat:@"¥%@", model.price];
    
    NSMutableAttributedString * priceNow = [[NSMutableAttributedString alloc] initWithString:price];
    [priceNow setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:21]} range:NSMakeRange(0, 1)];
    [priceNow setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:28]} range:NSMakeRange(1, price.length - 1)];
    self.price.attributedText = priceNow;
}

@end
