//
//  SZCourseAddAddress.m
//  HomeHome
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "SZCourseAddAddress.h"

@interface SZCourseAddAddress()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, HPGrowingTextViewDelegate, HZAreaPickerDelegate, HZAreaPickerDatasource>

@end

@interface SZCourseAddAddressCell : UITableViewCell
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) HPGrowingTextView *textView;
@end

@implementation SZCourseAddAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if ([reuseIdentifier isEqualToString:@"textField"]) {
//            self.textField = [UITextField new];
//            [self.contentView addSubview:self.textField];
        }else{
        
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, 64)];
            [self.contentView addSubview:label];
            label.text = @"详细地址";
        }
    }
    return self;
}


@end

@implementation SZCourseAddAddress


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        [self initSelf];
    }
    
    return self;
}

#pragma mark ---------init
-(void)initSelf{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self createFooter];
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    self.dataSource = self;
    self.delegate = self;
    
    self.consignee = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, kScreenW - 140, 64)];
    self.consignee.placeholder = @"请输入中文姓名";
    self.consignee.delegate = self;
    
    self.contact = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, kScreenW - 140, 64)];
    self.contact.placeholder = @"请输入收货人手机号";
    self.contact.delegate = self;
    
//    self.postCode = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, kScreenW - 140, 64)];
//    self.postCode.placeholder = @"请输入邮政编码";
//    self.postCode.delegate = self;
    
    self.area = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, kScreenW - 160, 64)];
    self.area.placeholder = @"请点击选择收获区域";
    self.area.adjustsFontSizeToFitWidth = YES;
    self.area.delegate = self;
    
    self.detailedAddress = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(130, 10, kScreenW - 140, 80)];
    self.detailedAddress.placeholder = @"请输入详细地址";
    self.detailedAddress.font = [UIFont systemFontOfSize:17];
    self.detailedAddress.delegate = self;
    
    self.setDefaultAddressBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.setDefaultAddressBtn.tintColor =[UIColor whiteColor];
    [self.setDefaultAddressBtn setBackgroundImage:[UIImage imageNamed:@"default_address_unselect"] forState:UIControlStateNormal];
    [self.setDefaultAddressBtn setBackgroundImage:[UIImage imageNamed:@"default_address_select"] forState:UIControlStateSelected];
    self.setDefaultAddressBtn.frame = CGRectMake(20, 17, 30, 30);
    [self.setDefaultAddressBtn addTarget:self action:@selector(setDefaultAddress:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)createFooter{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 130)];
    
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableFooterView = view;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = Main_Color;
    [button setTitle:@"保存并使用" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(30, 50, kScreenW - 60, 40);
    [button addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 5;
    [view addSubview:button];
}

#pragma mark ----------tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        return 90;
    }
    return 64;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 3) {//详细地址
        SZCourseAddAddressCell * cell = (SZCourseAddAddressCell *)[tableView dequeueReusableCellWithIdentifier:@"textView"];
        
        if (!cell) {
            cell = [[SZCourseAddAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"textView"];
        }
        [cell addSubview:self.detailedAddress];
        
        return cell;
    }else if (indexPath.row == 4){//设置为默认地址
        
        return [self createLastCell];
        
    }else{//收货人,联系方式,邮政编码,省 市 区
        SZCourseAddAddressCell * cell = (SZCourseAddAddressCell *)[tableView dequeueReusableCellWithIdentifier:@"textField"];
        
        if (!cell) {
            cell = [[SZCourseAddAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"textField"];
        }
        
        int row = (int)indexPath.row;
        switch (row) {
            case 0:
                [cell addSubview:self.consignee];
                break;
                
            case 1:
                [cell addSubview:self.contact];
                break;
                
//            case 2:
//                [cell addSubview:self.postCode];
//                break;
                
            case 2:
                [cell addSubview:self.area];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
                
            default:
                break;
        }
        
        if (row != 5) {
            cell.textLabel.text = @[@"收货人:", @"联系方式:", @"省、市、区:"][row];
        }
        
        return cell;
    }
   
}

-(UITableViewCell *)createLastCell{
    UITableViewCell * cell = [self dequeueReusableCellWithIdentifier:@"lastCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lastCell"];
    }
    
    [cell.contentView addSubview:self.setDefaultAddressBtn];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 140, 64)];
    label.text = @"设置为默认地址";
    [cell.contentView addSubview:label];
    
    return cell;
}

