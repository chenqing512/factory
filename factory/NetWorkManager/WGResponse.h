//
//  WGResponse.h
//  factory
//
//  Created by Qing Chen on 2018/4/8.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGResponse : NSObject

@property (nonatomic, assign) long long         uid;    //uid
@property (nonatomic, assign) NSInteger         result; // 返回状态
@property (nonatomic, assign) NSInteger         sn; //sn
@property (nonatomic, assign) NSInteger         errorCode;  //错误code
@property (nonatomic, assign)   BOOL            isEnd;  //isEnd
@property (nonatomic, assign) long long         maxID;  //maxID
@property (nonatomic, copy)   NSString          *errorMsg;  //错误msg

-(instancetype)initWithResponseData:(id)aData;
-(id)data;
-(BOOL)success;


@end
