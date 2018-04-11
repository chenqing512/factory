//
//  WGUtil.m
//  factory
//
//  Created by Qing Chen on 2018/4/8.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGUtil.h"

#ifdef DEBUG
NSString *kHttpHost = @"http://www.pairui9.com/";//测试环境
#else
NSString *kHttpHost = @"http://www.pairui9.com/";//正式环境
#endif

@implementation WGUtil

+(CGFloat)screenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}
+(CGFloat)screenWidth{
    return [UIScreen mainScreen].bounds.size.width;
}
/**
 创建line
 
 @return 返回view
 */
+(UIView *)createLine{
    UIView  *view = [UIView new];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1f];
    return view;
}

#pragma mark 命名上传文件的文件名
+(NSString *)createUplaodFileName:(long long)userID{
    NSString *scope = @"0123456789abcdefghijklmnopqrstuvwxyz";
    NSMutableString *scopeString = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%lld_%lld_",userID,(long long)[[NSDate date] timeIntervalSince1970] * 1000]];
    for (NSInteger i = 0; i < 20; i++) {
        NSInteger index = arc4random() % scope.length;
        [scopeString appendString:[NSString stringWithFormat:@"%@",[scope substringWithRange:NSMakeRange(index, 1)]]];
    }
    
    return scopeString;
}

+(NSString *)createUplaodFilePath:(NSString *)fileName type:(NSInteger)type{
    NSString *typeDir = @"";
    switch (type) {
        case KLUpload_File_Image:
            typeDir = @"image/";
            break;
        case KLUpload_File_Video:
            typeDir = @"video/";
            break;
        case KLUpload_File_Voice:
            typeDir = @"voice/";
            break;
        default:
            break;
    }
    NSString *filePath = [NSString stringWithFormat:@"%@%@",typeDir,fileName];
    return filePath;
}

+(NSString *)createUploadCallBackBody:(NSInteger)sn fileName:(NSString *)fileName fileType:(NSString *)fileType voiceTimeLen:(long long)voiceTimeLen videoLength:(NSInteger)videoLength videoCoverID:(long long)videoCoverID videoWidth:(NSInteger)videoWidth videoHeight:(NSInteger)videoHeight albumID:(NSInteger)albumID askID:(NSInteger)askID{
    NSString *callbackBody = [NSString stringWithFormat:@"userID=%ld&userKey=%@&sn=%ld&fileName=%@&fileType=%@&voiceLength=%ld&videoLength=%ld&videoCoverID=%lld&videoWidth=%ld&videoHeight=%ld&albumID=%ld&askID=%ld&isIOS=1&bucket=${bucket}&object=${object}&etag=${etag}&size=${size}&mimeType=${mimeType}&imageInfo.height=${imageInfo.height}&imageInfo.width=${imageInfo.width}&imageInfo.format=${imageInfo.format}&appName=showmay",(long)SharedData.user.userId,SharedData.user.userKey,(long)sn,fileName,fileType,(long)voiceTimeLen,(long)videoLength,videoCoverID,(long)videoWidth,(long)videoHeight,(long)albumID,(long)askID];
    return callbackBody;
}

+(NSString *)pathDocument {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return paths.firstObject;
}

@end
