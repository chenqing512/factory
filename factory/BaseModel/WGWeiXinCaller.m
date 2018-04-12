//
//  WGWeiXinCaller.m
//  factory
//
//  Created by Qing Chen on 2018/4/12.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGWeiXinCaller.h"

@implementation WGWeiXinCaller
DEF_SINGLETON(WGWeiXinCaller);

- (id)init{
    if(self = [super init]){
        _scene = WXSceneSession;
        _resqType = 0;
    }
    return self;
}

-(void) changeScene:(NSInteger)scene//0:朋友 1：朋友圈
{
    _scene = scene;
}

-(void) weixinPay:(WGWeiXinPay *)wechatPay{
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = wechatPay.partnerId;
    request.prepayId = wechatPay.prepayId;
    request.package = wechatPay.package;
    request.nonceStr = wechatPay.nonceStr;
    request.timeStamp = wechatPay.timeStamp;
    request.sign = wechatPay.sign;
    [WXApi sendReq:request];
}

-(void) onReq:(BaseReq*)req
{
    DLog(@"%@",req);
}

-(void) onResp:(BaseResp*)resp
{
    
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp *response = (PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                DLog(@"支付成功");
                [_delegate weixinFinishPay];
                break;
            default:
                [_delegate weixinCancelPay];
                DLog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
        return;
    }
    
    if (resp.errCode == 0) {
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (_resqType == 0) {
            DLog(@"_access_token——going");
            [SVProgressHUD showWithStatus:@"登录中"];
            [self getAccess_token:aresp.code];
            return;
        }
    }
}

-(void)getAccess_token:(NSString *)code
{
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WEIXIN_LOGIN_APP_ID,WEIXIN_LOGIN_APP_KEY,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([[dic objectForKey:@"getAccess_token errcode"] integerValue] > 0) {
                    [SVProgressHUD dismiss];
                    [[[TAlertView alloc] initWithErrorMsg:[NSString stringWithFormat:@"getAccess_token errorcode is %ld and is %@",(long)[[dic objectForKey:@"errcode"] integerValue],[dic objectForKey:@"errmsg"]]] showStatusWithDuration:2];
                    return ;
                }
                
                _access_token = [dic objectForKey:@"access_token"];
                _openid = [dic objectForKey:@"openid"];
                _refresh_token = [dic objectForKey:@"refresh_token"];
                _expires_in = [[dic objectForKey:@"expires_in"] longLongValue] * 100 + [[NSDate date] timeIntervalSince1970];
                DLog(@"_access_token:%@",_access_token);
                [self refreshToken:_refresh_token];
            }
        });
    });
}

-(void)refreshToken:(NSString *)refreshToken{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&refresh_token=%@&grant_type=refresh_token",WEIXIN_LOGIN_APP_ID,refreshToken];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([[dic objectForKey:@"errcode"] integerValue] > 0) {
                    [SVProgressHUD dismiss];
                    [[[TAlertView alloc] initWithErrorMsg:[NSString stringWithFormat:@"refreshToken errorcode is %ld and is %@",(long)[[dic objectForKey:@"errcode"] integerValue],[dic objectForKey:@"errmsg"]]] showStatusWithDuration:2];
                    return ;
                }
                _access_token = [dic objectForKey:@"access_token"];
                _openid = [dic objectForKey:@"openid"];
                _refresh_token = [dic objectForKey:@"refresh_token"];
                _expires_in = [[dic objectForKey:@"expires_in"] longLongValue] * 100 + [[NSDate date] timeIntervalSince1970];
                [self getUserInfoWithAccessToken:_access_token andOpenId:_openid];
            }
        });
        
    });
}

- (void)getUserInfoWithAccessToken:(NSString *)accessToken andOpenId:(NSString *)openId{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openId];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if ([[dic objectForKey:@"errcode"] integerValue] > 0) {
                    [SVProgressHUD dismiss];
                    [[[TAlertView alloc] initWithErrorMsg:[NSString stringWithFormat:@"getUserInfo errorcode is %ld and is %@",[[dic objectForKey:@"errcode"] integerValue],[dic objectForKey:@"errmsg"]]] showStatusWithDuration:2];
                    return ;
                }
                WGWeiXiner *weixiner = [WGWeiXiner mj_objectWithKeyValues:dic];
                weixiner.access_token = accessToken;
                weixiner.expires_in = _expires_in;
                
                [_delegate finishAuth:weixiner];
            }
        });
    });
}

- (void) sendLinkContent:(NSString *) title
                  webUrl:(NSString *) webUrl
             description:(NSString *) description
                imageUrl:(NSString *) imageUrl
{
    if(![WXApi isWXAppInstalled]){
        [[[TAlertView alloc] initWithErrorMsg:@"你未安装微信"] showStatusWithDuration:1];
        return;
    }
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageUrl]]]]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = webUrl;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = (int)_scene;
    _resqType = 1;
    [WXApi sendReq:req];
}

-(void) RespLinkContent:(NSString *) title
                 webUrl:(NSString *) webUrl
            description:(NSString *) description
               imageUrl:(NSString *) imageUrl
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = webUrl;
    
    message.mediaObject = ext;
    
    GetMessageFromWXResp* resp = [[GetMessageFromWXResp alloc] init];
    resp.message = message;
    resp.bText = NO;
    
    [WXApi sendResp:resp];
}

@end
