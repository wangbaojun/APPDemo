//
//  SZCourseSearchTableView.h
//  HomeHome
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SZCourseSearchTableView;

@protocol SZCourseSearchTableViewDelegate <NSObject>

-(void)pushWithText:(NSString *)text;

-(void)SZCourseSearchTableViewDidScroll:(SZCourseSearchTableView*)SZCourseSearchTableView;

@end

@interface SZCourseSearchTableView : UITableView
@property(nonatomic, strong) NSMutableArray *dataArr;

@property(nonatomic, assign) id<SZCourseSearchTableViewDelegate> pushDelegate;
@end
