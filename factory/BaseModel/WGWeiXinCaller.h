//
//  WGWeiXinCaller.h
//  factory
//
//  Created by Qing Chen on 2018/4/12.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WGWeiXiner.h"
#import "TAlertView.h"
#import "WGWeiXinPay.h"

@protocol WGWeixinCallerDelegate <NSObject>

@optional
-(void)finishAuth:(WGWeiXiner *)weixiner;
-(void)weixinFinishPay;
-(void)weixinCancelPay;

@end

@interface WGWeiXinCaller : NSObject<WXApiDelegate>
{
    NSInteger _scene;
}
AS_SINGLETON(WGWeiXinCaller);

@property(nonatomic,copy) NSString* code;
@property(nonatomic,copy) NSString* access_token;
@property(nonatomic,copy) NSString* openid;
@property(nonatomic,copy) NSString* refresh_token;
@property(nonatomic,assign) long long expires_in;
@property (nonatomic, weak) id<WGWeixinCallerDelegate> delegate;
@property(nonatomic,assign) NSInteger resqType;

- (void) sendLinkContent:(NSString *) title
                  webUrl:(NSString *) webUrl
             description:(NSString *) description
                imageUrl:(NSString *) imageUrl;


-(void) changeScene:(NSInteger)scene;
-(void) weixinPay:(WGWeiXinPay *)wechatPay;

@end
