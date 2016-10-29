//
//  SZCourseSortedTabelView.h
//  SZDT_Partents
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 szdt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SZCourseSortedTabelView;

@protocol SZCourseSortedTabelViewDelegate<NSObject>

-(void)SZCourseSortedTabelView:(SZCourseSortedTabelView *)tableview getSubeject:(NSString *)subject;

@end

@interface SZCourseSortedTabelView : UITableView

@property(nonatomic, assign) int selectedRow;
@property(nonatomic, assign) id<SZCourseSortedTabelViewDelegate>getSubjectDelegate;
@end
