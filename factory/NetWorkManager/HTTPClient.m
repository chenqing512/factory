//
//  HTTPClient.m
//  factory
//
//  Created by chenqing on 2018/2/23.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "HTTPClient.h"
#import <AFNetworking/AFNetworking.h>

#pragma mark 上传音视频宏定义

#define  UPLOAD_BUCKET          @"vchat"
#define UPLOAD_IMAGE            @"image"
#define UPLOAD_VOICE            @"voice"
#define UPLOAD_VIDEO            @"video"
#define  UPLOAD_CALLBACK_URL    @"oss/callback-v21"
#define  ENDPOINT               @"http://oss-cn-hangzhou.aliyuncs.com"
//  请求参数
#define REQ_KEY_VERSION         @"version"
#define REQ_KEY_SN              @"sn"
#define REQ_KEY_UID             @"userID"
#define REQ_KEY_USERKEY         @"userKey"

@interface HTTPClient(){
    OSSFederationCredentialProvider     *_credential;
}

@end

@implementation HTTPClient

+(instancetype)defaultManager{
    static HTTPClient *client=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client=[[HTTPClient alloc] init];
    });
    return client;
}

-(void)postHttp:(NSString *)path parameters:(NSDictionary *)parameters completion:(ApiCompletion)response{
    if ([parameters.allKeys containsObject:@"loading"]) {
        if ([parameters[@"loading"] integerValue]==1) {
            [SVProgressHUD dismiss];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showWithStatus:@"加载中..."];
        }
    }
    // 1.初始化单例类
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.设置非校验证书模式
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    //    添加请求头参数
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"interfaceSource"];
    [manager.requestSerializer setValue:version forHTTPHeaderField:@"interfaceVersion"];
    [manager.requestSerializer setValue: [[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"interfaceSystemVersion"];
    
    [manager POST:[NSString stringWithFormat:@"%@%@",kHttpHost,path] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        NSLog(@"域名:%@\n路径:%@\n返回值:%@",kHttpHost,path,responseObject);
        WGResponse *resp = [[WGResponse alloc] initWithResponseData:responseObject];
        if (response) {
            response(task, resp, nil);
        }
        [self handleCommonErrorWithResponse:resp withPath:path];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (![[AFNetworkReachabilityManager sharedManager] isReachable]) {
            [[[TAlertView alloc] initWithErrorMsg:@"网络请求中断，请检查网络"] showStatusWithDuration:1.5];
        }
        if (response) {
            response(task, nil, error);
        }
        NSLog(@"error");
    }];
}

-(void)handleCommonErrorWithResponse:(WGResponse *)aResponse withPath:(NSString *)aPath{
    DLog(@"aresponse errorcode is %ld",(long)aResponse.errorCode);
    if (aResponse.errorCode == ERR_USER_OTHER_LOGIN) {
        [self postNotification:WG_NOTIFICATION_ACCOUNT_LOGIN_OTHER];
    }else if (aResponse.errorCode == ERR_USER_NOT_LOGIN) {
        [self postNotification:WG_NOTIFICATION_ACCOUNT_NOT_LOGIN];
    }else if (aResponse.errorCode == ERR_USER_DISABLED){
        [self postNotification:WG_NOTIFICATION_ACCOUNT_DISABLE];
    }
}

#pragma mark - 文件上传
-(void)getOssToken{
    if (_credential == nil) {
        _credential = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken *{
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            [self addUserParameters:parameters];
            NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@oss/sts-v2/",kHttpHost] parameters:parameters error:nil];
            OSSTaskCompletionSource * tcs = [OSSTaskCompletionSource taskCompletionSource];
            NSURLSession * session = [NSURLSession sharedSession];
            
            // 发送请求
            NSURLSessionTask * sessionTask = [session dataTaskWithRequest:request
                                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                            if (error) {
                                                                [tcs setError:error];
                                                                return;
                                                            }
                                                            [tcs setResult:data];
                                                        }];
            [sessionTask resume];
            
            // 需要阻塞等待请求返回
            [tcs.task waitUntilFinished];
            
            // 解析结果
            if (tcs.task.error) {
                return nil;
            } else {
                // 返回数据是json格式，需要解析得到token的各个字段
                NSDictionary * object = [NSJSONSerialization JSONObjectWithData:tcs.task.result options:kNilOptions error:nil];
                if ([[object objectForKey:@"result"] boolValue]) {
                    OSSFederationToken * token = [OSSFederationToken new];
                    token.tAccessKey = [object objectForKey:@"accessKeyId"];
                    token.tSecretKey = [object objectForKey:@"accessKeySecret"];
                    token.tToken = [object objectForKey:@"securityToken"];
                    token.expirationTimeInGMTFormat = [object objectForKey:@"expiration"];
                    NSLog(@"get token: %@", token);
                    return token;
                }
                return nil;
            }
        }];
    }
}


