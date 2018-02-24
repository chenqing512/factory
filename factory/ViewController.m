//
//  ViewController.m
//  factory
//
//  Created by chenqing on 2018/2/22.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    NSDictionary *dict=@{@"userId":@"565178",
                         @"userKey":
                             @"9b1ff27436026555ad1bb7307fbf9243",
                         @"loading":@"1"
                         };
    [[HTTPClient defaultManager] postHttp:@"/v33/rank-list" parameters:dict completion:^(NSDictionary *response) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
