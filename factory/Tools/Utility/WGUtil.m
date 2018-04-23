//
//  WGUtil.m
//  factory
//
//  Created by Qing Chen on 2018/4/8.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGUtil.h"
#import "sys/utsname.h"
#import "WGShare.h"
#import "WGWeiXinCaller.h"
#import "WGWeiBoCaller.h"
#import "WGQQCaller.h"

#ifdef DEBUG
NSString *kHttpHost = @"http://sh.pairui6.com/";//测试环境
NSString *kPUSH_ACCOUNT = @"smkj_test";  //PUSH COUNT

#else
NSString *kHttpHost = @"http://sh.pairui6.com/";//正式环境
NSString *kPUSH_ACCOUNT = @"smkj_test";

#endif

CGFloat kLoadingTime = 1.5;
NSString *kLoading = @"kLoading";


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

#pragma mark -- 页面跳转
+(void)setWindowRootVC:(UIViewController *)aVC animated:(BOOL)animated {
    if (aVC) {
        UIViewController *oldRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        if (animated) {
            [UIView transitionFromView:oldRootVC.view toView:aVC.view duration:0.5f options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
                [UIApplication sharedApplication].keyWindow.rootViewController = aVC;
            }];
        } else {
            [UIApplication sharedApplication].keyWindow.rootViewController = aVC;
        }
    }
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

#pragma mark 获取设备信息

/**
 货物设备信息   iPhone X iPhone 8
 
 @return 返回值
 */
+ (NSString *)getDeviceName
{
    // 需要#import "sys/utsname.h"

    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"国行(A1863)、日行(A1906)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"美版(Global/A1905)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"国行(A1864)、日行(A1898)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"美版(Global/A1897)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"国行(A1865)、日行(A1902)iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"美版(Global/A1901)iPhone X";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,11"])    return @"iPad 5 (WiFi)";
    if ([deviceString isEqualToString:@"iPad6,12"])    return @"iPad 5 (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,1"])     return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,2"])     return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,3"])     return @"iPad Pro 10.5 inch (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,4"])     return @"iPad Pro 10.5 inch (Cellular)";
    
    if ([deviceString isEqualToString:@"AppleTV2,1"])    return @"Apple TV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])    return @"Apple TV 4";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}

/**
 获取当前系统名称
 
 @return 系统名称
 */
+(NSString *)getsystemName{
    return [UIDevice currentDevice].systemName;
}
/**
 获取系统版本号
 
 @return 系统版本号
 */
+(NSString *)getsystemVersion{
    return [UIDevice currentDevice].systemVersion;
}

/**
 APP版本号
 
 @return APP版本号
 */
+(NSString *)getAPPVersion{
    return [[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"];
}

/**
 iphone 名称
 
 @return iphone 名称
 */
+(NSString *)getIphoneName{
    return [UIDevice currentDevice].name;
}

/**
 Build 号
 
 @return Build 号
 */
+(NSString *)getBuild{
    return [[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleVersion"];
}

#pragma mark 分享
/**
 分享类
 
 @param share share
 */
+(void)shareWithShare:(WGShare *)share{
    switch (share.type) {
        case ZZShareWeixin:{
            WGWeiXinCaller *weixinCaller = [WGWeiXinCaller sharedInstance];
            [weixinCaller changeScene:0];
            [weixinCaller sendLinkContent:share.wechatTitle webUrl:share.wechatBrowseUrl description:share.wechatIntroduction imageUrl:share.imageUrl];
        }
            break;
        case ZZShareWeixinQuest:{
            WGWeiXinCaller *weixinCaller = [WGWeiXinCaller sharedInstance];
            [weixinCaller changeScene:1];
            [weixinCaller sendLinkContent:share.wechatIntroduction webUrl:share.wechatBrowseUrl description:share.wechatTitle imageUrl:share.imageUrl];
        }
            break;
        case ZZShareWeibo:{
            [[WGWeiBoCaller sharedInstance] sendLinkContent:share.weiboTitle webUrl:share.nonWechatBrowseUrl description:share.weiboIntroduction imageUrl:share.imageUrl];
        }
            break;
        case ZZShareQQ:{
            [[WGQQCaller sharedInstance] shareToFriend:share.qqTitle webUrl:share.nonWechatBrowseUrl description:share.qqIntroduction imageUrl:share.imageUrl];
        }
            break;
        case ZZShareQQZone:{
            [[WGQQCaller sharedInstance] shareToQQZone:share.qqTitle webUrl:share.nonWechatBrowseUrl description:share.qqIntroduction imageUrl:share.imageUrl];
        }
            break;
            
        case ZZShareLink:{
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setString:share.wechatBrowseUrl];
            [[[TAlertView alloc] initWithSuccessMsg:@"成功复制到剪贴板"] showStatusWithDuration:1];
        }
            break;
        default:
            break;
    }
    
}

@end
