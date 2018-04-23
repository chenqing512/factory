//
//  WGUser.m
//  factory
//
//  Created by Qing Chen on 2018/4/10.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGUser.h"
#import "NSObject+Manager.h"
@implementation WGUser

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"userId":@"ID"};
}

+(BOOL)isLoggedIn {
    WGUser *user = [WGUser loadSavedData];
    return user != nil;
}

@end
