//
//  KeyboardViewController.m
//  factory
//
//  Created by chenqing on 2018/3/8.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()

@end

@implementation KeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftButton.hidden=NO;
    self.labelTitle.text=@"键盘";
    // Do any additional setup after loading the view.
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
