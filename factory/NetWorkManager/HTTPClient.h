//
//  HTTPClient.h
//  factory
//
//  Created by chenqing on 2018/2/23.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResponseData)(NSDictionary *response);

@interface HTTPClient : NSObject

+(instancetype)defaultManager;

-(void)postHttp:(NSString *)path parameters:(NSDictionary *)parameters completion:(ResponseData)response;

@end
