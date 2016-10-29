//
//  SZAddressListCell.h
//  HomeHome
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZAddressListModel.h"

@class SZAddressListCell;
@protocol SZAddressListCellDelegate <NSObject>

-(void)SZAddressListCell:(SZAddressListCell *)cell changeAddressButtonClicked:(UIButton *)changeAddressButton;

@end

@interface SZAddressListCell : UITableViewCell
@property(nonatomic, strong) UILabel *name;
@property(nonatomic, strong) UILabel *phoneNum;
@property(nonatomic, strong) UILabel *Address;
@property(nonatomic, strong) UIButton *changeAddress;
@property(nonatomic, assign) BOOL isDefaultAddress;

@property(nonatomic, assign) id<SZAddressListCellDelegate> delegate;

-(void)configCellWithModel:(SZAddressListModel *)model;
@end
