//
//  WGWeiXiner.h
//  factory
//
//  Created by Qing Chen on 2018/4/12.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGWeiXiner : NSObject

@property(nonatomic,copy) NSString* city;
@property(nonatomic,copy) NSString* country;
@property(nonatomic,copy) NSString* headimgurl;
@property(nonatomic,copy) NSString* language;
@property(nonatomic,copy) NSString* nickname;
@property(nonatomic,copy) NSString* openid;
@property(nonatomic,copy) NSString* province;
@property(nonatomic,assign) NSInteger sex;
@property(nonatomic,copy) NSString* unionid;
@property(nonatomic,copy) NSString* access_token;
@property(nonatomic,assign) long long expires_in;

@end
