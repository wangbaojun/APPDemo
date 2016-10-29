//
//  HHImageInfo.m
//  HomeHome
//
//  Created by Victor on 16/3/17.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import "HHImageInfo.h"

@implementation HHImageInfo
+ (NSString *)getHUDImageUrl:(NSString *)smallImageUrl
{
    NSMutableString *str = [NSMutableString stringWithString:smallImageUrl];
    NSRange substr = [str rangeOfString:@"_thu"];
    while (substr.location != NSNotFound)
    {
        [str replaceCharactersInRange:substr withString:@""];
        substr = [str rangeOfString:@"_thu"];
    }
    [str insertString:@"" atIndex:0];
    return str;
}
@end
