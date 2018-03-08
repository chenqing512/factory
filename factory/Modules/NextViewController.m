//
//  NextViewController.m
//  factory
//
//  Created by chenqing on 2018/3/8.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.leftButton.hidden=NO;
    self.labelTitle.text=@"next";
    [self layoutView];
    // Do any additional setup after loading the view.
}

-(void)layoutView{
    UIButton *button=[UIButton new];
    button.backgroundColor=[UIColor redColor];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-40);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
}

-(void)buttonClick:(UIButton *)btn{
    NSLog(@"123");
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
