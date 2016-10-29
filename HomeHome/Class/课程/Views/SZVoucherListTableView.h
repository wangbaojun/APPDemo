//
//  SZVoucherListTableView.h
//  HomeHome
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SZVoucherListTableViewDelegate <NSObject>

-(void)freshWithPageNum:(int)pageNum;

@end

@interface SZVoucherListTableView : UITableView

@property(nonatomic, assign) float orignPrice;//订单的原始金额,不减去代金券的金额
@property(nonatomic, copy) NSString *defaultCouponsId;//默认代金券id
@property(nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic, assign) int selectRow;
@property(nonatomic, assign) id<SZVoucherListTableViewDelegate> freshDelegate;

-(void)refreshWith:(NSDictionary *)json;
@end
