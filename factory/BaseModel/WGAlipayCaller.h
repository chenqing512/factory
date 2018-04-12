//
//  WGAlipayCaller.h
//  factory
//
//  Created by Qing Chen on 2018/4/12.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>

@protocol WGAlipayCallerDelegate <NSObject>

@optional
-(void)alipayFinishPay;
-(void)alipayCancelPay;

@end

@interface WGAlipayCaller : NSObject

@property (nonatomic, weak) id<WGAlipayCallerDelegate>  delegate;


-(void)payOrder:(NSString *)orderStr fromScheme:(NSString *)schemeStr;


AS_SINGLETON(WGAlipayCaller);

@end
