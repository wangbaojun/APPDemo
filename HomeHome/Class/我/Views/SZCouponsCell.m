//
//  SZCouponsCell.m
//  HomeHome
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "SZCouponsCell.h"

@interface SZCouponsCell ()
@property (nonatomic,strong)UIImageView * imgView;
@property (nonatomic,strong)UIImageView * statusImg;
@property (nonatomic,strong)UILabel * priceLabel;


@end


@implementation SZCouponsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
    }
    return self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
