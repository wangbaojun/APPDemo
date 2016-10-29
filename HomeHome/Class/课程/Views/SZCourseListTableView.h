//
//  SZCourseListTableView.h
//  HomeHome
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SZCourseListModel;
@class SZCourseListTableView;
//刷新代理
@protocol SZCourseListTableViewFreshDelegate <NSObject>

@required
-(void)freshWithPageNum:(int)pageNum;
-(void)pushWithModel:(SZCourseListModel *)model;

@optional
-(void)SZCourseListTableViewDidScroll:(SZCourseListTableView *)SZCourseListTableView;
@end


@interface SZCourseListTableView : UITableView
/**
 *  cell的复用标示 @"courseHomePage"课程首页  @"courseSearch"
 */
@property(nonatomic, copy) NSString *iden;
@property(nonatomic, assign) int pageNum;
@property(nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic, copy) NSString *searchText;//搜索界面中的搜索关键字
@property(nonatomic, assign) id<SZCourseListTableViewFreshDelegate> freshDelegate;

-(void)refreshWithJson:(NSDictionary *)json;
@end
