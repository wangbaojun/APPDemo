//
//  GeneralNetWork.h
//  SZDT_Partents
//
//  Created by 杨胜超 on 15/5/26.
//  Copyright (c) 2015年 szdt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpDownLoadBlock.h"
@interface GeneralNetWork : NSObject

+ (void)sendDataWithUrl:(NSString *)url;

@end
