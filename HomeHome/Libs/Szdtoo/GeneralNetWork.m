//
//  GeneralNetWork.m
//  SZDT_Partents
//
//  Created by 杨胜超 on 15/5/26.
//  Copyright (c) 2015年 szdt. All rights reserved.
//

#import "GeneralNetWork.h"
#import "PointTitleView.h"
@implementation GeneralNetWork

+(void)sendDataWithUrl:(NSString *)url
{
    HttpDownLoadBlock *http = [[HttpDownLoadBlock alloc]initWithUrlStr:url setBlock:^(HttpDownLoadBlock *http, BOOL isFinsh) {
        if (isFinsh)
        {
            NSLog(@"url = %@:的请求结果:%@",url,http.dataDict);
           // [PointTitleView showPointWithTitle:http.dataDict[@"msg"]];
        }
        else
        {
            NSLog(@"url = %@网络错误请求失败",url);
        }
    }];
}

@end
