//
//  WGSharedMacr.h
//  factory
//
//  Created by Qing Chen on 2018/4/10.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>



#define SharedMacr      ([WGSharedMacr sharedInstance])

@interface WGSharedMacr : NSObject

AS_SINGLETON(WGSharedMacr)

/**当前服务器url*/
@property (nonatomic, copy)NSString *currentServerUrl;

/**osss上传路径*/
@property (nonatomic, copy)NSString *upLoadFilePath;

/**阿里云推送账号*/
@property (nonatomic, copy)NSString *pushAccount;

/**云信用户名前缀*/
@property (nonatomic, copy)NSString *nimServiceUserId;

/**oss回调*/
@property(nonatomic, copy) NSString *ossCallback;

/**oss网址*/
@property(nonatomic, copy) NSString *ossDomain;

@property(nonatomic, copy) NSString *ossBucket;

@property (nonatomic,copy) NSString *OnlineServer;



@end
