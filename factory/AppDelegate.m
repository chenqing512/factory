//
//  AppDelegate.m
//  factory
//
//  Created by chenqing on 2018/2/22.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+RegisterThirdParty.h"
#import <CloudPushSDK/CloudPushSDK.h>
#import "UIImage+Common.h"
#import <Bugly/Bugly.h>
#import <UserNotifications/UserNotifications.h>
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <WeiboSDK/WeiboSDK.h>
#import <UMMobClick/MobClick.h>
#import "WGWeiXinCaller.h"
#import "WGAlipayCaller.h"
#import "WGWeiBoCaller.h"
#import <BaiduMobStat/BaiduMobStat.h>
#import "WelcomeViewController.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self registerThirdParty:application options:launchOptions];
    [self registerMsg];
    [self registerNotification];//注册通知
    [self setupViewControllers];//创建tabbarController
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self configDetail];
   // [self.window setRootViewController:self.tabBarController];
    UITabBar *tabbar=[UITabBar appearance];
    [tabbar setBackgroundImage:[UIImage imageWithColor:[UIColor blackColor]]];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)registerNotification{
    [self observeNotification:ZZ_BIND_ACCOUNT];
    [self observeNotification:ZZ_UNBIND_ACCOUNT];
    [self observeNotification:WG_NOTIFICATION_ACCOUNT_LOGIN_OTHER];
    [self observeNotification:WG_NOTIFICATION_ACCOUNT_NOT_LOGIN];
    [self observeNotification:WG_NOTIFICATION_ACCOUNT_DISABLE];
    [self observeNotification:WG_NOTIFICATION_ACCOUNT_LOGIN_SUCCESS];
}

-(void)configDetail{
    if (SharedData.isLogin) {
        [self.window setRootViewController:self.tabBarController];
    }else{
        [self.window setRootViewController:[WelcomeViewController new]];
    }
}

#pragma mark 第三方统计  微信 微博
-(void)registerThirdParty:(UIApplication *)application options:(NSDictionary *)launchOptions{
    // 点击通知将App从关闭状态启动时，将通知打开回执上报
    [self initCloudPush];
    [CloudPushSDK sendNotificationAck:launchOptions];
    [CloudPushSDK turnOnDebug];
    [self registerAPNS:application];
    
    //微信SDK注册
    [WXApi registerApp:WEIXIN_LOGIN_APP_ID];
    
    //微博SDK注册
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:WEIBO_APPKEY];
    
    //Baidu统计注册
    BaiduMobStat *statTracker = [BaiduMobStat defaultStat];
    statTracker.shortAppVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [statTracker startWithAppId:BAIDU_APPID];
   
    
#ifdef DEBUG
    [MobClick setLogEnabled:YES];
#endif
    UMConfigInstance.appKey = @"59a8bc3bf29d98412d002b19";
    UMConfigInstance.channelId = @"App Store";
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick startWithConfigure:UMConfigInstance];
    // 处理远程通知启动APP
    [self receiveNotificationByLaunchingOptions:launchOptions];
    
    //腾讯bugly
    [Bugly startWithAppId:Bugly_APPID];
}

-(void)initCloudPush{
    [CloudPushSDK asyncInit:PUSH_APP_KEY appSecret:PUSH_APP_SECRET callback:^(CloudPushCallbackResult *res) {
        if (res.success) {
            NSLog(@"Push SDK init success, deviceId: %@.", [CloudPushSDK getDeviceId]);
        } else {
            NSLog(@"Push SDK init failed, error: %@", res.error);
        }
    }];
}

- (void)registerAPNS:(UIApplication *)application {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
}

/** 自定义：APP被“推送”启动时处理推送消息处理（APP 未启动--》启动）*/
- (void)receiveNotificationByLaunchingOptions:(NSDictionary *)launchOptions
{
    if (!launchOptions) return;
    
    /*
     通过“远程推送”启动APP
     UIApplicationLaunchOptionsRemoteNotificationKey 远程推送Key
     */
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"\n>>>[Launching RemoteNotification]:%@",userInfo);
    }
}

