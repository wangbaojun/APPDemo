//
//  VTHttpTool.h
//  TLMTraveling
//
//  Created by 杨胜超 on 15/6/14.
//  Copyright (c) 2015年 杨胜超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface VTHttpTool : NSObject

//多图上传
+ (void)upLoadImageWithOption:(NSDictionary *)para
                withInferface:(NSString*)requestURL
                     imageArr:(NSArray*)imageArr
              uploadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              uoloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                     progress:(void (^)(float progress))progress;

//视频上传
+ (void)upLoadVideoWithOption:(NSDictionary *)para withInferface:(NSString *)requestURL videoPath:(NSURL *)videoURL uploadSuccess:(void (^)(AFHTTPRequestOperation * operation, id responseObject))success uoloadFailure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure progress:(void (^)(float progress))progress;

//音频上传
+ (void)upLoadVoiceWithOption:(NSDictionary *)para withInferface:(NSString *)requestURL VoiceData:(NSData *)voiceData uploadSuccess:(void (^)(AFHTTPRequestOperation * operation, id responseObject))success uoloadFailure:(void (^)(AFHTTPRequestOperation * operation, NSError *error))failure progress:(void (^)(float progress))progress;



+ (void)downloadFileWithOption:(NSDictionary *)paramDic
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                      progress:(void (^)(float progress))progress;
/**
 *  发送一个post请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)postXmlWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  发送一个post请求,带上传文件
 *
 *  @param url           请求路径
 *  @param params        请求参数
 *  @param formDataArray 保存（多个）文件数据的数组
 *  @param success       请求成功后的回调
 *  @param failure       请求失败后的回调
 */

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;
/**
 *  发送一个get请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

@end

/**
 *  文件数据模型
 */
@interface VTFormData : NSObject

/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;


@end


