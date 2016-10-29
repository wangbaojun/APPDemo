//
//  SZVoucherListTableView.m
//  HomeHome
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "SZVoucherListTableView.h"
#import "SZCourseCouponsListModel.h"
#import "SZCourseCouponsListCell.h"

@interface SZVoucherListTableView()<UITableViewDataSource, UITableViewDelegate, SZCourseCouponsListCellDelegate>
{
    BOOL _isFirstSelect;
    
    int _pageNum;
}
@end

@implementation SZVoucherListTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        [self initSelf];
    }
    
    return self;
}

#pragma mark -------------init
-(void)initSelf{
    self.delegate = self;
    self.dataSource = self;
    self.tableFooterView = [UIView new];
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _selectRow = -1;
    
    _isFirstSelect = YES;
    
    _pageNum = 1;
    
    self.dataArr = [NSMutableArray array];
    
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _pageNum = 1;
        [self.freshDelegate freshWithPageNum:_pageNum];
    }];
    
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageNum ++;
        [self.freshDelegate freshWithPageNum:_pageNum];
    }];
}

#pragma mark ----------tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SZCourseCouponsListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[SZCourseCouponsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell configCellWithModel:_dataArr[indexPath.row] andIndexPath:indexPath];
    cell.delegate = self;
    
    if (_selectRow == indexPath.row) {
        cell.selectBtn.selected = YES;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //如果是第一次选择,将默认选择的代金券取消
    if (_isFirstSelect) {
        if (_selectRow != indexPath.row) {
            SZCourseCouponsListCell * cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_selectRow inSection:0]];
            cell.selectBtn.selected = NO;
            _selectRow = -1;
        }
        _isFirstSelect = NO;
    }
    
    SZCourseCouponsListModel * couponsInfo = _dataArr[indexPath.row];
    
    SZCourseCouponsListCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.selectBtn.isSelected) {
        _selectRow = -1;
        
    }else{
        
        //0：等额劵，1：随机劵
        if ([couponsInfo.type intValue] == 0) {
            
            if (self.orignPrice >= [couponsInfo.limitMoney floatValue]) {
                _selectRow = (int)indexPath.row;
                
            }else{
                [HHPointHUD showErrorWithTitle:@"未达到该代金券的使用限制"];
                return;
            }
            
        }else{
            _selectRow = (int)indexPath.row;
        }
    }
    
    cell.selectBtn.selected = !cell.selectBtn.isSelected;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    SZCourseCouponsListCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.selectBtn.selected = NO;
}

-(void)SZCourseCouponsListCell:(SZCourseCouponsListCell *)cell clickSelctBtn:(UIButton *)selectBtn atIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark -------------public method
-(void)refreshWith:(NSDictionary *)json{
    if ([json[@"errorCode"] isEqualToString:@"1"]) {
        
        if (_pageNum == 1) {
            [_dataArr removeAllObjects];
        }
        
        int i = 0;
        for (NSDictionary * dic in json[@"data"]) {
            SZCourseCouponsListModel * model = [[SZCourseCouponsListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArr addObject:model];
            
            if ([model.id intValue] == [self.defaultCouponsId intValue]) {
                _selectRow = i;
            }
            
            i ++;
        }
        [self reloadData];
        
        if (_dataArr.count == 0) {
            [HHPointHUD showMessageWithTitle:@"暂无可用的代金券" time:1.5];
        }
        
    }else{
        [HHPointHUD showErrorWithTitle:json[@"msg"]];
    }

}

@end
