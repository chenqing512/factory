//
//  WGWeiBoCaller.h
//  factory
//
//  Created by Qing Chen on 2018/4/12.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeiboSDK/WeiboSDK.h>

typedef void(^WeiBoAuthBlock)(WeiboSDKResponseStatusCode state,WBAuthorizeResponse *oauth);
typedef void(^WeiBoHttpBlock)(BOOL success,NSString * result);

@interface WGWeiBoCaller : NSObject<WeiboSDKDelegate,WBHttpRequestDelegate>
AS_SINGLETON(WGWeiBoCaller);

/**
 微博绑定，若未过期，则本地立即返回；若过期，执行认证流程。
 */
- (void)weiboAuthorize:(WeiBoAuthBlock)aCompletion;
/**
 获取用户基本信息
 */
- (void)weiboGetUserInfo:(WBAuthorizeResponse *)oauth acompletion:(WeiBoHttpBlock)aCompletion;
/**
 获取用户好友列表，最大支持200个好友，暂未处理分页的情况。
 */
- (void)weiboGetFriends:(WBAuthorizeResponse *)oauth acompletion:(WeiBoHttpBlock)aCompletion;
//暂只需要文字微博
- (void)weiboPost:(WBAuthorizeResponse *)oauth contens:(NSString *)contents acompletion:(WeiBoHttpBlock)aCompletion;


- (void) sendLinkContent:(NSString *) title
                  webUrl:(NSString *) webUrl
             description:(NSString *) description
                imageUrl:(NSString *) imageUrl;

@end
