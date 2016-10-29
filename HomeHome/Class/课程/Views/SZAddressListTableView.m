//
//  SZAddressListTableView.m
//  HomeHome
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "SZAddressListTableView.h"
#import "SZAddressListCell.h"
@interface SZAddressListTableView()<UITableViewDataSource, UITableViewDelegate, SZAddressListCellDelegate>
{
}
@end

@implementation SZAddressListTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
    
        [self initSelf];
    }
    
    return self;
}

-(void)initSelf{
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    self.delegate = self;
    
    self.dataSource = self;
    
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.dataArr = [NSMutableArray array];
    
    self.selectRow = -1;
    
    self.tableFooterView = [UIView new];
}

#pragma mark ----------tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (kScreenW == 320) {
        return 100;
    }else{
        return 80;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SZAddressListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[SZAddressListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.delegate = self;
    
    [cell configCellWithModel:self.dataArr[indexPath.row]];
    
    if (indexPath.row == _selectRow) {
        cell.backgroundColor = Main_Color;
        cell.changeAddress.hidden = NO;
    }else{
        cell.backgroundColor = [UIColor whiteColor];
        cell.changeAddress.hidden = YES;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中 上次 选中的行
    SZAddressListCell * lastCell = (SZAddressListCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_selectRow inSection:0]];
    lastCell.backgroundColor = [UIColor whiteColor];
    lastCell.changeAddress.hidden = YES;
    
    //选中该行
    _selectRow = (int)indexPath.row;
    SZAddressListCell * cell = (SZAddressListCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = Main_Color;
    cell.changeAddress.hidden = NO;
    
    [self.pushdelegate SZAddressListTableView:self didSelectIndexPath:indexPath];
}

//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//
//-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return @"删除";
//}
//
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return UITableViewCellEditingStyleDelete;
//}
//
//-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
//    //删UI
//    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    
//    //删数据源
//    [self.dataArr removeObjectAtIndex:indexPath.row];
//    
//    //更新
//}

#pragma mark -----------SZAddressListCellDelegate
-(void)SZAddressListCell:(SZAddressListCell *)cell changeAddressButtonClicked:(UIButton *)changeAddressButton{
    NSIndexPath * indexPath = [self indexPathForCell:cell];
    
    [self.pushdelegate pushWithIndex:indexPath.row andModel:_dataArr[indexPath.row]];
}

#pragma mark ----------public method
-(void)refreshWithjson:(NSDictionary *)json{
    [self.dataArr removeAllObjects];
    
    if ([json[@"errorCode"] isEqualToString:@"1200"]) {
        int i = 0;
        for (NSDictionary * dic in json[@"data"]) {
            SZAddressListModel * model = [[SZAddressListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
            
            if ([model.Id intValue] == [self.defaultAddId intValue] ) {
                _selectRow = i;
            }
            
            i ++;
        }
        
        if (self.dataArr.count == 0) {
            [HHPointHUD showErrorWithTitle:@"暂无收货地址,请添加地址"];
        }else{
            [self reloadData];
        }
    }
}
@end
