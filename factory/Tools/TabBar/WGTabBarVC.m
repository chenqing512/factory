//
//  WGTabBarVC.m
//  factory
//
//  Created by chenqing on 2018/2/24.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGTabBarVC.h"
#import "TTabBar.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface WGTabBarVC ()<TTabBarDelegate>{
    NSMutableArray      *_vcList;
    NSMutableArray      *_itemsArray;
    
    TTabBarItem         *_homepageItem;
    TTabBarItem         *_discoveryItem;
    TTabBarItem         *_meItem;
    
    TTabBar             *_tabbar;
    BOOL                _shouldPresentPostMenu;
}

@end

@implementation WGTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _vcList = [NSMutableArray new];
//    [self observeNotification:XM_JUMP_TO_TAB];
    
    UIViewController *vc = [FirstViewController new];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [_vcList addObject:nc];
    
    vc = [SecondViewController new];
    nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [_vcList addObject:nc];
    
    vc = [ThirdViewController new];
    nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [_vcList addObject:nc];
    
    self.viewControllers = _vcList;
    
    _itemsArray = [NSMutableArray new];
    
    _discoveryItem = [[TTabBarItem alloc] initWithNomelImage:[UIImage imageNamed:@"tabbar_discovery_icon"] normalSettingImage:[UIImage imageNamed:@"tabbar_discovery_icon"] hightImage:[UIImage imageNamed:@"tabbar_discovery_icon_selected"]];
    _discoveryItem.tag = 0;
    [_itemsArray addObject:_discoveryItem];
    
    _homepageItem = [[TTabBarItem alloc] initWithNomelImage:[UIImage imageNamed:@"tabbar_homepage_icon"] normalSettingImage:[UIImage imageNamed:@"tabbar_homepage_icon"] hightImage:[UIImage imageNamed:@"tabbar_homepage_icon_selected"]];
    _homepageItem.tag = 1;
    [_itemsArray addObject:_homepageItem];
    
    _meItem = [[TTabBarItem alloc] initWithNomelImage:[UIImage imageNamed:@"tabbar_me_icon"] normalSettingImage:[UIImage imageNamed:@"tabbar_me_icon"] hightImage:[UIImage imageNamed:@"tabbar_me_icon_selected"]];
    _meItem.tag = 2;
    [_itemsArray addObject:_meItem];
    
    _tabbar = [[TTabBar alloc] init];
    _tabbar.delegate = self;
    _tabbar.itemsArray = _itemsArray;
    _tabbar.selectedIndex = 0;
    _tabbar.backgroundColor = [UIColor blackColor];
    
    self.selectedIndex = 0;
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
    [self removeTabBarButton];
    self.tabBar.shadowImage = [UIImage new];
    self.tabBar.backgroundImage = [UIImage new];
    _tabbar.frame = self.tabBar.bounds;
    [self.tabBar insertSubview:_tabbar atIndex:0];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)removeTabBarButton{
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

-(void)tapLearning{
    
}

#pragma mark -- TTabBarDelegate
-(void)tabBar:(TTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index{
    self.selectedIndex = index;
}

-(void)tabBar:(TTabBar *)tabBar popNavigation:(NSInteger)index{
    UIViewController *vc = self.viewControllers[index];
    if ([vc isKindOfClass:[UINavigationController class]]) {
        [((UINavigationController *)vc) popViewControllerAnimated:YES];
    }
}


//#pragma mark -- notification
//-(void)handleNotification:(NSNotification *)notification{
//    [super handleNotification:notification];
//    if ([notification.name isEqualToString:XM_JUMP_TO_TAB]) {
//        NSInteger index = [notification.object integerValue];
//        if (index == 0) {
//            [_tabbar jumpToIndex:0];
//        }else if (index == 1){
//            [_tabbar jumpToIndex:2];
//        }
//    }
//}

@end
