 //
//  SZCourseBuyWindow.h
//  SZDT_Partents
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 szdt_jzZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SZCourseBuyWindowDelegate <NSObject>
/**
 *  确定:立即购买
 */
-(void)buyNow;

/**
 *  确定:加入购物车
 */
-(void)addToShoppingCart;

@end

@interface SZCourseBuyWindow : UIWindow

/**
 *  yes表示为立即购买,no表示为加入购物车
 */
@property(nonatomic, assign) BOOL isBuy;

@property(nonatomic, assign) int maxBuyCount;

@property(nonatomic, assign) id buyWindowDelegate;

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel * price;
@property(nonatomic, strong) UILabel * nameLbael;
@property(nonatomic, strong) UILabel *subTitle;
@property(nonatomic, strong) UILabel *buyCount;

+(instancetype)defaultBuyWindow;
-(void)initUIWithDic:(NSDictionary *)courseInfo;
/**
 *  隐藏购买窗口
 */
-(void)hideSelf;

@end
