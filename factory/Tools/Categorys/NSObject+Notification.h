//
//  NSObject+Notification.h
//  factory
//
//  Created by Qing Chen on 2018/4/8.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Notification)

+ (NSString *)NOTIFICATION;

- (void)handleNotification:(NSNotification *)notification;  // 处理通知

- (void)observeNotification:(NSString *)name;               // 注册观察者
- (void)unobserveNotification:(NSString *)name;             // 反注册观察者
- (void)unobserveAllNotifications;                          // 反注册所有通知

- (BOOL)postNotification:(NSString *)name;                                  // 发送通知
- (BOOL)postNotification:(NSString *)name withObject:(NSObject *)object;    // 发送通知 with 对象

-(NSString *)className;

@end
