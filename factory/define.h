//
//  define.h
//  factory
//
//  Created by chenqing on 2018/2/22.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#ifndef define_h
#define define_h

//LOG
#ifdef DEBUG
//#if (1)
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

// 单例
#undef    AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

#pragma mark 通知

#define WG_NOTIFICATION_ACCOUNT_LOGIN_OTHER  @"WG_NOTIFICATION_ACCOUNT_LOGIN_OTHER"  //其它设备上登录
#define WG_NOTIFICATION_ACCOUNT_NOT_LOGIN    @"WG_NOTIFICATION_ACCOUNT_NOT_LOGIN"   //没有登录
#define WG_NOTIFICATION_ACCOUNT_LOGOUT       @"WG_NOTIFICATION_ACCOUNT_LOGOUT"      //退出登录
#define WG_NOTIFICATION_ACCOUNT_LOGIN_SUCCESS   @"WG_NOTIFICATION_ACCOUNT_LOGIN_SUCCESS"    //登录成功
#define WG_NOTIFICATION_ACCOUNT_DISABLE      @"WG_NOTIFICATION_ACCOUNT_DISABLE"             //不允许登录

//解绑阿里云
#pragma mark 第三方登录 统计
#define Bugly_APPID             @"a89afa7ff2"   // bugly
//aliyun推送
#define PUSH_APP_KEY            @"23652209"
#define PUSH_APP_SECRET         @"6cc20b452caf9b61ca2ac90e0a328287"
//微信
#define WEIXIN_LOGIN_APP_ID         @"wx8e2ed1492b025220"
#define WEIXIN_LOGIN_APP_KEY        @"34c45e4bd4675210523c389e17e75631"
//qq
#define QQ_LOGIN_APP_ID         @"101377355"
#define QQ_LOGIN_APP_KEY        @"3f5b613ab3a683916891d505ed3a1b9e"

//新浪微博AppKey  回调
#define WEIBO_APPKEY            @"4290341919"
#define WEIBO_APPSECRET         @"9ab55786f9002475f26e05a6cfab1429"
#define WEIBO_REDRIRECT_URL     @"http://sns.whalecloud.com/sina2/callback"

//baidu统计
#define BAIDU_APPID           @"530d9e1fe1"

#define kNavigationHeight self.navigationController.navigationBar.frame.size.height
#define kStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kTabBarHeight [UITabBar appearance].frame.size.height

#pragma mark 定义加载方法

#define LoadColor(exp)      [UIColor colorWithHexString:exp]
#define LoadFont(exp)       [UIFont systemFontOfSize:exp]
#define LoadFontBold(exp)   [UIFont boldSystemFontOfSize:exp]
#define LoadImage(exp)      [UIImage imageNamed:exp]


#endif /* define_h */
