//
//  SZCourseSortedCell.m
//  SZDT_Partents
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 szdt. All rights reserved.
//

#import "SZCourseSortedCell.h"

@implementation SZCourseSortedCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    self.selectFlag = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 2, 50)];
    self.selectFlag.backgroundColor = VTColor(18, 168, 235);
    self.selectFlag.hidden = YES;
    [self.contentView addSubview:self.selectFlag];
    
    int width = 0;
    if (kScreenW == 320) {
        width = 65;
    }else{
        width = 80;
    }
    
    self.subject = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, width - 3, 50)];
    self.subject.font = [UIFont systemFontOfSize:15];
    self.subject.textColor = [UIColor grayColor];
    self.subject.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.subject];
}

@end
