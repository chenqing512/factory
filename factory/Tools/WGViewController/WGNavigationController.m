//
//  WGNavigationController.m
//  factory
//
//  Created by chenqing on 2018/3/8.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGNavigationController.h"

@interface WGNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation WGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate=self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (self.viewControllers.count > 1) {
        return YES;
    }else
        return NO;
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
