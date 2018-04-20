//
//  LoginViewController.m
//  factory
//
//  Created by Qing Chen on 2018/4/19.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;//手机输入框
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;//忘记密码输入框
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;//错误提示框
@property (weak, nonatomic) IBOutlet UIButton *forgetPWDBtn;//忘记密码
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;//登录
- (IBAction)forgetPWDClick:(id)sender;
- (IBAction)login:(id)sender;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelTitle.text=@"手机号登录";
    self.leftButton.hidden=NO;
    UIView *phoneView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    phoneView.backgroundColor=LoadColor(@"f2f2f2");
    UIImageView *phoneLeftImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    phoneLeftImg.backgroundColor=LoadColor(@"e6e6e6");
    phoneLeftImg.image=LoadImage(@"up_country_code_icon");
    phoneLeftImg.contentMode=UIViewContentModeScaleAspectFit;
    [phoneView addSubview:phoneLeftImg];
    self.phoneTF.layer.cornerRadius=5;
    self.phoneTF.layer.masksToBounds=YES;
    self.phoneTF.leftView=phoneView;
    self.phoneTF.leftViewMode=UITextFieldViewModeAlways;
    self.phoneTF.placeholder=@"请输入手机号";
    self.phoneTF.keyboardType=UIKeyboardTypeNumberPad;
    
    UIView *pwdView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    pwdView.backgroundColor=LoadColor(@"f2f2f2");
    UIImageView *pwdLeftImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    pwdLeftImg.backgroundColor=LoadColor(@"e6e6e6");
    pwdLeftImg.image=LoadImage(@"up_password_icon");
    pwdLeftImg.contentMode=UIViewContentModeScaleAspectFit;
    [pwdView addSubview:pwdLeftImg];
    self.passwordTF.layer.cornerRadius=5;
    self.passwordTF.layer.masksToBounds=YES;
    self.passwordTF.leftView=pwdView;
    self.passwordTF.leftViewMode=UITextFieldViewModeAlways;
    self.passwordTF.placeholder=@"请输入密码";
    self.passwordTF.secureTextEntry=YES;
    
    self.loginBtn.layer.cornerRadius=20;
    self.loginBtn.layer.masksToBounds=YES;
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    RegisterViewController *vc=[RegisterViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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

- (IBAction)forgetPWDClick:(id)sender {
}

- (IBAction)login:(id)sender {
}
@end
