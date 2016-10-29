//
//  VTHttpTool.m
//  TLMTraveling
//
//  Created by 杨胜超 on 15/6/14.
//  Copyright (c) 2015年 杨胜超. All rights reserved.
//

#import "VTHttpTool.h"
#import "AFNetworking.h"
@implementation VTHttpTool

+ (void)upLoadImageWithOption:(NSDictionary *)para withInferface:(NSString *)requestURL imageArr:(NSArray*)imageArr uploadSuccess:(void (^)(AFHTTPRequestOperation *, id))success uoloadFailure:(void (^)(AFHTTPRequestOperation *, NSError *))failure progress:(void (^)(float))progress
{
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *requset = [serializer multipartFormRequestWithMethod:@"POST" URLString:requestURL parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSInteger i = 0;
        for(UIImage *image in imageArr)
        {
            UIImage *newImage = [VTGeneralTool imageCompressForWidth:image targetWidth:640];
            NSData *imageData  = UIImagePNGRepresentation(newImage);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"picfile%ld",(long)i] fileName:@"image.png" mimeType:@"image/jpeg"];
            i++;
        }
    } error:nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:requset success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(operation,dict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat xx = totalBytesExpectedToWrite;
        CGFloat yy = totalBytesWritten;
        CGFloat pro = yy/xx;
        progress(pro);
    }];
    [operation start];
}

+ (void)upLoadAudioWithOption:(NSDictionary *)para withInferface:(NSString *)requestURL imageArr:(NSArray*)imageArr uploadSuccess:(void (^)(AFHTTPRequestOperation *, id))success uoloadFailure:(void (^)(AFHTTPRequestOperation *, NSError *))failure progress:(void (^)(float))progress
{
    
}

+ (void)upLoadVideoWithOption:(NSDictionary *)para withInferface:(NSString *)requestURL videoPath:(NSURL *)videoURL uploadSuccess:(void (^)(AFHTTPRequestOperation * , id))success uoloadFailure:(void (^)(AFHTTPRequestOperation *, NSError *))failure progress:(void (^)(float))progress
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSString *mp4Path = [NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
    exportSession.outputURL = [NSURL fileURLWithPath: mp4Path];
    exportSession.outputFileType = AVFileTypeMPEG4;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        switch ([exportSession status]) {
            case AVAssetExportSessionStatusFailed:
            {
                
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"错误"
                                                                message:[[exportSession error] localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
                [alert show];
                break;
            }
                
            case AVAssetExportSessionStatusCancelled:
                
                break;
            case AVAssetExportSessionStatusCompleted:
            {
                
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                //text/plain
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
                AFHTTPRequestOperation *opera = [manager POST:requestURL parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                    
                    NSData *videoData = [NSData dataWithContentsOfFile:mp4Path];
                    [formData appendPartWithFileData:videoData name:@"video000" fileName:@"video000.mp4" mimeType:@"video/mpeg4"];
                    
                } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    success(operation,dict);

                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                    failure (operation,error);
                }];
                
                [opera setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                    CGFloat xx = totalBytesExpectedToWrite;
                    CGFloat yy = totalBytesWritten;
                    CGFloat pro = yy/xx;
                    progress(pro);
                }];
                [opera start];
                break;
            }
            default:
                break;
        }
    }];
    
}

+(void)upLoadVoiceWithOption:(NSDictionary *)para withInferface:(NSString *)requestURL VoiceData:(NSData *)voiceData uploadSuccess:(void (^)(AFHTTPRequestOperation *, id))success uoloadFailure:(void (^)(AFHTTPRequestOperation *, NSError *))failure progress:(void (^)(float))progress{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // xmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    AFHTTPRequestOperation *opera = [manager POST:requestURL parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:voiceData name:@"sounddd" fileName:@"sounddd.mp3" mimeType:@"mp3"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(operation,dict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure (operation,error);
    }];
    
    [opera setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat xx = totalBytesExpectedToWrite;
        CGFloat yy = totalBytesWritten;
        CGFloat pro = yy/xx;
        progress(pro);
    }];
    [opera start];
}


+ (void)downloadFileWithOption:(NSDictionary *)paramDic
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                      progress:(void (^)(float progress))progress

{
    
    //沙盒路径    //NSString *savedPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/xxx.zip"];
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"POST" URLString:requestURL parameters:paramDic error:nil];
    
    //以下是手动创建request方法 AFQueryStringFromParametersWithEncoding有时候会保存
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    //   NSMutableURLRequest *request =[[[AFHTTPRequestOperationManager manager]requestSerializer]requestWithMethod:@"POST" URLString:requestURL parameters:paramaterDic error:nil];
    //
    //    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    //
    //    [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    //    [request setHTTPMethod:@"POST"];
    //
    //    [request setHTTPBody:[AFQueryStringFromParametersWithEncoding(paramaterDic, NSASCIIStringEncoding) dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
        // NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
        
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        NSLog(@"下载成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(operation,error);
        
        NSLog(@"下载失败");
        
    }];
    
    [operation start];
    
}
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    // AFNetWorking
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 发生请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            NSData *data = [[NSData alloc]initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
            id dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            success(dic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postXmlWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    // AFNetWorking
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //NSDictionary *params = @{@"format": @"xml"};
    // 发生请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // AFNetWorking
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    // 发送请求
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> allFormData) {
        for (VTFormData *formData in formDataArray) {
            [allFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            NSData *data = [[NSData alloc]initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
            id dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            success(dic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // AFNetWorking
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 发生请求
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            NSData *data = [[NSData alloc]initWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding]];
            id dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            success(dic);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end


@implementation VTFormData

@end
