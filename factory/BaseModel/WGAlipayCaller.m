//
//  WGAlipayCaller.m
//  factory
//
//  Created by Qing Chen on 2018/4/12.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGAlipayCaller.h"

@implementation WGAlipayCaller

DEF_SINGLETON(WGAlipayCaller);


-(void)payOrder:(NSString *)orderStr fromScheme:(NSString *)schemeStr{
    [[AlipaySDK defaultService] payOrder:orderStr fromScheme:schemeStr callback:^(NSDictionary *resultDic) {
        if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 9000) {
            [[WGAlipayCaller sharedInstance].delegate alipayFinishPay];
        }else if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 6001){
            [[WGAlipayCaller sharedInstance].delegate alipayCancelPay];
            DLog(@"memo = %@",[resultDic objectForKey:@"memo"]);//返回的支付结果
        }
    }];
}

@end
