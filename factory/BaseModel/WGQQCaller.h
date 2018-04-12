//
//  WGQQCaller.h
//  factory
//
//  Created by Qing Chen on 2018/4/12.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "TAlertView.h"

typedef void(^QQAuthBlock)(BOOL success, TencentOAuth *oauth);
typedef void(^QQApiRespBlock)(APIResponse *response);

@protocol KLQQCallerDelegate <NSObject>

-(void)finishQQLogin;

@end

@interface WGQQCaller : NSObject

AS_SINGLETON(WGQQCaller)
@property (nonatomic, retain)TencentOAuth *oauth;
@property (nonatomic, weak) id<KLQQCallerDelegate>   delegate;

#pragma mark - actions
-(void)authorize;
-(void)authorize:(QQAuthBlock)aCompletion;
-(void)getUserInfo:(QQApiRespBlock)aCompletion;
//-(void)getFriends:(QQApiRespBlock)aCompletion;
//-(BOOL)postWeibo:(NSString *)content completion:(QQApiRespBlock)aCompletion;
//
-(void)shareToFriend:(NSString *) title
              webUrl:(NSString *) webUrl
         description:(NSString *) description
            imageUrl:(NSString *) imageUrl;

-(void)shareToQQZone:(NSString *) title
              webUrl:(NSString *) webUrl
         description:(NSString *) description
            imageUrl:(NSString *) imageUrl;

-(void)clearGetFriendsBlock;

@end

#define kQQLoginSuccessed                   @"kQQLoginSuccessed"
#define kQQLoginFailed                      @"kQQLoginFailed"
#define kQQGetUserInfoResponse              @"kQQGetUserInfoResponse"
#define kQQAddShareResponse                 @"kQQAddShareResponse"
#define kQQGetIntimateFriendsResponse        @"kQQGetIntimateFriendsResponse"
#define kQQResponse                          @"kQQResponse"
#define kQQMessage                           @"kQQMessage"
#define kQQResponseDidReceived                  @"kQQResponseDidReceived"
#define kQQTencentOAuth                         @"kQQTencentOAuth"
#define kQQCloseWnd                             @"kQQCloseWnd"
#define kQQUIViewController                     @"kQQUIViewController"
