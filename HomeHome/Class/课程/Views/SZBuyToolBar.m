//
//  SZBuyToolBar.m
//  SZDT_Partents
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 szdt_jzZhang. All rights reserved.
//

#import "SZBuyToolBar.h"

@interface SZBuyToolBar()
{
    UIViewController * _superVC;
    UIImageView * _collection;
}
@end

@implementation SZBuyToolBar

-(instancetype)initWithSuperVC:(UIViewController *)superVc{
    self = [super init];
    
    if (self) {
        _superVC = superVc;
        
        [self createUI];
    }
    
    return self;
}

-(void)createUI{
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, kScreenH - 49, kScreenW, 49);
    [_superVC.view addSubview:self];
    
    self.addToShoppingCart = [UIButton buttonWithType:UIButtonTypeSystem];
    self.addToShoppingCart.frame = CGRectMake(0, 0, kScreenW/3, 49);
    self.addToShoppingCart.backgroundColor = VTColor(255, 148, 3);
    [self.addToShoppingCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    self.addToShoppingCart.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.addToShoppingCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addToShoppingCart.tag = ADDTOSHOPPINGCART;
    [self addSubview:self.addToShoppingCart];
    
    self.buyNow = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buyNow.frame = CGRectMake(kScreenW/3, 0, kScreenW/3, 49);
    self.buyNow.backgroundColor = VTColor(255, 80, 1);
    [self.buyNow setTitle:@"立即购买" forState:UIControlStateNormal];
    [self.buyNow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.buyNow.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.buyNow.tag = BUYNOW;
    [self addSubview:self.buyNow];
    
    self.collect = [UIButton buttonWithType:UIButtonTypeSystem];
    self.collect.frame = CGRectMake(kScreenW/3 * 2, 0, kScreenW/6, 49);
    self.collect.backgroundColor = [UIColor whiteColor];
//    self.collect.tintColor = [UIColor whiteColor];
    [self.collect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.collect.tag = COLLECTION;
    _collection = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW/6 - 20)/2, 5, 20, 20)];
    _collection.image = [UIImage imageNamed:@"course_collection"];
    UILabel * collectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, kScreenW/6, 24)];
    collectionLabel.textColor = [UIColor grayColor];
    collectionLabel.font = [UIFont systemFontOfSize:14];
    collectionLabel.textAlignment = NSTextAlignmentCenter;
    collectionLabel.text = @"收藏";
    [self.collect addSubview:_collection];
    [self.collect addSubview:collectionLabel];
    [self addSubview:self.collect];
    
    self.shoppingCart = [UIButton buttonWithType:UIButtonTypeSystem];
    self.shoppingCart.frame = CGRectMake(kScreenW/6 * 5, 0, kScreenW/6, 49);
    self.shoppingCart.backgroundColor = [UIColor whiteColor];
    UIImageView * shoppingCart = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenW/6 - 20)/2, 5, 20, 20)];
    shoppingCart.image = [UIImage imageNamed:@"course_shopping"];
    UILabel * shoppingCartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, kScreenW/6, 24)];
    shoppingCartLabel.textColor = [UIColor grayColor];
    shoppingCartLabel.textAlignment = NSTextAlignmentCenter;
    shoppingCartLabel.font = [UIFont systemFontOfSize:14];
    shoppingCartLabel.text = @"购物车";
    [self.shoppingCart addSubview:shoppingCart];
    [self.shoppingCart addSubview:shoppingCartLabel];
    self.shoppingCart.tag = SHOPPINGCART;
    [self addSubview:self.shoppingCart];
    
    self.shoppingCartCount = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW - 28, 2, 15, 15)];
    self.shoppingCartCount.backgroundColor = [UIColor redColor];
    self.shoppingCartCount.layer.cornerRadius = 7.5;
    self.shoppingCartCount.clipsToBounds = YES;
    self.shoppingCartCount.font = [UIFont systemFontOfSize:11];
    self.shoppingCartCount.textAlignment = NSTextAlignmentCenter;
    self.shoppingCartCount.textColor = [UIColor whiteColor];
    self.shoppingCartCount.hidden = YES;
    [self addSubview:self.shoppingCartCount];
    
    [self.addToShoppingCart addTarget:self action:@selector(BuyToolBarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buyNow addTarget:self action:@selector(BuyToolBarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.collect addTarget:self action:@selector(BuyToolBarClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.shoppingCart addTarget:self action:@selector(BuyToolBarClicked:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)BuyToolBarClicked:(UIButton *)button{
    
    [self.buyToolBarDelegate SZBuyToolBar:self clickedButton:button andToolType:button.tag];

}

-(void)setShoppingCartCountWithCount:(int)count addWhetherCollected:(BOOL)isCollected{
    self.shoppingCartCount.text = [NSString stringWithFormat:@"%d", count];
    
    if (count == 0) {
        self.shoppingCartCount.hidden = YES;
    }else{
        self.shoppingCartCount.hidden = NO;
    }
    
    self.isCollected = isCollected;
    
    [self setCollectImage];
}

-(void)setCollectImage{
    if (self.isCollected) {
        _collection.image = [UIImage imageNamed:@"course_collection_pre"];
    }else{
        _collection.image = [UIImage imageNamed:@"course_collection"];
    }
}

@end
