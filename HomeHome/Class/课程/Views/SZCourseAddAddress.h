//
//  SZCourseAddAddress.h
//  HomeHome
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"
#import "HZAreaPickerView.h"
#import "SZAddressListModel.h"

@protocol SZCourseAddAddressDelegate <NSObject>

-(void)saveAddress;

@end

@interface SZCourseAddAddress : UITableView

@property(nonatomic, strong) UITextField *consignee;//收货人
@property(nonatomic, strong) UITextField *contact;//联系方式
@property(nonatomic, strong) UITextField *postCode;//邮政编码
@property(nonatomic, strong) UITextField *area;//省市区
@property(nonatomic, strong) UIButton *setDefaultAddressBtn;
@property(nonatomic, strong) HPGrowingTextView *detailedAddress;//详细地址选择器
@property(nonatomic, strong) HZAreaPickerView *areaPicker;//区域选择器
@property(nonatomic, copy) NSString *areaAddress;//地址选择器拼接的字符串

@property(nonatomic, assign) BOOL whetherDefaultAddress;//是否设置为默认地址

@property(nonatomic, assign) id<SZCourseAddAddressDelegate> saveDelegate;

-(void)getAddressInfoWithModel:(SZAddressListModel *)addressInfo;
@end
