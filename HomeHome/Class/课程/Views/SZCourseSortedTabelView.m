//
//  SZCourseSortedTabelView.m
//  SZDT_Partents
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 szdt. All rights reserved.
//

#import "SZCourseSortedTabelView.h"
#import "SZCourseSortedCell.h"
#import "SZCourseSubjectModel.h"

@interface SZCourseSortedTabelView()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray * _dataSource;
}
@end

@implementation SZCourseSortedTabelView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        [self initUI];
        
        [self loadData];
    }
    
    return self;
}

-(void)initUI{
    
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableFooterView = [[UIView alloc] init];
    
    self.showsVerticalScrollIndicator = NO;
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)])
    {
        
        [self setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    
    _dataSource = [NSMutableArray array];
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    
    self.mj_header = header;
    
    [header setTitle:@"下拉刷新..." forState: MJRefreshStateIdle];
    [header setTitle:@"松手刷新..." forState: MJRefreshStatePulling];
    [header setTitle:@"正在刷新..." forState: MJRefreshStateRefreshing];
    header.stateLabel.font = [UIFont systemFontOfSize:10];
    header.lastUpdatedTimeLabel.hidden = YES;
}


#pragma mark ---------netWork
-(void)loadData{
    
    [_dataSource removeAllObjects];
    
    NSString * url = [NSString stringWithFormat:@"%@%@schoolId=%@", HOME_URL, Course_Subject_URL, [HHUserInfo getSchoolId]];
    NSLog(@"课程学科url:%@", url);
    
    [VTHttpTool getWithURL:url params:nil success:^(id json) {
       
        if ([json[@"errorCode"] isEqualToString:@"1200"]) {
            
            SZCourseSubjectModel * model = [[SZCourseSubjectModel alloc] init];
            model.name = @"全部课程";
            [_dataSource addObject:model];
            
            for (NSDictionary *dic in json[@"data"]) {
                SZCourseSubjectModel * model = [[SZCourseSubjectModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [_dataSource addObject:model];
            }
            
            
            [self reloadData];
            
        }else{
            
            [HHPointHUD showErrorWithTitle:json[@"msg"]];
            
        }
        
        [self.mj_header endRefreshing];

        
    } failure:^(NSError *error) {
//        [PointTitleView showPointWithTitle:@"网络错误"];
        [self.mj_header endRefreshing];

    }];
    
    
    [self reloadData];
}

#pragma mark ---------tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取消选选中上一行
    SZCourseSortedCell * lastCell = (SZCourseSortedCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_selectedRow inSection:0]];
    lastCell.selectFlag.hidden = YES;
    lastCell.subject.textColor = [UIColor blackColor];
    lastCell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //选中该行
    SZCourseSortedCell * cell = (SZCourseSortedCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selectFlag.hidden = NO;
    cell.subject.textColor = VTColor(18, 168, 235);
    cell.backgroundColor = [UIColor whiteColor];
    
    _selectedRow = (int)indexPath.row;
    
    SZCourseSubjectModel * model = _dataSource[indexPath.row];
    
    [self.getSubjectDelegate SZCourseSortedTabelView:self getSubeject:indexPath.row == 0?@"":model.name];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SZCourseSortedCell * cell = (SZCourseSortedCell *)[tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        cell = [[SZCourseSortedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    SZCourseSubjectModel * model =_dataSource[indexPath.row];
    cell.subject.text = model.name;
    
    if (_selectedRow == indexPath.row) {
        cell.selectFlag.hidden = NO;
        cell.subject.textColor = VTColor(18, 168, 235);
        cell.backgroundColor = [UIColor whiteColor];
        
    }else{
        cell.selectFlag.hidden = YES;
        cell.subject.textColor = [UIColor blackColor];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

@end
