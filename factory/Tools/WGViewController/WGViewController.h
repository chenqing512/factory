//
//  WGViewController.h
//  factory
//
//  Created by chenqing on 2018/2/26.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGScrollView.h"

@interface WGViewController : UIViewController

@property (strong, nonatomic) UILabel *labelTitle;//标题
@property (strong, nonatomic) UIButton *leftButton;//左按钮
@property (strong, nonatomic) UIButton *rightButton;//右按钮

/**
 返回按钮点击事件

 @param btn btn
 */
- (void)backButtonClick:(UIButton *)btn;

/**
 右导航按钮点击事件

 @param btn btn
 */
- (void)otherButtonClick:(UIButton *)btn;


/**
 tabbar height

 @return 高度
 */
-(CGFloat)tabBarHeight;

@end
