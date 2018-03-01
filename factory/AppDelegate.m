//
//  AppDelegate.m
//  factory
//
//  Created by chenqing on 2018/2/22.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+RegisterThirdParty.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self registerThirdParty];
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self setupViewControllers];
    [self.window setRootViewController:self.tabBarController];
    self.window.backgroundColor=[UIColor whiteColor];
    UITabBar *tabbar=[UITabBar appearance];
//    tabbar.backgroundColor=[UIColor redColor];
    [tabbar setBackgroundImage:[UIImage imageNamed:@"me_manage_account_bg"]];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setupViewControllers {
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    ThirdViewController *thirdViewController = [[ThirdViewController alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
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
}

/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
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


@end
