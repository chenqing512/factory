//
//  WGViewController.m
//  factory
//
//  Created by chenqing on 2018/2/26.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGViewController.h"
#import "UIColor+WGColor.h"
#import "UIImage+Common.h"
#import <UMMobClick/MobClick.h>
#import <BaiduMobStat/BaiduMobStat.h>

const int kLeftButtonTag = -1234;
const int kRightButtonTag = -1235;

@interface WGViewController ()<UIGestureRecognizerDelegate>

@end

@implementation WGViewController
#pragma mark 视图生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setNeedsStatusBarAppearanceUpdate];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self updateLabel];//添加titleview
    [self updateButton];//添加导航栏按钮
    [self updateBackgroundView];//更新navigation背景颜色
    self.leftButton.hidden=YES;
    self.rightButton.hidden=YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  //  [[BaiduMobStat defaultStat] pageviewStartWithName:_pageTitle.length > 0 ? _pageTitle : @"未知页面"];
    [MobClick beginLogPageView:_labelTitle.text.length > 0 ? _labelTitle.text : @"未知页面"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
  //  [[BaiduMobStat defaultStat] pageviewEndWithName:_labelTitle.text.length > 0 ? _labelTitle.text : @"未知页面"];
    [MobClick endLogPageView:_labelTitle.text.length > 0 ? _labelTitle.text : @"未知页面"];
}

#pragma mark 设置导航栏UIView

/**
 导航栏标题
 */
- (void)updateLabel{
    self.labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 44)];
    self.labelTitle.text=@"";
    self.labelTitle.font=[UIFont systemFontOfSize:18];
    self.labelTitle.textAlignment=NSTextAlignmentCenter;
    self.labelTitle.backgroundColor=[UIColor clearColor];
   // self.labelTitle.textColor=[UIColor colorWithHexString:@"48c8c2"];
    self.labelTitle.textColor=[UIColor colorWithHexString:@"ffffff"];
    self.navigationItem.titleView.frame=CGRectMake(0, 0, [WGUtil screenWidth], 44);
    self.navigationItem.titleView=self.labelTitle;
    
}

/**
 添加导航栏左右按钮
 */
- (void)updateButton{
    self.leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton setFrame:CGRectMake(0, 0, 45, 19)];
    [self.leftButton setImage:[UIImage imageNamed:@"nav_back_btn"] forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:@"nav_back_btn"] forState:UIControlStateSelected];
    self.leftButton.imageView.contentMode = UIViewContentModeLeft;
    self.leftButton.tag=kLeftButtonTag;
    self.leftButton.titleLabel.textColor=[UIColor colorWithHexString:@"2b364e"];
    [self.leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.leftButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    
    self.rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightButton addTarget:self action:@selector(otherButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.rightButton setFrame:CGRectMake(0, 2, 45, 25)];
    [self.rightButton setTitle:@"" forState:UIControlStateNormal];
    self.rightButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [self.rightButton setTitleColor:[UIColor colorWithHexString:@"2b364e"] forState:UIControlStateNormal];
    self.rightButton.tag=kRightButtonTag;
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem=rightItem;
    
}

/**
 导航栏背景
 */
- (void)updateBackgroundView{
    UINavigationBar *navBar=self.navigationController.navigationBar;
    navBar.backgroundColor = [UIColor clearColor];
    [navBar setBackgroundImage:[UIImage imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
}
#pragma mark 左右按钮点击事件
- (void)backButtonClick:(UIButton *)btn{
    [SVProgressHUD dismiss];// 影藏loading
    //退出输入框
    UIView *responder=[self.view findFirstResponder];
    if ([responder isKindOfClass:[UITextField class]]||[responder isKindOfClass:[UITextView class]]||[responder isKindOfClass:[UISearchBar class]]) {
        [responder resignFirstResponder];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)otherButtonClick:(UIButton *)btn{
    
}
#pragma mark  other method

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    //退出输入框
    UIView *responder=[self.view findFirstResponder];
    if ([responder isKindOfClass:[UITextField class]]||[responder isKindOfClass:[UITextView class]]||[responder isKindOfClass:[UISearchBar class]]) {
        [responder resignFirstResponder];
    }
    
}



/**
 tabbar 高度

 @return 高度
 */
-(CGFloat)tabBarHeight{
    return self.tabBarController.tabBar.frame.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

@end