-(void)uploadFileImageV50:(NSData *)fileContent sn:(NSInteger)sn type:(NSInteger)type completion:(UploadCompletion)aCompletion {
    
    OSSPutObjectRequest *put = [OSSPutObjectRequest new];
    put.bucketName = UPLOAD_BUCKET;
    NSString *fileName = [WGUtil createUplaodFileName:SharedData.user.userId];
    put.objectKey = [WGUtil createUplaodFilePath:fileName type:KLUpload_File_Image];
    put.uploadingData = fileContent;
    put.contentType = @"image/jpg";
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        
    };
    NSString *callbackBody = [WGUtil createUploadCallBackBody:sn fileName:fileName fileType:UPLOAD_IMAGE voiceTimeLen:0 videoLength:0 videoCoverID:0 videoWidth:0 videoHeight:0 albumID:0 askID:0];
    put.callbackParam = @{
                          @"callbackUrl" : [NSString stringWithFormat:@"%@%@",kHttpHost,UPLOAD_CALLBACK_URL],
                          @"callbackBody" : callbackBody
                          };
    
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:ENDPOINT credentialProvider:_credential];
    
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (aCompletion) {
            aCompletion(task);
        }
        return nil;
    }];
    
}

-(void)uploadFileVoice:(NSData *)fileContent duration:(long long)duration albumID:(NSInteger)albumID askID:(NSInteger)askID completion:(UploadCompletion)aCompletion {
    
    OSSPutObjectRequest *put = [OSSPutObjectRequest new];
    put.bucketName = UPLOAD_BUCKET;
    NSString *fileName = [WGUtil createUplaodFileName:SharedData.user.userId];
    put.objectKey = [WGUtil createUplaodFilePath:[NSString stringWithFormat:@"%@.mp3",fileName] type:KLUpload_File_Voice];
    put.uploadingData = fileContent;
    put.contentType = @"audio/mp3";
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        
    };
    NSString *callbackBody = [WGUtil createUploadCallBackBody:1 fileName:[NSString stringWithFormat:@"%@.mp3",fileName] fileType:UPLOAD_VOICE voiceTimeLen:duration*1000 videoLength:0 videoCoverID:0 videoWidth:0 videoHeight:0 albumID:albumID askID:askID];
    put.callbackParam = @{
                          @"callbackUrl" : [NSString stringWithFormat:@"%@%@",kHttpHost,UPLOAD_CALLBACK_URL],
                          @"callbackBody" : callbackBody
                          };
    
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:ENDPOINT credentialProvider:_credential];
    
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (aCompletion) {
            aCompletion(task);
        }
        return nil;
    }];
}

-(void)uploadFileVideo:(NSData *)fileContent duration:(long long)duration sn:(NSInteger)sn width:(NSInteger)width height:(NSInteger)height completion:(UploadCompletion)aCompletion {
    
    OSSPutObjectRequest *put = [OSSPutObjectRequest new];
    put.bucketName = UPLOAD_BUCKET;
    NSString *fileName = [WGUtil createUplaodFileName:SharedData.user.userId];
    put.objectKey = [WGUtil createUplaodFilePath:fileName type:KLUpload_File_Video];
    put.uploadingData = fileContent;
    put.contentType = @"video/mp4";
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSInteger percent = (NSInteger)totalByteSent * 100/totalBytesExpectedToSend;
        [_delegate showUploadVideoPercent:[NSString stringWithFormat:@"%ld%%",(long)percent]];
        DLog(@"upload video percent:%ld%%",(long)percent);
    };
    NSString *callbackBody = [WGUtil createUploadCallBackBody:1 fileName:fileName fileType:UPLOAD_VIDEO voiceTimeLen:0 videoLength:duration*1000 videoCoverID:0 videoWidth:width videoHeight:height albumID:0 askID:0];
    put.callbackParam = @{
                          @"callbackUrl" : [NSString stringWithFormat:@"%@%@",kHttpHost,UPLOAD_CALLBACK_URL],
                          @"callbackBody" : callbackBody
                          };
    
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:ENDPOINT credentialProvider:_credential];
    
    OSSTask * putTask = [client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (aCompletion) {
            aCompletion(task);
        }
        return nil;
    }];
    
}

