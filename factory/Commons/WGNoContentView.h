//
//  WGNoContentView.h
//  factory
//
//  Created by Qing Chen on 2018/4/16.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,NoContentType){
    NoContentTypeNetWork,  //无网络
    NoContentTypeMsg        //无数据
};

@interface WGNoContentView : UIView

@property (nonatomic,assign) NSInteger type;//占位图类型

@end
