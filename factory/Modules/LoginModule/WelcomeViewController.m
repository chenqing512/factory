//
//  WelcomeViewController.m
//  factory
//
//  Created by Qing Chen on 2018/4/13.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WelcomeViewController.h"
#import "WGQQCaller.h"
#import "WGWeiXinCaller.h"
@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
- (IBAction)login:(id)sender;
- (IBAction)register:(id)sender;
- (IBAction)loginWechat:(id)sender;
- (IBAction)loginQQ:(id)sender;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)login:(id)sender {
    [self postNotification:WG_NOTIFICATION_ACCOUNT_LOGIN_SUCCESS];
}

- (IBAction)register:(id)sender {
}
- (IBAction)loginWechat:(id)sender {
}

- (IBAction)loginQQ:(id)sender {
    [[WGQQCaller sharedInstance] authorize:^(BOOL success, TencentOAuth *oauth) {
        [SVProgressHUD dismiss];
        if (success) {
            [[WGQQCaller sharedInstance] getUserInfo:^(APIResponse *response) {
                DLog(@"%@", response.message);
                id jsonResponse = response.jsonResponse;
                NSString *nickName = [jsonResponse objectForKey:@"nickname"];
                NSString *gender = [[jsonResponse objectForKey:@"gender"] isEqualToString:@"男"] ? @"M" : @"F"; // 男, 女
                NSString *avartarURL = [jsonResponse objectForKey:@"figureurl_qq_2"]; // 100x100 image
                
            }];
        }
    }];
}
@end
