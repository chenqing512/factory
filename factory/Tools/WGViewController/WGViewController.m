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


const int kLeftButtonTag = -1234;
const int kRightButtonTag = -1235;

@interface WGViewController ()<UIGestureRecognizerDelegate> {
    CGRect _rect;
}

@end

@implementation WGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    //添加背景图
    //    self.view.backgroundColor=LOAD_COLOR(kColorBackground);
    _contentView=[[WGScrollView alloc]initWithFrame:CGRectMake(0, 0, [WGUtil screenWidth], [WGUtil screenHeight]-kStatusHeight-kNavigationHeight)];
    _contentView.tag=-1112;
    _contentView.clipsToBounds = YES;
    [self.view addSubview:_contentView];
    [self.view sendSubviewToBack:_contentView];
    _rect = _contentView.frame;
    [self updateLabel];
    [self updateButton];
    [self updateBackgroundView];
    self.leftButton.hidden=YES;
    self.rightButton.hidden=YES;
#pragma mark 后期待改进
//    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [WGUtil screenWidth], 20)];
//    statusBarView.backgroundColor=[UIColor colorWithHexString:@"#f2bf24"];
//    self.navigationController.interactivePopGestureRecognizer.enabled=YES;
    
}

#pragma mark 设置导航栏UIView

/**
 导航栏标题
 */
- (void)updateLabel{
    self.labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 44)];
    self.labelTitle.text=@"";
    //    self.labelTitle.font=[UIFont systemFontOfSize:20];
    self.labelTitle.font=[UIFont systemFontOfSize:18];
    //    self.labelTitle.font=LOAD_FONT_LantingZhonghei(20);
    self.labelTitle.textAlignment=NSTextAlignmentCenter;
    self.labelTitle.backgroundColor=[UIColor clearColor];
    //    self.labelTitle.textColor=[UIColor whiteColor];
    self.labelTitle.textColor=[UIColor colorWithHexString:@"48c8c2"];
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
     [navBar setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
}
#pragma mark 左右按钮点击事件
- (void)backButtonClick:(UIButton *)btn{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)otherButtonClick:(UIButton *)btn{
    
}


#pragma mark 视图生命周期方法
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHiden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}
- (void)viewDidLayoutSubviews{
    //    [super viewDidLayoutSubviews];
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            scrollView.scrollsToTop = NO;
        }
        if ([view isKindOfClass:[UITableView class]]){
            UITableView *tableView = (UITableView *)view;
            tableView.scrollsToTop = YES;
            
        }
    }
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
#pragma mark 键盘监听方法
- (void)keyBoardWillShow:(NSNotification *)noti{
    CGSize size = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat time=[[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIView *responder=[self.view findFirstResponder];
    
    CGRect rect = [responder.superview convertRect:responder.frame toView:self.contentView];
    
    CGFloat _y=self.view.frame.size.height-size.height-responder.frame.size.height;
    if ([responder isKindOfClass:[UITextField class]]||[responder isKindOfClass:[UITextView class]]) {
        if (_y<rect.origin.y) {
            [UIView animateWithDuration:time animations:^{
                
                self.contentView.frame=CGRectMake(0, _y-rect.origin.y-10, self.contentView.frame.size.width, self.contentView.frame.size.height);
            }];
        }
        
    }
    
}
- (void)keyBoardWillHiden:(NSNotification *)noti{
    CGFloat time=[[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:time animations:^{
        _contentView.frame=_rect;
        
    }];
}

#pragma mark  other method

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
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

@end





