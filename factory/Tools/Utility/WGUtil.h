//
//  WGUtil.h
//  factory
//
//  Created by Qing Chen on 2018/4/8.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>



extern NSString *kHttpHost;

extern NSString *kPUSH_ACCOUNT;

@interface WGUtil : NSObject

#pragma mark 预计算
+(CGFloat)screenHeight;
+(CGFloat)screenWidth;

/**
 创建line

 @return 返回view
 */
+(UIView *)createLine;
+(void)setWindowRootVC:(UIViewController *)aVC animated:(BOOL)animated;

#pragma mark 文件处理
+(NSString *)createUplaodFileName:(long long)userID;
+(NSString *)createUplaodFilePath:(NSString *)fileName type:(NSInteger)type;
+(NSString *)createUploadCallBackBody:(NSInteger)sn fileName:(NSString *)fileName fileType:(NSString *)fileType voiceTimeLen:(long long)voiceTimeLen videoLength:(NSInteger)videoLength videoCoverID:(long long)videoCoverID videoWidth:(NSInteger)videoWidth videoHeight:(NSInteger)videoHeight albumID:(NSInteger)albumID askID:(NSInteger)askID;
+(NSString *)pathDocument;

#pragma mark 获取设备信息

/**
 货物设备信息   iPhone X iPhone 8

 @return 返回值
 */
+(NSString *)getDeviceName;

/**
 获取当前系统名称

 @return 系统名称
 */
+(NSString *)getsystemName;
/**
 获取系统版本号

 @return 系统版本号
 */
+(NSString *)getsystemVersion;

/**
 APP版本号

 @return APP版本号
 */
+(NSString *)getAPPVersion;

/**
 iphone 名称

 @return iphone 名称
 */
+(NSString *)getIphoneName;

/**
 Build 号

 @return Build 号
 */
+(NSString *)getBuild;

@end
