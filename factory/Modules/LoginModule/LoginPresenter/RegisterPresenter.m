//
//  RegisterPresenter.m
//  factory
//
//  Created by Qing Chen on 2018/4/23.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "RegisterPresenter.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation RegisterPresenter

-(void)updateRegisterBtn{
    [_phoneTF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        if (x.length>11) {
            _phoneTF.text=[x substringToIndex:11];
        }
    }];
    [_pwdTF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        if (x.length>18) {
            _pwdTF.text=[x substringToIndex:18];
        }
    }];
    [_vcodeTF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        if (x.length>6) {
            _vcodeTF.text=[x substringToIndex:6];
        }
    }];
    
    
    //监控信号量
    RACSignal *phoneSignal=[_phoneTF.rac_textSignal map:^id(NSString * value) {
        return value.length==11?@(1):@(0);
    }];
    RACSignal *pwdSignal=[_pwdTF.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return (value.length>=6&&value.length<=18)?@(1):@(0);
    }];
    RACSignal *vcodeSignal=[_vcodeTF.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return value.length==6?@(1):@(0);
    }];
    
    RACSignal *commitSignal=[RACSignal combineLatest:@[phoneSignal,pwdSignal,vcodeSignal] reduce:^id (NSNumber *phoneValid,NSNumber *pwdValid,NSNumber *vcodeValid){
        return @([phoneValid boolValue]&&[pwdValid boolValue]&&[vcodeValid boolValue]);
    }];
    
    RACSignal *commitVcode=[RACSignal combineLatest:@[phoneSignal,pwdSignal] reduce:^id (NSNumber *phoneValid,NSNumber *pwdValid){
        return @([phoneValid boolValue]&&[pwdValid boolValue]);
    }];
    
    //注册按钮
    [commitSignal subscribeNext:^(id valid) {
        if ([valid boolValue]) {
            _registerBtn.backgroundColor=[UIColor blackColor];
            [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _registerBtn.enabled=YES;
        }else{
            _registerBtn.backgroundColor=LoadColor(@"f2f2f2");
            [_registerBtn setTitleColor:LoadColor(@"e6e6e6") forState:UIControlStateNormal];
            _registerBtn.enabled=NO;
        }
    }];
    //验证码按钮
    [commitVcode subscribeNext:^(id valid) {
        if ([valid boolValue]) {
            _vcodeBtn.enabled=YES;
            [_vcodeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else{
            _vcodeBtn.enabled=NO;
            [_vcodeBtn setTitleColor:LoadColor(@"e6e6e6") forState:UIControlStateNormal];
        }
    }];
    [_vcodeBtn addTarget:self action:@selector(vcodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)vcodeBtnClick:(id)sender{
    NSDictionary *dict=@{@"phoneNumber":_phoneTF.text,
                         @"checkExists":@0
                         };
    [[HTTPClient defaultManager] postHttp:@"showmay/captcha" parameters:dict completion:^(NSURLSessionDataTask *task, WGResponse *aResponse, NSError *anError) {
        if (aResponse.success) {
            __block NSInteger second = 60;
            //(1)
            dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            //(2)
            dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
            //(3)
            dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
            //(4)
            dispatch_source_set_event_handler(timer, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (second == 0) {
                        _vcodeBtn.userInteractionEnabled = YES;
                        [_vcodeBtn setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
                        second = 60;
                        //(6)
                        dispatch_cancel(timer);
                    } else {
                        _vcodeBtn.userInteractionEnabled = NO;
                        [_vcodeBtn setTitle:[NSString stringWithFormat:@"%lds 后获取",second] forState:UIControlStateNormal];
                        second--;
                    }
                });
            });
            //(5)
            dispatch_resume(timer);
        }
    }];
}
-(void)registerBtnClick:(id)sender{
    /*
    NSDictionary *dict=@{@"phoneNumber":_phoneTF.text,
                         @"captcha":_vcodeTF.text
                         };
    [[HTTPClient defaultManager] postHttp:@"showmay/captcha-checkin" parameters:dict completion:^(NSURLSessionDataTask *task, WGResponse *aResponse, NSError *anError) {
        if (aResponse.success) {
            
        }
    }];
     */
    //直接注册
    NSDictionary *dict=@{@"phoneNumber":_phoneTF.text,
                         @"type":@"phone",
                         @"password":_pwdTF.text,
                         @"sex":@"M",
                         @"nickname":_phoneTF.text,
                         };
    [[HTTPClient defaultManager] postHttp:@"showmay/register" parameters:dict completion:^(NSURLSessionDataTask *task, WGResponse *aResponse, NSError *anError) {
        if (aResponse.success) {
            WGUser *user=[WGUser mj_objectWithKeyValues:aResponse.data[@"user"]];
            SharedData.user=user;
            [self postNotification:WG_NOTIFICATION_ACCOUNT_LOGIN_SUCCESS];
        }
    }];
    
}

@end
