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

@property (nonatomic,retain) WGScrollView *contentView;



- (void)backButtonClick:(UIButton *)btn;
- (void)otherButtonClick:(UIButton *)btn;
- (void)keyBoardWillShow:(NSNotification *)noti;
- (void)keyBoardWillHiden:(NSNotification *)noti;


/**
 tabbar height

 @return 高度
 */
-(CGFloat)tabBarHeight;

@end
