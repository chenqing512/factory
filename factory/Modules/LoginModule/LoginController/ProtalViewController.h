//
//  ProtalViewController.h
//  factory
//
//  Created by Qing Chen on 2018/4/19.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGViewController.h"

typedef NS_ENUM(NSInteger,ProtalVCType){
    ProtalVCTypeLogin,
    ProtalVCTypeRegister
};

@interface ProtalViewController : WGViewController

@property (nonatomic,assign) ProtalVCType type;

@end
