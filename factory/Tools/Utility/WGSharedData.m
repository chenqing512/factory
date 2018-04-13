//
//  WGSharedData.m
//  factory
//
//  Created by Qing Chen on 2018/4/10.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGSharedData.h"
#import "NSObject+Manager.h"
@implementation WGSharedData
DEF_SINGLETON(WGSharedData)

-(void)setUser:(WGUser *)user{
    _user = user;
    if (_user) {
        [_user saveMe];
    }
}

@end
