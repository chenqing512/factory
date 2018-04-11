//
//  NSObject+Notification.m
//  factory
//
//  Created by Qing Chen on 2018/4/8.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "NSObject+Notification.h"

@implementation NSObject (Notification)

+ (NSString *)NOTIFICATION
{
    return [NSString stringWithFormat:@"notify.%@.", [self description]];
}

/**
 接受通知实现方法

 @param notification noti
 */
- (void)handleNotification:(NSNotification *)notification
{
}

/**
 添加通知

 @param name 通知名称
 */
- (void)observeNotification:(NSString *)name
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:name
                                               object:nil];
}

/**
 移除通知

 @param name 通知名称
 */
- (void)unobserveNotification:(NSString *)name
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:name
                                                  object:nil];
}

/**
 移除所有通知
 */
- (void)unobserveAllNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 发送通知

 @param name 通知名称
 @return 返回值 bool
 */
- (BOOL)postNotification:(NSString *)name
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
    return YES;
}

- (BOOL)postNotification:(NSString *)name withObject:(NSObject *)object
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
    return YES;
}

-(NSString *)className
{
    return NSStringFromClass([self class]);
}

@end
