//
//  Variable.m
//  factory
//
//  Created by chenqing on 2018/2/22.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "Variable.h"

#ifdef DEBUG
NSString *kHttpHost = @"http://testapp.vliao2.com";//测试环境
#else
NSString *kHttpHost = @"http://testapp.vliao2.com";//正式环境
#endif

@implementation Variable

+(CGFloat)screenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}
+(CGFloat)screenWidth{
    return [UIScreen mainScreen].bounds.size.width;
}

@end
