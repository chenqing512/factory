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
#import "WGShareView.h"
@interface WelcomeViewController ()<WGWeixinCallerDelegate,WGShareViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
- (IBAction)login:(id)sender;
- (IBAction)register:(id)sender;
- (IBAction)loginWechat:(id)sender;
- (IBAction)loginQQ:(id)sender;
- (IBAction)shareViewClick:(id)sender;

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
    [WGWeiXinCaller sharedInstance].delegate = self;
    if(![WXApi isWXAppInstalled]){
        [[[TAlertView alloc] initWithErrorMsg:@"你未安装微信"] showStatusWithDuration:1];
        return;
    }
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo,snsapi_base";
    req.state = @"0744" ;
    [WXApi sendReq:req];
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
                //调用QQ登录
            }];
        }
    }];
}

- (IBAction)shareViewClick:(id)sender {
    WGShareView * shareView = [[WGShareView alloc] init];
  //  shareView.publish = nil;
    shareView.delegate = self;
    [shareView show];
}
#pragma mark -- ZZShareV2ViewDelegate
-(void)shareViewWithType:(NSInteger)type withPublish:(NSInteger )publish{
    DLog(@"share:%ld",(long)type);
    /*
    [SVProgressHUD showWithStatus:@"获取分享信息"];
    [SharedApiClient albumShare:publish.ID completion:^(NSURLSessionDataTask *task, KLApiResponse *aResponse, NSError *anError) {
        DLog(@"albumShare:%@",aResponse.data);
        [SVProgressHUD dismiss];
        if (aResponse.success) {
            ZZShare *share = [[ZZShare alloc] initWithDictionary:aResponse.data error:nil];
            share.type = type;
            share.albumID = publish.ID;
            [WGUtil shareWithShare:share];
        }else{
            [[[TAlertView alloc] initWithErrorMsg:aResponse.errorMsg.length > 0 ? aResponse.errorMsg : @"分享失败"] showStatusWithDuration:1.5];
        }
    }];
     */
}
#pragma mark -- 第三方登录代理方法
-(void)finishAuth:(WGWeiXiner *)weixiner{
    DLog(@"weixiner:%@",weixiner);
    //调用微信登录
    [SVProgressHUD dismiss];
    
}

@end
