//
//  SZBuyToolBar.h
//  SZDT_Partents
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 szdt_jzZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    ADDTOSHOPPINGCART = 100,
    BUYNOW,
    COLLECTION,
    SHOPPINGCART
}SZBuyToolBarToolType;

@class SZBuyToolBar;

@protocol SZBuyToolBarDelegate <NSObject>

-(void)SZBuyToolBar:(SZBuyToolBar *)toolBar clickedButton:(UIButton *)button andToolType:(SZBuyToolBarToolType)toolType;

@end

@interface SZBuyToolBar : UIView

@property(nonatomic, strong) UIButton *addToShoppingCart;
@property(nonatomic, strong) UIButton *buyNow;
@property(nonatomic, strong) UIButton *collect;
@property(nonatomic, strong) UIButton *shoppingCart;
@property(nonatomic, strong) UILabel *shoppingCartCount;
@property(nonatomic, assign) BOOL isCollected;

@property(nonatomic, assign) id<SZBuyToolBarDelegate> buyToolBarDelegate;

-(instancetype)initWithSuperVC:(UIViewController *)superVc;

-(void)setShoppingCartCountWithCount:(int)count addWhetherCollected:(BOOL)isCollected;

-(void)setCollectImage;

@end
