//
//  WGWeiBoCaller.m
//  factory
//
//  Created by Qing Chen on 2018/4/12.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGWeiBoCaller.h"

@interface WGWeiBoCaller ()

@property (nonatomic,copy)WeiBoAuthBlock authBlock;
@property (nonatomic,copy)WeiBoHttpBlock getUserInfoBlock;
@property (nonatomic,copy)WeiBoHttpBlock getFriendsBlock;
@property (nonatomic,copy)WeiBoHttpBlock postWeiBoBlock;


@end

@implementation WGWeiBoCaller
DEF_SINGLETON(WGWeiBoCaller);

- (void)weiboAuthorize:(WeiBoAuthBlock)aCompletion
{
    _authBlock=aCompletion;
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = WEIBO_REDRIRECT_URL;
    [WeiboSDK sendRequest:request];
}
- (void)weiboGetUserInfo:(WBAuthorizeResponse *)oauth acompletion:(WeiBoHttpBlock)aCompletion
{
    _getUserInfoBlock=aCompletion;
    NSDictionary * params =[NSDictionary dictionaryWithObjectsAndKeys:oauth.userID,@"uid",oauth.accessToken,@"access_token", nil];
    [WBHttpRequest requestWithAccessToken:oauth.accessToken url:@"https://api.weibo.com/2/users/show.json" httpMethod:@"GET" params:params delegate:self withTag:@"getUserInfo"];
}
- (void)weiboGetFriends:(WBAuthorizeResponse *)oauth  acompletion:(WeiBoHttpBlock)aCompletion
{
    _getFriendsBlock=aCompletion;
    NSDictionary * params =[NSDictionary dictionaryWithObjectsAndKeys:oauth.userID, @"uid"
                            , oauth.accessToken ,@"access_token"
                            , @"200", @"count"
                            , @"0", @"trim_status"
                            , nil];
    [WBHttpRequest requestWithAccessToken:oauth.accessToken url:@"https://api.weibo.com/2/friendships/friends/bilateral.json" httpMethod:@"GET" params:params delegate:self withTag:@"getFriends"];
}
- (void)weiboPost:(WBAuthorizeResponse *)oauth contens:(NSString *)contents acompletion:(WeiBoHttpBlock)aCompletion
{
    _postWeiBoBlock=aCompletion;
    //contents = [KLUtil urlEncode:contents];
    NSDictionary * params =[NSDictionary dictionaryWithObjectsAndKeys:oauth.accessToken,@"access_token",contents,@"status",nil];
    [WBHttpRequest requestWithAccessToken:oauth.accessToken url:@"https://api.weibo.com/2/statuses/update.json" httpMethod:@"POST" params:params delegate:self withTag:@"postWeiBo"];
}

- (void) sendLinkContent:(NSString *) title
                  webUrl:(NSString *) webUrl
             description:(NSString *) description
                imageUrl:(NSString *) imageUrl{
    
    
    WBMessageObject *message = [WBMessageObject new];
    message.text = [NSString stringWithFormat:@"%@ %@",description,webUrl];
    WBImageObject *imageObj = [WBImageObject new];
    imageObj.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageUrl]]];
    message.imageObject = imageObj;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    [WeiboSDK sendRequest:request];
}

#pragma mark -- WBHttpRequestDelegate
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    if([request.tag isEqualToString:@"getUserInfo"])
    {
        self.getUserInfoBlock(NO,[error description]);
    }else if ([request.tag isEqualToString:@"getFriends"])
    {
        self.getFriendsBlock(NO,[error description]);
    }else if ([request.tag isEqualToString:@"postWeiBo"])
    {
        self.postWeiBoBlock(NO,[error description]);
    }
}
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    if([request.tag isEqualToString:@"getUserInfo"])
    {
        self.getUserInfoBlock(YES,result);
    }else if ([request.tag isEqualToString:@"getFriends"])
    {
        self.getFriendsBlock(YES,result);
    }else if ([request.tag isEqualToString:@"postWeiBo"])
    {
        self.postWeiBoBlock(YES,result);
    }
}


#pragma mark --  WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    //do nothing
}
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if([response isKindOfClass:WBAuthorizeResponse.class])
    {
        self.authBlock(response.statusCode,(WBAuthorizeResponse *)response);
    }
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        
    }
}

@end
