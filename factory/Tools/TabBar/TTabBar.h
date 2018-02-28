//
//  TTabBar.h
//  timingapp
//
//  Created by Kelu iOS on 16/10/27.
//  Copyright © 2016年 huiian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTabBar;
@class TTabBarItem;
@protocol TTabBarDelegate <NSObject>

-(void)tabBar:(TTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index;
-(void)tabBar:(TTabBar *)tabBar popNavigation:(NSInteger)index;
//-(void)tabBarStartPosting:(TTabBar *)tabBar;
//-(void)tabBarAlertInfo:(TTabBar *)tabBar;
//-(void)tabBarAlertPhone:(TTabBar *)tabBar;
@end

@interface TTabBar : UIView

@property (nonatomic, strong) NSArray* itemsArray;
@property(nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic, weak) id<TTabBarDelegate> delegate;

-(TTabBarItem  *)getItemByIndex:(NSInteger)index;
-(void)jumpToIndex:(NSInteger) index;

@end

@class TTabBarItem;
@protocol TTabBarItemDelegate <NSObject>

-(void)tabBarItemChangeStateToSelected:(TTabBarItem *)tabBarItem;
-(void)tabBarItemPopNavigation:(TTabBarItem *)tabBarItem;
//-(void)tabBarItemStartPosting:(TTabBarItem *)tabBarItem;
//-(void)tabBarItemAlertInfo:(TTabBarItem *)tabBarItem;
//-(void)tabBarItemAlertPhone:(TTabBarItem *)tabBarItem;

@end

@interface TTabBarItem : UIButton

@property (nonatomic, strong) UIImage* normalImage;
@property (nonatomic, strong) UIImage* normalSettingImage;
@property (nonatomic, strong) UIImage* hightImage;
@property (nonatomic, strong) UIView*  unreadView;
@property (nonatomic, strong) UILabel  *numberLabel;
@property (nonatomic, strong) UIImageView* iv;
@property (nonatomic, strong) UIImageView* ivBg;

@property (nonatomic, strong) UIImageView* ivLearning;
@property (nonatomic, strong) UIImageView* ivPlus;
@property(nonatomic,assign) BOOL isSelected;
@property (nonatomic, weak) id<TTabBarItemDelegate> delegate;
@property(nonatomic,assign) NSInteger count;
-(id)initWithNomelImage:(UIImage *)normalImage normalSettingImage:(UIImage *)normalSettingImage hightImage:(UIImage *)hightImage;
//-(void)setStateToNormalWithAnimation:(BOOL)animation;
-(void)setStateToNormalSettingWithAnimation:(BOOL)animation;
-(void)setStateToSelectedWithAnimation:(BOOL)animation;
-(void)showMsgCount:(NSInteger)count;

@end
