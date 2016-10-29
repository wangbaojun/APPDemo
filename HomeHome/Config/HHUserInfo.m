//
//  HHUserInfo.m
//  HomeHome
//
//  Created by Victor on 16/1/5.
//  Copyright © 2016年 Victor. All rights reserved.
//
#import "HHConfig.h"
#import "HHUserInfo.h"

@implementation HHUserInfo
-(id)initWithDic:(NSDictionary *)dic
{//赋值
    [self setValuesForKeysWithDictionary:dic];
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{//防崩
    
}

+ (NSString *)getIsZambia
{
    NSString *userId = [SZUserDefault objectForKey:@"AccountData"][@"isZambia"];
    if (userId.length == 0)
    {
        return @"";
    }
    else
    {
        return userId;
    }
}


+ (NSString *)getIsCollection
{
    NSString *userId = [SZUserDefault objectForKey:@"AccountData"][@"isCollection"];
    if (userId.length == 0)
    {
        return @"";
    }
    else
    {
        return userId;
    }
}

+ (void)reLogin
{
    NSString *count = [SZUserDefault objectForKey:@"count"];
    NSString *pass = [SZUserDefault objectForKey:@"password"];
    
    
    NSString *registerId = [JPUSHService registrationID];
    if ([registerId length]==0)
    {
        registerId = @"";
    }
    else
    {
        registerId = [JPUSHService registrationID];
    }
    NSDictionary *dic = @{@"userName":count,@"userPass":pass,@"schoolId":[SZUserDefault objectForKey:@"schoolId"],@"registrationId":registerId,@"type":@"0"};
//    [VTHttpTool postWithURL:[NSString stringWithFormat:@"%@%@",HOME_URL,Login_Two_URL] params:dic success:^(id responseObject) {
//        NSDictionary *dic = responseObject;
//
//        if ([dic[@"errorCode"] isEqualToString:@"0"])
//        {
//            [SZUserDefault setObject:dic forKey:@"AccountData"];
//        }
//        else
//        {
//            
//        }
//    } failure:^(NSError *error) {
//        
//    }];
    
}

+ (void)refreshUserMessageWithKey:(NSString *)key value:(NSString *)value
{
    NSMutableDictionary *dic = [SZUserDefault objectForKey:@"AccountData"];
    NSArray *arr = [dic allKeys];//获取所有的key
    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithCapacity:0];
    for(NSString *temp in arr)
    {
        [newDic setObject:dic[temp] forKey:temp];
        if ([temp isEqualToString:key])
        {
            [newDic setObject:value forKey:temp];
        }
    }
    NSDictionary *dicc  = [NSDictionary dictionaryWithDictionary:newDic];
    
    [SZUserDefault setObject:dicc forKey:@"AccountData"];
    [SZUserDefault synchronize];
}

+ (void)clearUserInfo
{
    [SZUserDefault setObject:@{} forKey:@"AccountData"];
    [SZUserDefault synchronize];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"headImage.png"];
    NSFileManager *manger = [NSFileManager defaultManager];
    [manger removeItemAtPath:fullPath error:nil];
}

+ (NSString *)getInfoId
{
    NSString *userId = [SZUserDefault objectForKey:@"AccountData"][@"infoId"];
    if (userId.length == 0)
    {
        return @"";
    }
    else
    {
        return userId;
    }
}

+ (NSString *)getMsg
{
    NSString *msg = [SZUserDefault objectForKey:@"AccountData"][@"msg"];
    if (msg.length == 0)
    {
        return @"";
    }
    else
    {
        return msg;
    }
}

+ (NSString *)getUserHead
{
    NSString *userId = [SZUserDefault objectForKey:@"AccountData"][@"userHeadImage"];
    if (userId.length == 0)
    {
        return @"";
    }
    else
    {
        return userId;
    }
}

+ (NSString *)getNickName
{
    NSString *userId = [SZUserDefault objectForKey:@"AccountData"][@"nickName"];
    if (userId.length == 0)
    {
        return @"";
    }
    else
    {
        return userId;
    }
}

+ (NSString *)getStuId
{
    NSString *userId = [SZUserDefault objectForKey:@"AccountData"][@"stuId"];
    if (userId.length == 0)
    {
        return @"";
    }
    else
    {
        return userId;
    }
}

+ (NSString *)getSchoolId
{
    NSString *schoolId = [SZUserDefault objectForKey:@"schoolId"];

    if (schoolId.length == 0) {
        return @"";
    }
    
    return schoolId;
}

+ (NSString *)getUserId
{
    NSString *userId = [SZUserDefault objectForKey:@"AccountData"][@"userId"];
    if (userId.length == 0)
    {
        return @"";
    }
    else
    {
        return userId;
    }
}

+ (NSString *)getUserName
{
    NSString *userId = [SZUserDefault objectForKey:@"AccountData"][@"name"];
    if (userId.length == 0)
    {
        return @"";
    }
    else
    {
        return userId;
    }
}

+ (NSString *)getUserType
{
    NSString *userId = [SZUserDefault objectForKey:@"AccountData"][@"loginType"];
    if (userId.length == 0)
    {
        return @"";
    }
    else
    {
        return userId;
    }
}

+(NSString *)getIsPerfect
{    NSString *userId = [SZUserDefault objectForKey:@"AccountData"][@"isPerfect"];
    if (userId.length == 0)
    {
        return @"";
    }
    else
    {
        return userId;
    }
}


@end
