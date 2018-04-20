//
//  ProtalViewController.m
//  factory
//
//  Created by Qing Chen on 2018/4/19.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "ProtalViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface ProtalViewController ()
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
- (IBAction)phoneBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtnClick:(id)sender;

@end

@implementation ProtalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneBtn.layer.cornerRadius=20;
    self.phoneBtn.clipsToBounds=YES;
    [self.backBtn setImage:LoadImage(@"banner_back_btn") forState:UIControlStateNormal];
    NSString *btnText=self.type==ProtalVCTypeLogin?@"手机号登录":@"手机号注册";
    [self.phoneBtn setTitle:btnText forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)phoneBtnClick:(id)sender {
    if (self.type==ProtalVCTypeLogin) {
        LoginViewController *loginVC=[LoginViewController new];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else{
        RegisterViewController *registerVC=[RegisterViewController new];
        [self.navigationController pushViewController:registerVC animated:YES];
    }
}
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
