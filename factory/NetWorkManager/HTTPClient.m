//
//  HTTPClient.m
//  factory
//
//  Created by chenqing on 2018/2/23.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "HTTPClient.h"
#import <AFNetworking/AFNetworking.h>

@implementation HTTPClient

+(instancetype)defaultManager{
    static HTTPClient *client=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client=[[HTTPClient alloc] init];
    });
    return client;
}

-(void)postHttp:(NSString *)path parameters:(NSDictionary *)parameters completion:(ResponseData)response{
    // 1.初始化单例类
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.设置非校验证书模式
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    /*    添加请求头参数
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"interfaceSource"];
    [manager.requestSerializer setValue:version forHTTPHeaderField:@"interfaceVersion"];
    [manager.requestSerializer setValue: [[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"interfaceSystemVersion"];
    */
    [manager POST:[NSString stringWithFormat:@"%@%@",kHttpHost,path] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"域名:%@\n路径:%@\n返回值:%@",kHttpHost,path,responseObject);
        response(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}

@end
