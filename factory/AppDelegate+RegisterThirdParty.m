//
//  AppDelegate+RegisterThirdParty.m
//  factory
//
//  Created by chenqing on 2018/2/26.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "AppDelegate+RegisterThirdParty.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "WelcomeViewController.h"
@implementation AppDelegate (RegisterThirdParty)

-(void)registerMsg{
    [self setKeyboardProperty];//设置键盘属性
    //设置UITextField和UITextView的默认颜色(光标颜色)
    [[UITextField appearance] setTintColor:[UIColor blackColor]];
    [[UITextView appearance] setTintColor:[UIColor blackColor]];
}

#pragma mark 键盘控制
-(void)setKeyboardProperty{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    keyboardManager.toolbarDoneBarButtonItemText = @"完成";
}

#pragma mark 创建视图
- (void)setupViewControllers {
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    UIViewController *firstNavigationController = [[WGNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    UIViewController *secondNavigationController = [[WGNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    ThirdViewController *thirdViewController = [[ThirdViewController alloc] init];
    UIViewController *thirdNavigationController = [[WGNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:tabBarController];
    
    [tabBarController setViewControllers:@[
                                           firstNavigationController,
                                           secondNavigationController,
                                           thirdNavigationController
                                           ]];
    
    tabBarController.tabBar.backgroundColor=[UIColor blackColor];
    self.tabBarController = tabBarController;
    
    WelcomeViewController *welcomeVC=[WelcomeViewController new];
    self.welcomeNav=[[WGNavigationController alloc]initWithRootViewController:welcomeVC];    
}


/**
 创建tabbar

 @param tabBarController tabbar
 */
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemImage : @"tabbar_discovery_icon",
                            CYLTabBarItemSelectedImage : @"tabbar_discovery_icon_selected",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemImage : @"tabbar_homepage_icon",
                            CYLTabBarItemSelectedImage : @"tabbar_homepage_icon_selected",
                            };
    
    NSDictionary *dict3 = @{
                            CYLTabBarItemImage : @"tabbar_me_icon",
                            CYLTabBarItemSelectedImage : @"tabbar_me_icon_selected",
                            };
    
    NSArray *tabBarItemsAttributes = @[ dict1, dict2,dict3];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}




@end
