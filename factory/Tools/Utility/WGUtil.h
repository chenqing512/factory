//
//  WGUtil.h
//  factory
//
//  Created by Qing Chen on 2018/4/8.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNavigationHeight self.navigationController.navigationBar.frame.size.height
#define kStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height;
#define ktabBarHeight [UITabBar appearance].frame.size.height

extern NSString *kHttpHost;

@interface WGUtil : NSObject

#pragma mark 预计算
+(CGFloat)screenHeight;
+(CGFloat)screenWidth;

/**
 创建line

 @return 返回view
 */
+(UIView *)createLine;

#pragma mark 文件处理
+(NSString *)createUplaodFileName:(long long)userID;
+(NSString *)createUplaodFilePath:(NSString *)fileName type:(NSInteger)type;
+(NSString *)createUploadCallBackBody:(NSInteger)sn fileName:(NSString *)fileName fileType:(NSString *)fileType voiceTimeLen:(long long)voiceTimeLen videoLength:(NSInteger)videoLength videoCoverID:(long long)videoCoverID videoWidth:(NSInteger)videoWidth videoHeight:(NSInteger)videoHeight albumID:(NSInteger)albumID askID:(NSInteger)askID;
+(NSString *)pathDocument;

@end
