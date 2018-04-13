//
//  SocketRocketUtility.h
//  factory
//
//  Created by Qing Chen on 2018/4/13.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket.h>

extern NSString * const kNeedPayOrderNote;
extern NSString * const kWebSocketDidOpenNote;//连接成功
extern NSString * const kWebSocketDidCloseNote;//关闭长连
extern NSString * const kWebSocketdidReceiveMessageNote;//收到消息

@interface SocketRocketUtility : NSObject

// 获取连接状态
@property (nonatomic,assign,readonly) SRReadyState socketReadyState;

+ (SocketRocketUtility *)instance;
-(void)SRWebSocketOpenWithURLString:(NSString *)urlString;//开启连接
-(void)SRWebSocketClose;//关闭连接
- (void)sendData:(id)data;//发送数据

@end
