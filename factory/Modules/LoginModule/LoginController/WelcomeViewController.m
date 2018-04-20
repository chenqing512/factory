//
//  WelcomeViewController.m
//  factory
//
//  Created by Qing Chen on 2018/4/13.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WelcomeViewController.h"
#import "ProtalViewController.h"
@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

- (IBAction)login:(id)sender;
- (IBAction)registerClick:(id)sender;


@end

@implementation WelcomeViewController

#pragma mark 生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backView.layer.cornerRadius=20;
    self.backView.clipsToBounds=YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark 注册 登录按钮点击事件

- (IBAction)registerClick:(id)sender {
    ProtalViewController *vc=[[ProtalViewController alloc]init];
    vc.type=ProtalVCTypeRegister;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)login:(id)sender {
    ProtalViewController *vc=[[ProtalViewController alloc]init];
    vc.type=ProtalVCTypeLogin;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
