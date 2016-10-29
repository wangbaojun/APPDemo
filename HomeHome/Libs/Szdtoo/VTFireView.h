//
//  VTFireView.h
//  SZDT_Partents
//
//  Created by 杨胜超 on 15/5/28.
//  Copyright (c) 2015年 szdt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VTFireView : UIView
@property (strong, nonatomic) UIImage *particleImage;
@property (assign, nonatomic) CGFloat particleScale;
@property (assign, nonatomic) CGFloat particleScaleRange;

- (void)animate;
@end
