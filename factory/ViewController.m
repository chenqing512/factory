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
    NSDictionary *dict=@{@"userId":@"565178",@"userKey":@"9b1ff27436026555ad1bb7307fbf9243"};
    [[HTTPClient defaultManager] postHttp:@"/v33/rank-list" parameters:dict completion:^(NSDictionary *response) {
        
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
