//
//  HHImageInfo.h
//  HomeHome
//
//  Created by Victor on 16/3/17.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "HHUserInfo.h"

@interface HHImageInfo : HHUserInfo

@property (nonatomic,strong)NSString *desc;

@property (nonatomic,strong)NSString *url;

//@property (nonatomic,assign)NSInteger imageIndex;

+ (NSString *)getHUDImageUrl:(NSString *)smallImageUrl;
@end