-(void)uploadResumableVideo:(NSURL *)urlPath duration:(NSInteger)duration sn:(NSInteger)sn width:(NSInteger)width height:(NSInteger)height completion:(UploadCompletion)aCompletion{
    __block NSString * uploadId = nil;
    OSSInitMultipartUploadRequest * init = [OSSInitMultipartUploadRequest new];
    init.bucketName = UPLOAD_BUCKET;
    NSString *fileName = [WGUtil createUplaodFileName:SharedData.user.userId];
    init.objectKey = [WGUtil createUplaodFilePath:fileName type:KLUpload_File_Video];
    init.contentType = @"video/mp4";
    // 以下可选字段的含义参考：https://docs.aliyun.com/#/pub/oss/api-reference/multipart-upload&InitiateMultipartUpload
    // append.contentType = @"";
    // append.contentMd5 = @"";
    // append.contentEncoding = @"";
    // append.contentDisposition = @"";
    // init.objectMeta = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value1", @"x-oss-meta-name1", nil];
    // 先获取到用来标识整个上传事件的UploadId
    OSSClient *client = [[OSSClient alloc] initWithEndpoint:ENDPOINT credentialProvider:_credential];
    OSSTask * task = [client multipartUploadInit:init];
    [[task continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            OSSInitMultipartUploadResult * result = task.result;
            uploadId = result.uploadId;
        } else {
            NSLog(@"init uploadid failed, error: %@", task.error);
        }
        return nil;
    }] waitUntilFinished];
    // 获得UploadId进行上传，如果任务失败并且可以续传，利用同一个UploadId可以上传同一文件到同一个OSS上的存储对象
    OSSResumableUploadRequest * resumableUpload = [OSSResumableUploadRequest new];
    resumableUpload.bucketName = UPLOAD_BUCKET;
    resumableUpload.objectKey = init.objectKey;
    resumableUpload.uploadId = uploadId;
    resumableUpload.partSize = 1024 * 1024;
    resumableUpload.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSInteger percent = (NSInteger)totalByteSent * 100/totalBytesExpectedToSend;
        [_delegate showUploadVideoPercent:[NSString stringWithFormat:@"%ld%%",(long)percent]];
        DLog(@"upload video percent:%ld%%",(long)percent);
    };
    resumableUpload.uploadingFileURL = urlPath;
    NSString *callbackBody = [WGUtil createUploadCallBackBody:1 fileName:fileName fileType:UPLOAD_VIDEO voiceTimeLen:0 videoLength:duration*1000 videoCoverID:0 videoWidth:width videoHeight:height albumID:0 askID:0];
    resumableUpload.callbackParam = @{
                                      @"callbackUrl" : [NSString stringWithFormat:@"%@%@",kHttpHost,UPLOAD_CALLBACK_URL],
                                      @"callbackBody" : callbackBody
                                      };
    OSSTask * resumeTask = [client resumableUpload:resumableUpload];
    [resumeTask continueWithBlock:^id(OSSTask *task) {
        if (task.error) {
            DLog(@"error:%@",task.error);
        }
        if (aCompletion) {
            aCompletion(task);
        }
        return nil;
    }];
}

-(void)getUploadToken:(ApiCompletion)aCompletion{
    NSString *path = @"upload/getToken";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [self addUserParameters:parameters];
    [self postHttp:path parameters:parameters completion:aCompletion];
  //  return [self postPath:path parameters:parameters completion:aCompletion withMethod:@"POST"];
}


-(void)addUserParameters:(NSMutableDictionary *)aParameters {
    NSString *userKey = SharedData.user.userKey;
    
    [aParameters setObject:@(SharedData.user.userId) forKey:REQ_KEY_UID];
    if (aParameters)    {
        if (userKey.length) {
            [aParameters setObject:userKey forKey:REQ_KEY_USERKEY];
        } else {
            [aParameters setObject:@"" forKey:REQ_KEY_USERKEY];
        }
    }
}

@end
