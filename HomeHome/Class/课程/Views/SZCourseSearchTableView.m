//
//  SZCourseSearchTableView.m
//  HomeHome
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "SZCourseSearchTableView.h"
#import "SZHistoryCourseSearch.h"

@interface SZCourseSearchTableView()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation SZCourseSearchTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [[UIView alloc] init];
        
        self.dataArr = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark ----------tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 40;
    }
    
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 70;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"searchHistory"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchHistory"];
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    
    if (indexPath.row == 0) {
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        
    }else{
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:19];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGFloat leftSpace = cell.separatorInset.left;
    
    UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 70)];
    UILabel * line = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace,  0, kScreenW - leftSpace, 0.38)];
    line.backgroundColor = [UIColor grayColor];
    [footView addSubview:line];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(kScreenW/2 - 75, 25, 150, 40);
    [button setTitle:@"清空搜索历史" forState:UIControlStateNormal];
    button.layer.borderWidth = 1;
    button.layer.borderColor = VTColor(18, 168, 235).CGColor;
    [button setTitleColor:VTColor(18, 168, 235) forState:UIControlStateNormal];
    button.layer.cornerRadius = 10;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(clearHistorySearch) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:button];
    
    return footView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return;
    }
    [self deselectRowAtIndexPath:indexPath animated:YES];

    [self.pushDelegate pushWithText:_dataArr[indexPath.row]];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.pushDelegate SZCourseSearchTableViewDidScroll:self];
}

#pragma mark --------btnMethods
-(void)clearHistorySearch{
    [SZHistoryCourseSearch clearHistorySearch];
    
    _dataArr = [NSMutableArray arrayWithArray:[SZHistoryCourseSearch getHistorySearch]];

    [_dataArr insertObject:@"历史搜索" atIndex:0];

    [self reloadData];
}


@end
