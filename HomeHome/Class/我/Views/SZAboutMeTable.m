//
//  SZAboutMeTable.m
//  HomeHome
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 Victor. All rights reserved.
//
#define HeadHeight kScreenH*480/1334
#define CellHeight kScreenH*155/1334
#define LabHeight  kScreenH*100/1334
#define HeadWidth  kScreenH*250/1334
#import "SZHeadViewCell.h"
#import "SZSettingViewController.h"
#import "SZMyMessageViewController.h"
#import "SZMyOrderViewController.h"
#import "SZMyDataViewController.h"  //我的资料
#import "SZMyCollectionViewController.h"
#import "SZStudyPlanViewController.h"
#import "SZMyQuestionViewController.h"
#import "SZMyAnswerViewController.h"
#import "SZMyCouponsViewController.h"

#import "SZPersonInfo.h"
#import "SZAboutMeTable.h"

@interface SZAboutMeTable ()<UITableViewDataSource,UITableViewDelegate>
{
    SZPersonInfo * _info;
}
@property (nonatomic,strong)NSMutableArray * allArray;

@end

@implementation SZAboutMeTable

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if ([super initWithFrame:frame style:style])
    {
        self.delegate =self;
        self.dataSource =self;
        
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==1)
    {
        return 4;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)
    {
        return HeadHeight;
    }
    else
    {
        return CellHeight;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)
    {
        NSString * headID =@"headCell";
        SZHeadViewCell * cell =[tableView dequeueReusableCellWithIdentifier:headID];
        if (!cell)
        {
            cell =[[SZHeadViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headID];
        }
        cell.selectionStyle =UITableViewCellSelectionStyleNone;

        [cell configCellWith:_info];
        return cell;
    }
    else
    {
        NSString * itemID =@"itemCell";
        UITableViewCell * itemCell =[tableView dequeueReusableCellWithIdentifier:itemID];
        if (!itemCell)
        {
            itemCell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemID];
        }
        itemCell.selectionStyle =UITableViewCellSelectionStyleNone;
        //左侧按钮
        NSDictionary *dic1 = self.allArray[2*indexPath.row+1];
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenW/2, CellHeight)];
        [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn1.tag=10000+2*indexPath.row+1;
        UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(30, CellHeight/2-10, 25, 25)];
        img1.image=[UIImage imageNamed:dic1[@"image"]];
        UILabel *lab1 =[[UILabel alloc]initWithFrame:CGRectMake(kScreenW/6, CellHeight/2-10, 90, 22)];
        lab1.text= dic1[@"name"];
        lab1.textColor=Text_Color;
        lab1.textAlignment=NSTextAlignmentCenter;
        [btn1 addSubview:img1];
        [btn1 addSubview:lab1];
        [itemCell addSubview:btn1];
        
        //右侧按钮
        NSDictionary *dic2 = self.allArray[2*indexPath.row+2];
        UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake(kScreenW/2, 0, kScreenW/2, CellHeight)];
        [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn2.tag=10000+2*indexPath.row+2;
        UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(30, CellHeight/2-10, 25, 25)];
        img2.image=[UIImage imageNamed:dic2[@"image"]];
        UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW/6, CellHeight/2-10, 90, 22)];
        lab2.text= dic2[@"name"];
        lab2.textColor=Text_Color;
        lab2.textAlignment=NSTextAlignmentCenter;
        [btn2 addSubview:img2];
        [btn2 addSubview:lab2];
        [itemCell addSubview:btn2];
        
        //分割线
        UILabel *labline=[[UILabel alloc]initWithFrame:CGRectMake(kScreenW/2, 0, 0.4, CellHeight)];
        labline.backgroundColor=[UIColor lightGrayColor];
        [itemCell addSubview:labline];
        
        UILabel *labline2=[[UILabel alloc]initWithFrame:CGRectMake(0, CellHeight, kScreenW, 0.3)];
        labline2.backgroundColor=[UIColor lightGrayColor];
        [itemCell addSubview:labline2];

        
        
        return itemCell;
    }
}
-(void)configWithModel:(SZPersonInfo *)info
{
    _info =[[SZPersonInfo alloc]init];
    _info =info;
   
}
-(void)btnClick:(UIButton *)button
{
    
}


-(void)setUpViewController
{
    [self.allArray removeAllObjects];
    [self.allArray addObject:@{@"image":@"",@"name":@"头像",@"page":[[SZMyDataViewController alloc]init],@"title":@"头像"}];
    [self.allArray addObject:@{@"image":@"info-settings",@"name":@"设置",@"page":[[SZSettingViewController alloc]init],@"title":@"设置"}];
//    [self.allArray addObject:@{@"image":@"info-email",@"name":@"消息",@"page":[[SZMyMessageViewController alloc]init],@"title":@"消息"}];
    [self.allArray addObject:@{@"image":@"info-order",@"name":@"我的订单",@"page":[[SZMyOrderViewController alloc]init],@"title":@"我的订单"}];
    [self.allArray addObject:@{@"image":@"info-profile",@"name":@"我的资料",@"page":[[SZMyDataViewController alloc]init],@"title":@"资料"}];
    [self.allArray addObject:@{@"image":@"info-collect",@"name":@"我的收藏",@"page":[[SZMyCollectionViewController alloc]init],@"title":@"我的收藏"}];
    [self.allArray addObject:@{@"image":@"info-plan",@"name":@"学习计划",@"page":[[SZStudyPlanViewController alloc]init],@"title":@"学习计划"}];
    [self.allArray addObject:@{@"image":@"info-quiz",@"name":@"我的提问",@"page":[[SZMyQuestionViewController alloc]init],@"title":@"我的提问"}];
    [self.allArray addObject:@{@"image":@"info-reply",@"name":@"我的回答",@"page":[[SZMyAnswerViewController alloc]init],@"title":@"我的回答"}];
    [self.allArray addObject:@{@"image":@"info-share",@"name":@"应用分享",@"page":[[UIViewController alloc]init],@"title":@"分享"}];
    [self.allArray addObject:@{@"image":@"info-discount",@"name":@"代金券",@"page":[[SZMyCouponsViewController alloc]init],@"title":@"代金券"}];
    
}

@end
