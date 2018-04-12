//
//  WGQQCaller.m
//  factory
//
//  Created by Qing Chen on 2018/4/12.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGQQCaller.h"
#import <TencentOpenAPI/QQApiInterface.h>

@interface WGQQCaller() <TencentSessionDelegate, TCAPIRequestDelegate, TencentLoginDelegate>
@property (nonatomic, retain)   NSArray         *permissons;
@property (nonatomic, copy)     QQAuthBlock      authorizeBlock;
@property (nonatomic, copy)     QQApiRespBlock      getUserInfoBlock;
@property (nonatomic, copy)     QQApiRespBlock      getFriendsBlock;
@property (nonatomic, copy)     QQApiRespBlock      postWeiboBlock;
@end

@implementation WGQQCaller

DEF_SINGLETON(WGQQCaller)

#pragma mark - actions
-(void)authorize{
    [_oauth authorize:_permissons inSafari:NO];
}

-(void)authorize:(QQAuthBlock)aCompletion {
    [_oauth authorize:_permissons inSafari:NO];
    self.authorizeBlock = aCompletion;
}

-(void)getUserInfo:(QQApiRespBlock)aCompletion {
    [_oauth getUserInfo];
    self.getUserInfoBlock = aCompletion;
}

- (id)init
{
    if (self = [super init])
    {
        NSString *appid = QQ_LOGIN_APP_ID;
        _oauth = [[TencentOAuth alloc] initWithAppId:appid
                                         andDelegate:self];
        
        //        _permissons = @[@"all"];
        _permissons =  [NSArray arrayWithObjects: kOPEN_PERMISSION_GET_USER_INFO,
                        kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, kOPEN_PERMISSION_ADD_SHARE,
                        nil];
    }
    return self;
}

-(void)shareToFriend:(NSString *) title
              webUrl:(NSString *) webUrl
         description:(NSString *) description
            imageUrl:(NSString *) imageUrl
{
    QQApiURLObject *urlObj = [QQApiURLObject objectWithURL:[NSURL URLWithString:webUrl] title:title description:description previewImageURL:[NSURL URLWithString:imageUrl]  targetContentType:QQApiURLTargetTypeNews];
    if([QQApiInterface isQQSupportApi] && [QQApiInterface isQQInstalled]){
        QQApiSendResultCode sent = [QQApiInterface sendReq:[SendMessageToQQReq reqWithContent:urlObj]];//QQ分享
        [self handleSendResult:sent];
    }else{
        [[[TAlertView alloc] initWithErrorMsg:@"你未安装QQ"] showStatusWithDuration:1];
    }
}

-(void)shareToQQZone:(NSString *) title
              webUrl:(NSString *) webUrl
         description:(NSString *) description
            imageUrl:(NSString *) imageUrl{
    QQApiURLObject *urlObj = [QQApiURLObject objectWithURL:[NSURL URLWithString:webUrl] title:title description:description previewImageURL:[NSURL URLWithString:imageUrl]  targetContentType:QQApiURLTargetTypeNews];
    if([QQApiInterface isQQSupportApi] && [QQApiInterface isQQInstalled]){
        QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:[SendMessageToQQReq reqWithContent:urlObj]];//QQZone分享
        [self handleSendResult:sent];
    }else{
        [[[TAlertView alloc] initWithErrorMsg:@"你未安装QQ"] showStatusWithDuration:1];
    }
}


- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            [[[TAlertView alloc] initWithErrorMsg:@"App未注册"] showStatusWithDuration:1];
            break;
        }
        case EQQAPIMESSAGETYPEINVALID:
        {
            [[[TAlertView alloc] initWithErrorMsg:@"发送参数错误"] showStatusWithDuration:1];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            [[[TAlertView alloc] initWithErrorMsg:@"未安装QQ"] showStatusWithDuration:1];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            [[[TAlertView alloc] initWithErrorMsg:@"API接口不支持"] showStatusWithDuration:1];
            break;
        }
        case EQQAPISENDFAILD:
        {
            [[[TAlertView alloc] initWithErrorMsg:@"发送失败"] showStatusWithDuration:1];
            break;
        }
        default:
        {
            break;
        }
    }
}




#pragma mark - TCAPIRequestDelegate
- (void)cgiRequest:(TCAPIRequest *)request didResponse:(APIResponse *)response {
    
    if (self.postWeiboBlock) {
        self.postWeiboBlock(response);
        self.postWeiboBlock = nil;
    }
}

#pragma mark - TencentSessionDelegate
- (void)tencentDidLogin
{
    //TencentOAuth *auth = self.oauth;
    //[[NSNotificationCenter defaultCenter] postNotificationName:kQQLoginSuccessed object:self];
    if (self.authorizeBlock) {
        self.authorizeBlock(YES, _oauth);
        self.authorizeBlock = nil;
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:kQQLoginFailed object:self];
    if (self.authorizeBlock) {
        self.authorizeBlock(NO, _oauth);
        self.authorizeBlock = nil;
    }
}

- (void)tencentDidNotNetWork
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:kQQLoginFailed object:self];
    if (self.authorizeBlock) {
        self.authorizeBlock(NO, _oauth);
        self.authorizeBlock = nil;
    }
}

- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams
{
    return nil;
}

- (void)tencentDidLogout
{
    
}


- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions
{
    BOOL incrAuthRes = [tencentOAuth incrAuthWithPermissions:permissions];
    return !incrAuthRes;
}


- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth
{
    return YES;
}

- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth
{
}


- (void)tencentFailedUpdate:(UpdateFailType)reason
{
}


- (void)getUserInfoResponse:(APIResponse*) response
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:kQQGetUserInfoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kQQResponse, nil]];
    if (self.getUserInfoBlock) {
        self.getUserInfoBlock(response);
        self.getUserInfoBlock = nil;
    }
}


- (void)addShareResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kQQAddShareResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kQQResponse, nil]];
}


- (void)getIntimateFriendsResponse:(APIResponse*) response
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:kQQGetIntimateFriendsResponse object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kQQResponse, nil]];
    if (self.getFriendsBlock) {
        self.getFriendsBlock(response);
        self.getFriendsBlock = nil;
    }
}

- (void)responseDidReceived:(APIResponse*)response forMessage:(NSString *)message
{
    if (nil == response
        || nil == message)
    {
        return;
    }
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                              response, kQQResponse,
                              message, kQQMessage, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kQQResponseDidReceived object:self  userInfo:userInfo];
}

- (void)tencentOAuth:(TencentOAuth *)tencentOAuth didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite userData:(id)userData
{
    
}


- (void)tencentOAuth:(TencentOAuth *)tencentOAuth doCloseViewController:(UIViewController *)viewController
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:tencentOAuth, kQQTencentOAuth,
                              viewController, kQQUIViewController, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kQQCloseWnd object:self  userInfo:userInfo];
}

-(void)clearGetFriendsBlock {
    _getFriendsBlock = nil;
}

@end
