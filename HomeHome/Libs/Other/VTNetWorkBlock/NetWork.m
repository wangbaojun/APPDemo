//
//  NetWork.m
//  MJ
//
//  Created by ldj on 14-12-13.
//  Copyright (c) 2014年 ldj. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork
-(void)dealloc
{
    self.data = nil;
    //[super dealloc];
}

//这个方法只能被对象调用，在这里就是self
-(void)requestWithURL:(NSString *)url andInterface:(NSString *)interface andKeyArr:(NSArray *)keyArr andValueArr:(NSArray *)valueArr andType:(BOOL)isGet
{
    self.data =[NSMutableData dataWithCapacity:0];
    
    
    NSString *urlStr = url;
    NSString *interfaceStr = interface;
    NSArray *keyArrHere = keyArr;
    NSArray *valueArrHere = valueArr;
    
    NSMutableString *reqStr = [NSMutableString stringWithCapacity:0];
    NSMutableString *objectStr = [NSMutableString stringWithCapacity:0];
    
    if(isGet)
    {
        [reqStr appendFormat:@"%@%@?",urlStr,interfaceStr];
        
        for(int i = 0;i<keyArrHere.count;i++)
        {
            [reqStr appendFormat:@"%@=%@",keyArrHere[i],valueArrHere[i]];
            if(i<keyArr.count-1)
            {
                [reqStr appendString:@"&"];
            }
        }
    }
    else
    {//post
        [reqStr appendFormat:@"%@%@",urlStr,interfaceStr];
        
        for(int i = 0;i<keyArr.count;i++)
        {
            [objectStr appendFormat:@"%@=%@",keyArr[i],valueArr[i]];
            if(i<keyArr.count-1)
            {
                [objectStr appendString:@"&"];
            }
        }
    }
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:reqStr] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10];
    if(!isGet)
    {//post
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody:[objectStr dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSURLConnection *con = [NSURLConnection connectionWithRequest:req delegate:self];
    [con start];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.delegate requestFail:error];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    id temp = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableLeaves error:nil];
    
    [self.delegate requestSuccess:temp];
}

@end








