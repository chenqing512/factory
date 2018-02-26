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
#import "UIView+Common.h"

const int kLeftButtonTag = -1234;
const int kRightButtonTag = -1235;

@interface WGViewController ()<UIGestureRecognizerDelegate> {
    CGRect _rect;
}

@end

@implementation WGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加背景图
    //    self.view.backgroundColor=LOAD_COLOR(kColorBackground);
    _contentView=[[WGScrollView alloc]initWithFrame:CGRectMake(0, 0, [Variable screenWidth], [Variable screenHeight]-20-44)];
    _contentView.tag=-1112;
    _contentView.clipsToBounds = YES;
    [self.view addSubview:_contentView];
    [self.view sendSubviewToBack:_contentView];
    
    _tapImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _tapImageView.image = [UIImage imageNamed:@"jzsb"];
    _tapImageView.tag = -1111;
    _tapImageView.userInteractionEnabled = YES;
    _tapImageView.hidden = YES;
    [_contentView addSubview:_tapImageView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textResignFirstResponder:)];
    [_tapImageView addGestureRecognizer:tapGestureRecognizer];
    
    _rect = _contentView.frame;
    
    [self updateLabel];
    [self updateButton_];
    [self updateBackgroundView];
    self.leftButton.hidden=YES;
    self.rightButton.hidden=YES;
#pragma mark 后期待改进
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [Variable screenWidth], 20)];
    statusBarView.backgroundColor=[UIColor colorWithHexString:@"#f2bf24"];
    
}

- (void)hideTabBar
{
    self.tabBarController.tabBar.hidden = YES;
}


#pragma mark 设置导航栏标题框
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
    self.navigationItem.titleView.frame=CGRectMake(0, 0, [Variable screenWidth], 44);
    self.navigationItem.titleView=self.labelTitle;
    
}
#pragma mark 添加左右按钮
- (void)updateButton_{
    self.leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton setFrame:CGRectMake(0, 0, 45, 19)];
    [self.leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.leftButton setImage:[UIImage imageNamed:@"backSelect"] forState:UIControlStateSelected];
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
- (void)backButtonClick:(UIButton *)btn{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)otherButtonClick:(UIButton *)btn{
    
}
#pragma mark 设置导航栏背景图片
- (void)updateBackgroundView{
    UINavigationBar *navBar=self.navigationController.navigationBar;
    navBar.backgroundColor = [UIColor clearColor];
    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        // ios5 and later
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
#pragma mark ios 7需要 640*128的导航栏背景图  ios7以下的需要 640*88的背景图
            [navBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
        } else {
            [navBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
        }
        
    } else {
        UIImageView *imageView=(UIImageView *)[navBar viewWithTag:10];
        if (imageView==nil) {
            //            imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navBar"]];
            imageView.frame=CGRectMake(0, 0, [Variable screenWidth], 44);
            imageView.backgroundColor = [UIColor whiteColor];
            imageView.tag=10;
            [navBar insertSubview:imageView atIndex:0];
            
        }
    }
}

#pragma mark 视图即将出现
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self hideTabBar];  // 暂时不用
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHiden:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark 视图将要消失
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
- (void)textResignFirstResponder:(UITapGestureRecognizer *)tap {
    UIView *tapView=tap.view;
    UIView *responder=[self.view findFirstResponder];
    if (![tapView isKindOfClass:[UITextField class]]) {
        if ([responder isKindOfClass:[UITextField class]]||[responder isKindOfClass:[UITextView class]]) {
            [responder resignFirstResponder];
        }
    }
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    UIView *responder=[self.view findFirstResponder];
    if ([responder isKindOfClass:[UITextField class]]||[responder isKindOfClass:[UITextView class]]||[responder isKindOfClass:[UISearchBar class]]) {
        [responder resignFirstResponder];
    }
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end





