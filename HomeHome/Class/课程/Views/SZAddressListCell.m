//
//  SZAddressListCell.m
//  HomeHome
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "SZAddressListCell.h"

@implementation SZAddressListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self createUI];
        
        [self initUI];
    }
    
    return self;
}

-(void)createUI{
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 30)];
    self.name.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:self.name];
    
    self.phoneNum = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW - 150, 5, 130, 30)];
    [self.contentView addSubview:self.phoneNum];
    
    
    float height = 0;
    if (kScreenW == 320) {
        height = 60;
    }else{
        height = 40;
    }
    self.Address = [[UILabel alloc] initWithFrame:CGRectMake(10, 36, kScreenW - 70, height)];
    self.Address.numberOfLines = 0;
    self.Address.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.Address];
    
    self.changeAddress = [UIButton buttonWithType:UIButtonTypeSystem];
    self.changeAddress.frame = CGRectMake(kScreenW - 33, 37, 20, 20);
    self.changeAddress.hidden = YES;
    [self.changeAddress setBackgroundImage:[UIImage imageNamed:@"course_change_address"] forState:UIControlStateNormal];
    [self.changeAddress addTarget:self action:@selector(changeAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.changeAddress];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)initUI{
//    self.name.text = @"李萌";
//    
//    self.phoneNum.text = @"18226202950";
//    
//    self.Address.text = @"安徽省合肥市包河区芜湖路街道徽州大道与九华山路交口信旺九华国际1326室省合肥市包河区芜湖路街道徽州大道与九华山路交口信旺九华国际1326室";
}

-(void)configCellWithModel:(SZAddressListModel *)model{
    self.name.text = model.UserName;
    
    self.phoneNum.text = [NSString stringWithFormat:@"%@", model.phone];
    
    NSMutableString * mstr = [[NSMutableString alloc] initWithString:[model.addr stringByReplacingOccurrencesOfString:@"," withString:@""]];
    
    if ([model.Status boolValue]) {
        [mstr insertString:@"[默认]" atIndex:0];
    }
    
    self.Address.text = mstr;
}

-(void)changeAddress:(UIButton *)button{
    [self.delegate SZAddressListCell:self changeAddressButtonClicked:button];
}
@end
