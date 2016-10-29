//
//  SZAddressListTableView.h
//  HomeHome
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SZAddressListModel;
@class SZAddressListTableView;

@protocol SZAddressListTableViewDelegate <NSObject>
/**
 * 进入修改地址界面
 *
 *  @param index 要修改地址的行数
 *  @param model 要修改的原始信息
 */
-(void)pushWithIndex:(NSInteger)index andModel:(SZAddressListModel *)model;

-(void)SZAddressListTableView:(SZAddressListTableView *)tableview didSelectIndexPath:(NSIndexPath*)indexPath;

@end

@interface SZAddressListTableView : UITableView
@property(nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic, assign) id<SZAddressListTableViewDelegate> pushdelegate;
@property(nonatomic, copy) NSString *defaultAddId;
@property(nonatomic, assign) int selectRow;

-(void)refreshWithjson:(NSDictionary *)json;
@end
