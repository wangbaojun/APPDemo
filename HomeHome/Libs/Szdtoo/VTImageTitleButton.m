//
//  VTImageTitleButton.m
//  SZDT_Partents
//
//  Created by szdt on 15/5/13.
//  Copyright (c) 2015年 szdt. All rights reserved.
//

#import "VTImageTitleButton.h"
#import <UIKit/UIKit.h>
@implementation VTImageTitleButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.titleLabel.textAlignment=NSTextAlignmentLeft;
        
        self.titleLabel.font=[UIFont systemFontOfSize:13.0];
        
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        NSLog(@"%f",self.imageView.frame.size.height);
        NSLog(@"%f",self.imageView.frame.size.width);
    }
    
    return self;
    
}

/**
 *  返回文本label的rect
 *
 *  @param CGRect button的rect
 *
 *  @return
 */

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    CGFloat imageW = contentRect.size.width-20;
    
    CGFloat imageH = contentRect.size.height;
    
    CGFloat imageX = 20;
    
    CGFloat imageY = 0;
    
    contentRect = (CGRect){{imageX,imageY},{imageW,imageH}};
    
    return contentRect;
    
    
}
/**
 *  返回UIImageView的rect
 *
 *  @param CGRect button的rect
 *
 *  @return
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = 17;
    
    CGFloat titleH = contentRect.size.height;
    
    CGFloat titleX = 0;
    
    CGFloat titleY = 0;
    
    contentRect = (CGRect){{titleX,titleY},{titleW,titleH}};
    
    return contentRect;
    
}

@end
