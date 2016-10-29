//
//  SZCourseConfirmOrderTableView.h
//  HomeHome
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZAddressListModel.h"

@protocol SZCourseConfirmOrderTableViewDelegate <NSObject>

-(void)pushToVoucherListViewController;//进入我的代金券页面

-(void)pushtoAddressListViewController;//进入收货地址列表界面

//-(void)pushToConfirmPhoneNumberViewController;//进入确认电话号码页面

@end

@interface SZCourseConfirmOrderTableView : UITableView

@property(nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic, strong) UILabel *voucherLabel;//代金券
@property(nonatomic, strong) UILabel *phoneNumLabel;//电话号码
@property(nonatomic, strong) UILabel *address;
@property(nonatomic, strong) UILabel *userNameLabel;
@property(nonatomic, assign) id<SZCourseConfirmOrderTableViewDelegate> pushDelegate;

-(void)createNoAddressHeader;
-(void)createHeaderWith:(NSString *)name andAddRess:(NSString *)address andPhone:(NSString *)phone;
-(void)freshHeaderWith:(SZAddressListModel *)model;
@end
