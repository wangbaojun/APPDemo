//
//  UIView+Badge.m
//  PCShop
//
//  Created by 丁丁 on 14-4-23.
//  Copyright (c) 2014年 丁丁. All rights reserved.
//

#import "UIView+Badge.h"

#import <QuartzCore/QuartzCore.h>

#import <objc/runtime.h>

#define BadgeLabelKey @"__BadgeLabelKey"

#define DEGREES_TO_RADIANS(n)  (n/180.0f) *M_PI

@interface BadgeLabel : UIView

@property(nonatomic,copy)  NSString *text;
@property(nonatomic,strong) UIFont *font;
@property(nonatomic,strong) UIColor *textColor;

@end

@implementation BadgeLabel

-(id)initWithFrame:(CGRect)frame{

    if (self =[super initWithFrame:frame]) {
        
        self.text =@"";
        self.font =[UIFont systemFontOfSize:12.0f];
        self.textColor =[UIColor whiteColor];
        
        self.backgroundColor =[UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{

    CGFloat wdith =self.frame.size.width;
    CGFloat height =self.frame.size.height;

    UIBezierPath *bezierPath =[UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(wdith/2, height/2) radius:wdith/2 startAngle:DEGREES_TO_RADIANS(366) endAngle:DEGREES_TO_RADIANS(0) clockwise:YES];
    [bezierPath closePath];
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(con, [UIColor redColor].CGColor);

    [[UIColor redColor] setFill];
    [bezierPath fill];
    
    if ([[UIDevice currentDevice].systemVersion intValue] >=7.0) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.alignment =NSTextAlignmentCenter;
        
        NSArray *arrayObjs =[NSArray arrayWithObjects:self.textColor,self.font,paragraphStyle,nil];
        NSArray *arrayKeys =[NSArray arrayWithObjects:NSForegroundColorAttributeName,NSFontAttributeName,NSParagraphStyleAttributeName,nil];
        NSDictionary *dict=[NSDictionary dictionaryWithObjects:arrayObjs forKeys:arrayKeys];
        
        [self.text drawInRect:CGRectMake(0, 0, wdith, height) withAttributes:dict];
    }
    else{
    
        CGSize sizeText =[self.text sizeWithFont:self.font];
        [self.textColor set];
        [self.text drawInRect:CGRectMake((wdith -sizeText.width)/2, (height -sizeText.height)/2, sizeText.width, sizeText.height) withFont:self.font lineBreakMode:NSLineBreakByCharWrapping];
    }

}

-(void)setText:(NSString *)text{

    _text =[text copy];
    
    [self setNeedsDisplay];
}

@end

@implementation UIView (Badge)

-(void)setBadgeLabel:(BadgeLabel *)label{
    
    objc_setAssociatedObject(self, BadgeLabelKey, label,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BadgeLabel *)badgeLabel{
    
    return objc_getAssociatedObject(self, BadgeLabelKey);
}

-(void)setBadge:(NSString *)badgeString{
    BadgeLabel *badgeLabel =(BadgeLabel *)[self badgeLabel];
    if (badgeString ==nil || [badgeString isEqualToString:@""] || [badgeString isEqualToString:@"0"]) {
        //如果badgeString 为nil、空字符串、0 ，则不显示，直接返回
        [badgeLabel removeFromSuperview];
        return;
    }
    if (badgeLabel ==nil || ![badgeLabel isKindOfClass:[BadgeLabel class]]) {
        badgeLabel =[[BadgeLabel alloc] initWithFrame:CGRectMake(self.frame.size.width -12, 0, 16, 16)];
        [self setBadgeLabel:badgeLabel];
    }
    if ([badgeString integerValue] >99 && ![badgeString isEqualToString:@""]) {
        badgeString =@"99+";
        [badgeLabel setFont:[UIFont systemFontOfSize:8.0f]];
        
    }
    badgeLabel.text =badgeString;

    [self addSubview:badgeLabel];
}

@end
