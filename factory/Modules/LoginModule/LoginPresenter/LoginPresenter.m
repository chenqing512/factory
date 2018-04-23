//
//  LoginPresenter.m
//  factory
//
//  Created by Qing Chen on 2018/4/19.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "LoginPresenter.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface LoginPresenter()

@property (nonatomic,weak) id view;

@end

@implementation LoginPresenter

-(void)bindView:(id)view{
    if (view) {
        _view=view;
    }
}

-(void)updateLoginBtn{
    @weakify(self);
    [self.phoneTF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.length>11) {
            self.phoneTF.text=[x substringToIndex:11];
        }
    }];
    [self.pwdTF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.length>16) {
            self.pwdTF.text=[x substringToIndex:16];
        }
    }];
    
    RACSignal *phoneSignal=[self.phoneTF.rac_textSignal map:^id (NSString *value) {
        return value.length==11?@(1):@(0);
    }];
    RACSignal *pwdSignal=[self.pwdTF.rac_textSignal map:^id (NSString *value) {
        return (value.length>=6&&value.length<=16)?@(1):@(0);
    }];
    
    RACSignal *commitSignal=[RACSignal combineLatest:@[phoneSignal,pwdSignal] reduce:^id (NSNumber *phoneNum,NSNumber *pwdNum){
        return @([phoneNum boolValue]&&[pwdNum boolValue]);
    }];
    [commitSignal subscribeNext:^(NSNumber *valid) {
        @strongify(self);
        if ([valid boolValue]) {
            self.loginBtn.backgroundColor=LoadColor(@"000000");
            self.loginBtn.enabled=YES;
        }else{
            self.loginBtn.backgroundColor=LoadColor(@"e6e6e6");
            self.loginBtn.enabled=NO;
        }
    }];
}

@end
