//
//  SZCourseConfirmOrderTableView.m
//  HomeHome
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "SZCourseConfirmOrderTableView.h"
#import "SZCourseOrderListCell.h"

@interface SZCourseConfirmOrderTableView()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation SZCourseConfirmOrderTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _dataArr = [NSMutableArray array];
    
    _voucherLabel = [[UILabel alloc] init];
    _voucherLabel.textColor = VTColor(255, 99, 42);
    _voucherLabel.text = @"-0";
    _voucherLabel.frame = CGRectMake(kScreenW - 140, 0, 100, 44);
    _voucherLabel.textAlignment = NSTextAlignmentRight;
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 30)];
    
    _address = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, kScreenW - 65, 58)];
    _address.numberOfLines = 0;
    _address.adjustsFontSizeToFitWidth = YES;
    
    _phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW - 130, 10, 110, 30)];
}

#pragma mark ---------tableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _dataArr.count + 1;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 44;
        }else{
            return 110;
        }
        
    }else{
        return 44;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {//全部订单
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id1"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id1"];
                cell.textLabel.text = @"全部订单";
            }
            return cell;
            
        }else{//订单列表
            SZCourseOrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"confirmOrder"];
            if (!cell) {
                cell = [[SZCourseOrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"confirmOrder"];
            }
            [cell configCellWithModel:_dataArr[indexPath.row - 1] withIndexPath:indexPath];
            return cell;
        }
        
    }else {//代金券
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id2"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id2"];
            cell.textLabel.text = @"代金券";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell addSubview:_voucherLabel];
        }
        return cell;
        
    }/*else{//确认手机号
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id3"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id3"];
            cell.textLabel.text = @"确认手机号";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell addSubview:_phoneNumLabel];
        }
        return cell;
    }*/
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {//代金券
        [self.pushDelegate pushToVoucherListViewController];
    }
//    else if (indexPath.section == 2){//确认手机号
//        [self.pushDelegate pushToConfirmPhoneNumberViewController];
//    }
}


#pragma mark --------public method
-(void)createNoAddressHeader{
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 70)];
    header.backgroundColor = [UIColor whiteColor];
    
    UIImageView * location = [[UIImageView alloc] initWithFrame:CGRectMake(20, 25, 20, 20)];
    location.image = [UIImage imageNamed:@"course_address_location"];
    [header addSubview:location];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 160, 20)];
    label.text = @"请添加您的收获地址";
    [header addSubview:label];
    
    UIImageView * arrow = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW - 30, 25, 10, 20)];
    arrow.image = [UIImage imageNamed:@"course_right_arrow"];
    [header addSubview:arrow];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [header addGestureRecognizer:tap];
    
    self.tableHeaderView = header;
}

-(void)createHeaderWith:(NSString *)name andAddRess:(NSString *)address andPhone:(NSString *)phone{
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 100)];
    header.backgroundColor = [UIColor whiteColor];
    
    self.userNameLabel.text = [NSString stringWithFormat:@"收货人:%@",name];
    [header addSubview:self.userNameLabel];
    
    self.address.text = [address stringByReplacingOccurrencesOfString:@"," withString:@""];
    [header addSubview:self.address];
    
    self.phoneNumLabel.text = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    [header addSubview:self.phoneNumLabel];
    
    UIImageView * arrow = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW - 20, 45, 10, 20)];
    arrow.image = [UIImage imageNamed:@"course_right_arrow"];
    [header addSubview:arrow];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [header addGestureRecognizer:tap];
    
    self.tableHeaderView = header;
}

-(void)freshHeaderWith:(SZAddressListModel *)model{
    self.userNameLabel.text = model.UserName;
    self.phoneNumLabel.text = [model.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    
    self.address.text = [model.addr stringByReplacingOccurrencesOfString:@"," withString:@""];
    
}

-(void)tap:(UITapGestureRecognizer *)tap{
    [self.pushDelegate pushtoAddressListViewController];
}

@end
