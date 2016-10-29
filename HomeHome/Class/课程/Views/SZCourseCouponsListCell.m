//
//  SZCourseCouponsListCell.m
//  SZDT_Partents
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 szdt_jzZhang. All rights reserved.
//

#import "SZCourseCouponsListCell.h"

@interface SZCourseCouponsListCell()
{
    CGFloat bgImgXX;
    
    NSIndexPath * _selfIndexPath;
}
@end

@implementation SZCourseCouponsListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self createUI];
        
        //[self initUI];
    }
    
    return self;

}

#pragma mark ---------UI
-(void)createUI{
    
    self.bgImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.bgImageView];
    
    float xSpace = 0;
    if (kScreenW == 320) {
        xSpace = 10;
    }else if (kScreenW == 375){
        xSpace = 13;
    }else{
        xSpace = 25;
    }
    
    float width = 0;
    
    if (kScreenW == 320) {
        width = 170;
    }else if (kScreenW == 375){
        width = 200;
    }else{
        width = 230;
    }
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(xSpace + 3, 10, width, 55)];
    self.price.font = [UIFont boldSystemFontOfSize:39];
    self.price.textColor = [UIColor whiteColor];
//    self.price.backgroundColor = [UIColor blackColor];
    [self.bgImageView addSubview:self.price];
    
    self.useDes = [[UILabel alloc] initWithFrame:CGRectMake(xSpace, 58, width, 30)];
    self.useDes.numberOfLines = 0;
    self.useDes.textColor = [UIColor whiteColor];
    self.useDes.adjustsFontSizeToFitWidth = YES;
//    self.useDes.backgroundColor = [UIColor redColor];
    [self.bgImageView addSubview:self.useDes];
    
    self.useTime = [[UILabel alloc] initWithFrame:CGRectMake(xSpace, 90, width, 20)];
    self.useTime.adjustsFontSizeToFitWidth = YES;
    self.useTime.textColor = [UIColor whiteColor];
//    self.useTime.backgroundColor = [UIColor blackColor];
    [self.bgImageView addSubview:self.useTime];
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.selectBtn.frame = CGRectMake(10, 57.5, 25, 25);
    [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"course_choose"] forState:UIControlStateNormal];
    [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"course_choose_pre"]  forState:UIControlStateSelected];
    self.selectBtn.tintColor = [UIColor groupTableViewBackgroundColor];
    [self.selectBtn addTarget:self action:@selector(selectSelf:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectBtn];
    
    self.statusImg =[[UIImageView alloc]init];
    [self.bgImageView addSubview:self.statusImg];
}

-(void)initUI{
    
    NSString * price = @"¥789.00";
    
    NSMutableAttributedString * mstr = [[NSMutableAttributedString alloc] initWithString:price];
    
    [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, 1)];
    
    self.price.attributedText = mstr;
    
    self.useDes.text = @"•无限制使用fsdafadsfasdfasdfasdfasdfasdf";
    
    self.useTime.text = @"•2016-12-12至2017-12-19";
    
    self.bgImageView.image = [UIImage imageNamed:@"coupon_random"];
}

-(void)configCellWithModel:(SZCourseCouponsListModel *)model andIndexPath:(NSIndexPath *)indexPath{
    
    bgImgXX =45;
    
    self.bgImageView.frame = CGRectMake(bgImgXX, 15, kScreenW - bgImgXX-10, 120);
    [self configModel:model andIndexPath:indexPath];
    
    
    

}

-(void)configMyCouponsCellWithModel:(SZCourseCouponsListModel *)model withType:(NSString *)type
{
    bgImgXX = 20;
    self.selectBtn.frame = CGRectZero;
    CGFloat XX = kScreenW - bgImgXX-20;
    self.bgImageView.frame = CGRectMake(bgImgXX, 15,XX , 120);
//    self.statusImg.hidden =
    if ([type isEqualToString:@"1"])
    {
        self.statusImg .frame = CGRectMake( bgImgXX + 2*XX/3, 60, XX/3-20, 60);
        if ([model.couStatus integerValue]==29)
        {
            self.statusImg.image =[UIImage imageNamed:@"coupon_used"];
        }
        if ([model.couStatus integerValue]==28)
        {
            self.statusImg.image = [UIImage imageNamed:@"coupon_expired"];
        }
        
    }
   
    [self configModel:model andIndexPath:nil];
    
}

-(void)configModel:(SZCourseCouponsListModel *)model andIndexPath:(NSIndexPath *)indexPath
{
    _selfIndexPath = indexPath;
    
    if ([model.type intValue] == 0) {
        self.bgImageView.image = [UIImage imageNamed:@"coupon_equal"];
    }else {
        self.bgImageView.image = [UIImage imageNamed:@"coupon_random"];
    }
    
    self.useDes.text = [NSString stringWithFormat:@"•%@", model.content];
    if(model.content.length ==0)
    {
        self.useDes.text = @"";
    }
    self.useTime.text = [NSString stringWithFormat:@"•%@至%@", [[model.startTimeName componentsSeparatedByString:@" "] firstObject], [[model.endTimeName componentsSeparatedByString:@" "] firstObject]];
    
    NSString * price = [NSString stringWithFormat:@"¥%@", model.money];
    
    NSMutableAttributedString * mstr = [[NSMutableAttributedString alloc] initWithString:price];
    
    [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, 1)];
    
    self.price.attributedText = mstr;

}

#pragma mark ----------btnMethod
-(void)selectSelf:(UIButton *)button{
    //[self.delegate SZCourseCouponsListCell:self clickSelctBtn:button atIndexPath:_selfIndexPath];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
