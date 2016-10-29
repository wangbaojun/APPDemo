//
//  VTFireButton.h
//  SZDT_Partents
//
//  Created by 杨胜超 on 15/5/28.
//  Copyright (c) 2015年 szdt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VTFireButton : UIButton

@property (strong, nonatomic) UIImage *particleImage;
@property (assign, nonatomic) CGFloat particleScale;
@property (assign, nonatomic) CGFloat particleScaleRange;

- (void)animate;
- (void)popOutsideWithDuration:(NSTimeInterval)duration;
- (void)popInsideWithDuration:(NSTimeInterval)duration;
@end
