//
//  RegisterViewController.m
//  factory
//
//  Created by Qing Chen on 2018/4/19.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterPresenter.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;//手机号
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;//密码
@property (weak, nonatomic) IBOutlet UITextField *vcodeTF;//验证码
@property (weak, nonatomic) IBOutlet UIButton *vcodeBtn;//获取验证码
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;//注册
@property (nonatomic,strong) RegisterPresenter *registerPresenter;//presenter
@property (weak, nonatomic) IBOutlet UIView *vcodeBackView;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftButton.hidden=NO;
    self.labelTitle.text=@"手机号注册";
    
    _phoneTF.layer.cornerRadius=5;
    _phoneTF.layer.masksToBounds=YES;
    _phoneTF.keyboardType=UIKeyboardTypeNumberPad;
    _phoneTF.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    _phoneTF.leftViewMode = UITextFieldViewModeAlways;
    
    _pwdTF.layer.cornerRadius=5;
    _pwdTF.layer.masksToBounds=YES;
    _pwdTF.keyboardType=UIKeyboardTypeASCIICapable;
    _pwdTF.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    _pwdTF.leftViewMode = UITextFieldViewModeAlways;
    
    _vcodeBackView.layer.cornerRadius=5;
    _vcodeBackView.layer.masksToBounds=YES;
    _vcodeTF.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 40)];
    _vcodeTF.leftViewMode = UITextFieldViewModeAlways;
    _vcodeTF.keyboardType=UIKeyboardTypeNumberPad;
    
    _registerBtn.layer.cornerRadius=5;
    _registerBtn.layer.masksToBounds=YES;
    
    _registerPresenter=[RegisterPresenter new];
    _registerPresenter.phoneTF=self.phoneTF;
    _registerPresenter.pwdTF=self.pwdTF;
    _registerPresenter.vcodeTF=self.vcodeTF;
    _registerPresenter.vcodeBtn=self.vcodeBtn;
    _registerPresenter.registerBtn=self.registerBtn;
    [_registerPresenter updateRegisterBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
