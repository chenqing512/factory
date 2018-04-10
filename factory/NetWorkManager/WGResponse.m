//
//  WGResponse.m
//  factory
//
//  Created by Qing Chen on 2018/4/8.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGResponse.h"

@interface WGResponse(){
    id _responseData;
}

@end

@implementation WGResponse

-(id)data {
    return _responseData;
}

-(instancetype)initWithResponseData:(id)aData
{
    if (aData == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _responseData = aData;
        _uid = [[aData objectForKey:@"uid"] longLongValue];
        _result = [[aData objectForKey:@"result"] integerValue];
        _sn = [[aData objectForKey:@"sn"] integerValue];
        _errorCode = [[aData objectForKey:@"errorCode"] integerValue];
        _errorMsg = [aData objectForKey:@"errorMsg"];
        _isEnd = [[aData objectForKey:@"isEnd"] boolValue];
        _maxID = [[aData objectForKey:@"maxID"] longLongValue];
    }
    return self;
}

-(BOOL)success {
    return _result == 1;
}


@end
