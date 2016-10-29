//
//  HHUserInfo.h
//  HomeHome
//
//  Created by Victor on 16/1/5.
//  Copyright © 2016年 Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHUserInfo : NSObject
//CoreArchiiver_MODEL_H

/**
 用户登录信息{
 consume = 0;
 errorCode = 0;
 isBinding = 0;
 isCollection = 0;
 isPerfect = 0;
 isZambia = 0;
 loginType = 23;
 msg = "";
 name = "";
 nickName = "";
 stuId = "";
 teachComment = "";
 userHeadImage = "";
 userId = 34;
 }
 */

//历史消费积分
@property (nonatomic,copy) NSString *consume;
//是否绑定校方帐号
@property (nonatomic,copy) NSString *isBinding;
//新手任务----是否收藏
@property (nonatomic,copy) NSString *isCollection;
//新手任务----是否完善个人信息
@property (nonatomic,copy) NSString *isPerfect;
//新手任务----是否点赞
@property (nonatomic,copy) NSString *isZambia;

@property (nonatomic,copy) NSString *loginType;

@property (nonatomic,copy) NSString *msg;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *nickName;

@property (nonatomic,copy) NSString *stuId;

@property (nonatomic,copy) NSString *teachComment;

@property (nonatomic,copy) NSString *userHeadImage;

@property (nonatomic,copy) NSString *userId;

@property (nonatomic,copy) NSString *infoId;

-(id)initWithDic:(NSDictionary*)dic;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
+ (void)clearUserInfo;

+ (NSString *)getIsZambia;

+ (NSString *)getIsCollection;
//获取用户信息表id
+ (NSString *)getInfoId;
//获取头像地址
+ (NSString *)getUserHead;
//获取昵称
+ (NSString *)getNickName;
//获取stuId
+ (NSString *)getStuId;
//获取学校id
+ (NSString *)getSchoolId;
//获取用户id
+ (NSString *)getUserId;
//获取用户类型
+ (NSString *)getUserType;
//获取用户姓名
+ (NSString *)getUserName;
//获取是否完善个人信息
+(NSString *)getIsPerfect;
//获取用户个性签名
+ (NSString *)getMsg;



+ (void)reLogin;


+ (void)refreshUserMessageWithKey:(NSString *)key value:(NSString *)value;


@end
