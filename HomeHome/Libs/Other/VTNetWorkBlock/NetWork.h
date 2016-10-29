//
//  NetWork.h
//  MJ
//
//  Created by ldj on 14-12-13.
//  Copyright (c) 2014年 ldj. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetWorkDelegate <NSObject>

//-(void)sendBackMessage:(id)object;//把我们请求到的东西当成参数传回去

-(void)requestSuccess:(id)object; //成功

-(void)requestFail:(NSError*)error; //失败

@end

@interface NetWork : NSObject<NSURLConnectionDataDelegate>

@property(nonatomic,retain)NSMutableData *data;

@property(nonatomic,assign)id<NetWorkDelegate>delegate;

-(void)requestWithURL:(NSString*)url andInterface:(NSString*)interface andKeyArr:(NSArray*)keyArr andValueArr:(NSArray*)valueArr andType:(BOOL)isGet;

@end
