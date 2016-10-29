//
//  SZCourseShoppingCartTableView.h
//  HomeHome
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SZCourseShoppingCartTableView;

@protocol SZCourseShoppingCartTableViewDelegate <NSObject>

-(void)getPrice:(NSString *)price;

@end

@interface SZCourseShoppingCartTableView : UITableView
@property(nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic, strong) NSMutableArray *selectedOrderArr;
@property(nonatomic, assign) id<SZCourseShoppingCartTableViewDelegate> shoppingCartDelegate;

-(void)refreshWithJson:(NSDictionary *)json;
@end
