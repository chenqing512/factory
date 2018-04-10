//
//  HTTPClient.h
//  factory
//
//  Created by chenqing on 2018/2/23.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGResponse.h"
#import <OSSTaskCompletionSource.h>
#import <OSSTask.h>
#import <OSSClient.h>
#import <OSSModel.h>

typedef void(^SendCompletion)(BOOL success);
typedef void(^ApiCompletion)(NSURLSessionDataTask *task, WGResponse *aResponse, NSError* anError);
typedef void (^ApiProgress)(long long sent, long long expectSend);
typedef void (^UploadCompletion)(OSSTask *task);


@protocol WGHTTPClientDelegate <NSObject>

/**
 上传进度

 @param percentStr 上传进度
 */
-(void)showUploadVideoPercent:(NSString *)percentStr;

@end

@interface HTTPClient : NSObject

@property (nonatomic, weak) id<WGHTTPClientDelegate> delegate;

+(instancetype)defaultManager;

-(void)postHttp:(NSString *)path parameters:(NSDictionary *)parameters completion:(ApiCompletion)response;

#pragma mark - 文件上传
/**--
 上传图片
 @param fileContent    文件数据
 @param sn             序号
 @param type           上传类型
 @param aCompletion 回调Block
 */
-(void)uploadFileImageV50:(NSData *)fileContent sn:(NSInteger)sn type:(NSInteger)type completion:(UploadCompletion)aCompletion;


/**--
 上传声音
 @param fileContent    文件数据
 @param duration       时长
 @param albumID        上传声音时对应的albumID
 @param askID          问答的ID，如果不是问答传0
 @param aCompletion     回调Block
 */
-(void)uploadFileVoice:(NSData *)fileContent duration:(long long)duration albumID:(NSInteger)albumID askID:(NSInteger)askID completion:(UploadCompletion)aCompletion;

/**--
 上传视频
 @param fileContent    文件数据
 @param duration       时长
 @param sn             序号
 @param width          视频宽
 @param height         视频高
 @param aCompletion     回调Block
 */
-(void)uploadFileVideo:(NSData *)fileContent duration:(long long)duration sn:(NSInteger)sn width:(NSInteger)width height:(NSInteger)height completion:(UploadCompletion)aCompletion;

-(void)uploadResumableVideo:(NSURL *)urlPath duration:(NSInteger)duration sn:(NSInteger)sn width:(NSInteger)width height:(NSInteger)height completion:(UploadCompletion)aCompletion;

/*
 获取上传文件临时token--
 @param completion 回调Block
 */
-(void)getUploadToken:(ApiCompletion)aCompletion;

@end
