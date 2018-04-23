//
//  RegisterPresenter.h
//  factory
//
//  Created by Qing Chen on 2018/4/23.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterPresenter : NSObject
@property (nonatomic,strong) UITextField *phoneTF;
@property (nonatomic,strong) UITextField *pwdTF;
@property (nonatomic,strong) UITextField *vcodeTF;
@property (nonatomic,strong) UIButton *registerBtn;
@property (nonatomic,strong) UIButton *vcodeBtn;


/**
 校验注册按钮
 */
-(void)updateRegisterBtn;

@end