-(void)showPicker{
    self.areaPicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict withDelegate:self andDatasource:self];
    [self.areaPicker showInView:self];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self endEditing:YES];
    self.areaPicker.datasource = nil;
    self.areaPicker.delegate = nil;
    [self.areaPicker cancelPicker];
}
#pragma mark --------HZAreaPickerDatasource
-(NSArray *)areaPickerData:(HZAreaPickerView *)picker{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
    
    NSArray * arr = [NSArray arrayWithContentsOfFile:path];
    
    return arr;
}

-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker{
    
    self.area.text = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    
    self.areaAddress = [NSString stringWithFormat:@"%@,%@,%@,", picker.locate.state, picker.locate.city, picker.locate.district];
}

#pragma mark ----------textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.area) {
        [self endEditing:YES];
        [self showPicker];
        return NO;
    }else{
        return YES;
    }
}
#pragma mark ----------btnMethod
-(void)setDefaultAddress:(UIButton *)button{
    button.selected = !button.isSelected;
    
    self.whetherDefaultAddress = button.isSelected;
}

-(void)save:(UIButton *)button{
    
    if (self.consignee.text.length == 0 ||
        self.contact.text.length == 0 ||
        self.area.text.length == 0 ||
        self.detailedAddress.text.length == 0) {
        
        [HHPointHUD showErrorWithTitle:@"请输入完整的地址信息"];
        return;
        
    }else{
        if (![VTGeneralTool checkPhoneNumInput:self.contact.text]) {
            [HHPointHUD showErrorWithTitle:@"请输入正确的电话号码"];
            return;
        }
        
    }
    
    [self.saveDelegate saveAddress];
}
#pragma mark ---------触摸事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.areaPicker.datasource = nil;
    self.areaPicker.delegate = nil;
    [self.areaPicker cancelPicker];
}

#pragma mark ----------键盘事件
-(void)keyboardShow:(NSNotification *)notify{
    self.areaPicker.datasource = nil;
    self.areaPicker.delegate = nil;
    [self.areaPicker cancelPicker];
    
    CGRect convert = [self.superview convertRect:self.detailedAddress.frame fromView:self.detailedAddress.superview];
    convert.origin.y += 64;
    CGRect keyBoard = [notify.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    if (CGRectIntersectsRect(convert, keyBoard)) {
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(0, 0 - (CGRectGetMaxY(convert) - CGRectGetMinY(keyBoard) + 30), kScreenW, kScreenH - 64);
        }];
    }
}

-(void)keyboardHide:(NSNotification *)notify{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, 0, kScreenW, kScreenH - 64);
    }];
}

#pragma mark ----------public method
-(void)getAddressInfoWithModel:(SZAddressListModel *)addressInfo{
    self.whetherDefaultAddress = [addressInfo.Status boolValue];
    
    self.setDefaultAddressBtn.selected = self.whetherDefaultAddress;
    
    self.consignee.text = addressInfo.UserName;
    
    self.contact.text = addressInfo.phone;
    
    //addressInfo.addr格式为:**省,**市,**区,详细地址
    NSArray * address = [addressInfo.addr componentsSeparatedByString:@","];
    
    self.area.text = [NSString stringWithFormat:@"%@ %@ %@", address[0], address[1], address[2]];
    
    self.detailedAddress.text = address[3];
    
    self.areaAddress= [NSString stringWithFormat:@"%@,%@,%@,", address[0], address[1], address[2]];
}
@end
