//
//  FirstViewController.m
//  factory
//
//  Created by chenqing on 2018/2/28.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "FirstViewController.h"
#import "NextViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"first";
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
        make.top.mas_equalTo(50+64);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
}

-(void)buttonClick:(UIButton *)btn{
//    [[HTTPClient defaultManager] postHttp:@"showmay/discover" parameters:@{@"count":@10,
//                                                                           @"isIOS":@0,
//                                                                           @"tailID":@0,
//                                                                           @"userID":@516458,
//                                                                           @"userKey":@"UQrnFOlgd3mhzoPZhz2f2mPTWbzVx8hZ"
//                                                                           } completion:^(NSURLSessionDataTask *task, WGResponse *aResponse, NSError *anError) {
//
//                                                                           }];
    
    NextViewController *vc=[[NextViewController alloc]init];
    vc.hidesBottomBarWhenPushed=YES;
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

@end
