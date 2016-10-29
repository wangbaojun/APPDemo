//
//  SZCourseShoppingCartTableView.m
//  HomeHome
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "SZCourseShoppingCartTableView.h"
#import "SZCourseOrderListCell.h"

@interface SZCourseShoppingCartTableView()<UITableViewDataSource, UITableViewDelegate, SZCourseOrderListCellDelegate>
{
    UIButton * _selectAllBtn;//全选

    SZCourseOrderListCell * _delegateCell;//要删除的cell
}
@end

@implementation SZCourseShoppingCartTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.dataArr = [NSMutableArray array];
        self.selectedOrderArr = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark ------------tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 44;
    }else{
        return 110;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        
        if (!cell) {
            cell = [self createCellForFirstCell];
        }
        
        return cell;
        
    }else{
        SZCourseOrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingCart"];
        if (!cell) {
            cell = [[SZCourseOrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shoppingCart"];
            cell.courseOrderListCellDelegate = self;
        }
        [cell configCellWithModel:_dataArr[indexPath.row - 1] withIndexPath:indexPath];
        
        if ([_selectedOrderArr containsObject:cell.indexPath]) {
            cell.selectOrder.selected = YES;
        }else{
            cell.selectOrder.selected = NO;
        }
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        [self selectAllOrder:_selectAllBtn];
        
    }else{
        SZCourseOrderListCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [self SZCourseOrderListCell:cell selectButtonClicked:cell.selectOrder];
    }
    
    
}

-(UITableViewCell *)createCellForFirstCell{
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _selectAllBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _selectAllBtn.frame = CGRectMake(10, 15, 20, 20);
    _selectAllBtn.tintColor = [UIColor whiteColor];
    [_selectAllBtn setBackgroundImage:[UIImage imageNamed:@"course_choose"] forState:UIControlStateNormal];
    [_selectAllBtn setBackgroundImage:[UIImage imageNamed:@"course_choose_pre"] forState:UIControlStateSelected];
    [_selectAllBtn addTarget:self action:@selector(selectAllOrder:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:_selectAllBtn];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(40, 16, 100, 20)];
    label.text = @"全部订单";
    [cell addSubview:label];
    
    return cell;
}
#pragma mark ----------SZCourseOrderListCellDelegate
-(void)SZCourseOrderListCell:(SZCourseOrderListCell *)cell deleteButtonClicked:(UIButton *)deleteButton{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要删除该课程吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    _delegateCell = cell;
    
    [alert show];

}
-(void)SZCourseOrderListCell:(SZCourseOrderListCell *)cell selectButtonClicked:(UIButton *)selected{
    //选中该行
    if (selected.isSelected) {
        
        [_selectedOrderArr removeObject:cell.indexPath];
        
    }else{
        
        [_selectedOrderArr addObject:cell.indexPath];
    }
    
    //判断选中改行之后是否全选
    if (_selectedOrderArr.count == _dataArr.count) {
        _selectAllBtn.selected = YES;
    }else{
        _selectAllBtn.selected = NO;
    }
    
    //计算价格
    [self calculatPrice];
    
    selected.selected = !selected.isSelected;
}

#pragma mark ----------alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSLog(@"删除购物车");
        [self netWorkForDeleteShoppingCart];
    }
}

#pragma mark ----------btnMethods
/**
 *  全部订单
 *
 *  @param button 全部订单
 */
-(void)selectAllOrder:(UIButton *)button{
    
    if (_dataArr.count == 0) {
        return;
    }
    
    if (button.selected == YES) {//取消全选
        
        [_selectedOrderArr removeAllObjects];
        
        for (UITableViewCell * cell in [self visibleCells]) {
            
            if ([cell isKindOfClass:[SZCourseOrderListCell class]]) {
                SZCourseOrderListCell * orderCell = (SZCourseOrderListCell *)cell;
                orderCell.selectOrder.selected = NO;
            }
        }
        
    }else{//全选
        
        [_selectedOrderArr removeAllObjects];
        
        //更新数据源
        for (int i = 1; i < _dataArr.count + 1; i ++) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [_selectedOrderArr addObject:indexPath];
        }
        
        //更新UI
        for (UITableViewCell * cell in [self visibleCells]) {
            if ([cell isKindOfClass:[SZCourseOrderListCell class]]) {
                SZCourseOrderListCell * orderCell = (SZCourseOrderListCell *)cell;
                orderCell.selectOrder.selected = YES;
            }
        }
    }
    [self calculatPrice];
    button.selected = !button.isSelected;
}

/**
 *  计算价格 更新UI
 */
-(void)calculatPrice{
    int sumCount = 0;
    
    for (NSIndexPath * indexPath in _selectedOrderArr) {
        
        int index = (int)indexPath.row - 1;
        
        SZCourseShoppingCartModel * model = _dataArr[index];
        
        sumCount += [model.price intValue] * [model.buyNum intValue];
    }

    [self.shoppingCartDelegate getPrice:[NSString stringWithFormat:@"%d", sumCount]];
}

#pragma mark -----------netWork(删除购物车)
-(void)netWorkForDeleteShoppingCart{
    SZCourseShoppingCartModel * model = _dataArr[_delegateCell.indexPath.row - 1];
    
    NSString * url = [NSString stringWithFormat:@"%@%@id=%@", HOME_URL, Course_DelegateShoppingCart_URL, model.id];
    NSLog(@"删除购物车url:%@", url);
    
    [VTHttpTool getWithURL:url params:nil success:^(id json) {
        
        if ([json[@"errorCode"] isEqualToString:@"1200"]) {
            [HHPointHUD showSuccessWithTitle:@"删除成功"];
            [self freshUIAfterDeleteShoppingCartNetwork];
            
        }else{
            [HHPointHUD showSuccessWithTitle:@"删除失败"];
        }
        
    } failure:^(NSError *error) {
        
    }];

}
/**
 *  删除购物车网络请求成功后刷新UI
 */
-(void)freshUIAfterDeleteShoppingCartNetwork{

    //删数据源
    [_dataArr removeObjectAtIndex:_delegateCell.indexPath.row - 1];
    
    //更新_selectOrder数组
    if ([_selectedOrderArr containsObject:_delegateCell.indexPath]) {
        [_selectedOrderArr removeObject:_delegateCell.indexPath];
    }
    for (int i = 0; i < _selectedOrderArr.count; i++) {
        NSIndexPath * indexPath = _selectedOrderArr[i];
        if (indexPath.row > _delegateCell.indexPath.row) {
            NSIndexPath * newIndex = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
            [_selectedOrderArr replaceObjectAtIndex:i withObject:newIndex];
        }
    }
    
    //更新UI
    if (_dataArr.count == 0) {
        _selectAllBtn.selected = NO;
    }else if (_dataArr.count == _selectedOrderArr.count){
        _selectAllBtn.selected = YES;
    }
    
    [self reloadData];
    [self calculatPrice];
    UIViewController * vc = (UIViewController *)self.shoppingCartDelegate;
    vc.navigationItem.title = [NSString stringWithFormat:@"购物车(%ld)", _dataArr.count];

}

#pragma mark ------------public method
-(void)refreshWithJson:(NSDictionary *)json{
    for (NSDictionary *dic in json[@"data"]) {
        SZCourseShoppingCartModel * model = [[SZCourseShoppingCartModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArr addObject:model];
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
