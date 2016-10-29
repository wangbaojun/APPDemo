//
//  HHRootInfo.h
//  HomeHome
//
//  Created by Victor on 16/1/5.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHRootInfo : NSObject

- (id)initWithDic:(NSDictionary *)dic;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
