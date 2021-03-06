//
//  WGSharedData.h
//  factory
//
//  Created by Qing Chen on 2018/4/10.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGUser.h"

@interface WGSharedData : NSObject

AS_SINGLETON(WGSharedData)

@property (nonatomic, strong) WGUser        *user;

@end
#define SharedData      ([WGSharedData sharedInstance])
