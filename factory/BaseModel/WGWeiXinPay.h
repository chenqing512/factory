//
//  WGWeiXinPay.h
//  factory
//
//  Created by Qing Chen on 2018/4/12.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGWeiXinPay : NSObject

@property(nonatomic,copy) NSString* appId;
@property(nonatomic,copy) NSString* nonceStr;
@property(nonatomic,copy) NSString* package;
@property(nonatomic,copy) NSString* partnerId;//商户号
@property(nonatomic,copy) NSString* prepayId;//预付单号
@property(nonatomic,assign) UInt32 timeStamp;
@property(nonatomic,copy) NSString* sign;

@end
