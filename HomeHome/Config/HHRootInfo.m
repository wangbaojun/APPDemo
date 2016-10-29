//
//  HHRootInfo.m
//  HomeHome
//
//  Created by Victor on 16/1/5.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "HHRootInfo.h"

@implementation HHRootInfo
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        [self setValuesForKeysWithDictionary:dic];
    }
    return  self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //NSLog(@"这个%@不一样",key);
}
@end