#pragma mark -- notification
-(void)handleNotification:(NSNotification *)notification{
    [super handleNotification:notification];
    if ([notification.name isEqualToString:WG_NOTIFICATION_ACCOUNT_LOGOUT]) {//退出登录
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self logout];
        });
        
    }else if ([notification.name isEqualToString:WG_NOTIFICATION_ACCOUNT_LOGIN_OTHER]){
        [[[TAlertView alloc] initWithErrorMsg:@"您的账号在其它地方登录，您被挤下线"] showStatusWithDuration:1.5];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self logout];
        });
    }else if ([notification.name isEqualToString:WG_NOTIFICATION_ACCOUNT_NOT_LOGIN]){
        [[[TAlertView alloc] initWithErrorMsg:@"您的账号在其它地方登录，您被挤下线"] showStatusWithDuration:1.5];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self logout];
        });
    }else if ([notification.name isEqualToString:WG_NOTIFICATION_ACCOUNT_DISABLE]){
        [[[TAlertView alloc] initWithErrorMsg:@"您的账号已经被系统禁止使用"] showStatusWithDuration:1.5];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self logout];
        });
    }else if([notification.name isEqualToString:WG_NOTIFICATION_ACCOUNT_LOGIN_SUCCESS]){
        [CloudPushSDK bindAccount:[NSString stringWithFormat:@"%@_%ld",kPUSH_ACCOUNT,(long)SharedData.user.userId] withCallback:^(CloudPushCallbackResult *res) {
            DLog(@"res:%@",res);
            [self registerMessageReceive];
        }];
#pragma mark -- bugly添加用户ID
        NSString *userPhoneName = [[UIDevice currentDevice] name];
        NSString *userIdentifier = [NSString stringWithFormat:@"%@:%ld",userPhoneName,SharedData.user.userId];
        [Bugly setUserIdentifier:userIdentifier];
        self.window.rootViewController = self.tabBarController;
        [self.window makeKeyAndVisible];
    }
}

-(void)logout{
    SharedData.user = nil;
    [CloudPushSDK unbindAccount:^(CloudPushCallbackResult *res) {
        DLog(@"%@",res);
    }];
    /*  未登录主页面
    XMWelcomeVC *vc = [XMWelcomeVC new];
    KLNavigationController *nc =[[KLNavigationController alloc] initWithRootViewController:vc];
    [KLUtil setWindowRootVC:nc animated:YES];
     */
}

- (void)registerMessageReceive {
    [self observeNotification:@"CCPDidReceiveMessageNotification"];
}

//消息推送方法
- (void)onMessageReceived:(NSNotification *)notification {
    CCPSysMessage *message = [notification object];
    NSString *title = [[NSString alloc] initWithData:message.title encoding:NSUTF8StringEncoding];
    NSString *body = [[NSString alloc] initWithData:message.body encoding:NSUTF8StringEncoding];
   // [SharedMessage getChatMessageJsonString:body];  收到消息处理
    NSLog(@"Receive message title: %@, content: %@.", title, body);
}

#pragma mark 生命周期函数
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if([url.absoluteString hasPrefix:@"wb"]){
        return [WeiboSDK handleOpenURL:url delegate:[WGWeiBoCaller sharedInstance]];
    }else if([url.absoluteString hasPrefix:@"tencent"]){
        return [TencentOAuth HandleOpenURL:url];
    }else if([url.absoluteString hasPrefix:@"wx"]){
        return [WXApi handleOpenURL:url delegate:[WGWeiXinCaller sharedInstance]];
    }else if ([url.absoluteString hasPrefix:@"xmay"]){
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);//返回的支付结果
            if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 9000) {
                [[WGAlipayCaller sharedInstance].delegate alipayFinishPay];
            }else if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 6001){
                [[WGAlipayCaller sharedInstance].delegate alipayCancelPay];
                DLog(@"memo = %@",[resultDic objectForKey:@"memo"]);//返回的支付结果
            }
        }];
    }
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if([url.absoluteString hasPrefix:@"wb"]){
        return [WeiboSDK handleOpenURL:url delegate:[WGWeiBoCaller sharedInstance]];
    }else if([url.absoluteString hasPrefix:@"tencent"]){
        return [TencentOAuth HandleOpenURL:url];
    }else if([url.absoluteString hasPrefix:@"wx"]){
        return [WXApi handleOpenURL:url delegate:[WGWeiXinCaller sharedInstance]];
    }else if ([url.absoluteString hasPrefix:@"xmay"]){
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);//返回的支付结果
            if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 9000) {
                [[WGAlipayCaller sharedInstance].delegate alipayFinishPay];
            }else if ([[resultDic objectForKey:@"resultStatus"] integerValue] == 6001){
                [[WGAlipayCaller sharedInstance].delegate alipayCancelPay];
                DLog(@"memo = %@",[resultDic objectForKey:@"memo"]);//返回的支付结果
            }
        }];
    }
    return YES;
}


@end
