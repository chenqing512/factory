//
//  LoginPresenter.h
//  factory
//
//  Created by Qing Chen on 2018/4/19.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginPresenter : NSObject

@property (nonatomic,strong) UITextField *phoneTF;//手机号
@property (nonatomic,strong) UITextField *pwdTF;//密码
@property (nonatomic,strong) UIButton *loginBtn;//确定按钮

/**
 绑定view

 @param view 传入参数
 */
-(void)bindView:(id)view;

-(void)updateLoginBtn;

@end
