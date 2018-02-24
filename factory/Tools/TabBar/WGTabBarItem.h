//
//  WGTabBarItem.h
//  factory
//
//  Created by chenqing on 2018/2/24.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WGTabBarItem;

@protocol WGTabBarItemDelegate <NSObject>

-(void)tabBarItemChangeStateToSelected:(WGTabBarItem *)tabBarItem;
-(void)tabBarItemPopNavigation:(WGTabBarItem *)tabBarItem;

@end

@interface WGTabBarItem : UIButton

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
@property (nonatomic, weak) id<WGTabBarItemDelegate> delegate;
@property(nonatomic,assign) NSInteger count;
-(id)initWithNomelImage:(UIImage *)normalImage normalSettingImage:(UIImage *)normalSettingImage hightImage:(UIImage *)hightImage;
-(void)setStateToNormalSettingWithAnimation:(BOOL)animation;
-(void)setStateToSelectedWithAnimation:(BOOL)animation;
-(void)showMsgCount:(NSInteger)count;

@end
