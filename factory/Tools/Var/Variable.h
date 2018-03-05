//
//  Variable.h
//  factory
//
//  Created by chenqing on 2018/2/22.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kNavigationHeight self.navigationController.navigationBar.frame.size.height
#define kStatusHeight [[UIApplication sharedApplication] statusBarFrame].size.height;
#define ktabBarHeight [UITabBar appearance].frame.size.height

extern NSString *kHttpHost;

@interface Variable : NSObject

#pragma mark 预计算
+(CGFloat)screenHeight;
+(CGFloat)screenWidth;


@end
