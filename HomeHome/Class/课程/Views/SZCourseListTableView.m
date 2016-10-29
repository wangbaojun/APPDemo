//
//  SZCourseListTableView.m
//  HomeHome
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "SZCourseListTableView.h"
#import "MJRefresh.h"
#import "SZCourseListCell.h"
#import "SZCourseListModel.h"
#import "SZCourseDetailViewController.h"
@interface SZCourseListTableView()<UITableViewDataSource, UITableViewDelegate>
{        
   __block int _lastPageCount;
}
@end

@implementation SZCourseListTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        [self initSelf];
        
    }
    
    return self;
}

-(void)initSelf{
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _dataArr = [NSMutableArray array];
    _pageNum = 1;
    
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNum = 1;
        [self.freshDelegate freshWithPageNum:_pageNum];
    }];
    
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageNum ++ ;
        [self.freshDelegate freshWithPageNum:_pageNum];
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(countDown) userInfo:nil repeats:YES];

}

#pragma mark ---------delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 250;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SZCourseListCell * cell = (SZCourseListCell *)[tableView dequeueReusableCellWithIdentifier:self.iden];
    
    if (!cell) {
        cell = [[SZCourseListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.iden];
    }
    
    [cell confingCellWithModel:_dataArr[indexPath.section]];
    
    if ([self.iden isEqualToString:@"courseSearch"]) {
        
        [cell setCourseTitleRedColorWithSearchText:self.searchText];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.freshDelegate pushWithModel:_dataArr[indexPath.section]];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.freshDelegate respondsToSelector:@selector(SZCourseListTableViewDidScroll:)]) {
        [self.freshDelegate SZCourseListTableViewDidScroll:self];
    }
}

#pragma mark ---------other Methods

/**
 *  倒计时
 */
-(void)countDown{
    if (self.isDecelerating) {
        return;
    }
    
    for (SZCourseListCell * cell in [self visibleCells] ) {
        [cell freshRestTime];
    }
}


#pragma mark ---------public Methods
-(void)refreshWithJson:(NSDictionary *)json {
    
        if (_pageNum == 1) {
            [_dataArr removeAllObjects];
        }
        
        for (NSDictionary * dic in json[@"data"]) {
            SZCourseListModel * model = [[SZCourseListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArr addObject:model];
            
        }
        
        if (_dataArr.count == 0) {
            [HHPointHUD showMessageWithTitle:@"未找到相关课程" time:1.5];
        }
        
        if (_lastPageCount == _dataArr.count && _pageNum != 1) {
            [HHPointHUD showMessageWithTitle:@"没有更多课程" time:1.5];
            _pageNum --;
        }else{
            _lastPageCount = (int)_dataArr.count;
        }
        
        [self reloadData];
}

@end
