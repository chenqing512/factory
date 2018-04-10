//
//  WGUser.h
//  factory
//
//  Created by Qing Chen on 2018/4/10.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGUser : NSObject

@property (nonatomic, assign) NSInteger   userId;//用户id
@property (nonatomic, copy)   NSString    *userKey;//用户key
@property (nonatomic, copy)   NSString    *phoneNumber;//电话
@property (nonatomic, copy)   NSString    *nickname;//昵称

@end
