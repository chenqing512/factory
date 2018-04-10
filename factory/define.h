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


#endif /* define_h */
