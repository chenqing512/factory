//
//  NSObject+Manager.h
//  factory
//
//  Created by Qing Chen on 2018/4/13.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Manager)

/**
 存储数据
 */
-(void)saveMe;

/**
 从缓存中取数据

 @return 取出的值
 */
+(id)loadSavedData;

@end
