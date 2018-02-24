//
//  WGTabBar.h
//  factory
//
//  Created by chenqing on 2018/2/24.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WGTabBar;
@class WGTabBarItem;

@protocol WGTabBarDelegate <NSObject>

-(void)tabBar:(WGTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index;
-(void)tabBar:(WGTabBar *)tabBar popNavigation:(NSInteger)index;

@end

@interface WGTabBar : UIView

@property (nonatomic, strong) NSArray* itemsArray;
@property(nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic, weak) id<WGTabBarDelegate> delegate;

-(WGTabBarItem  *)getItemByIndex:(NSInteger)index;
-(void)jumpToIndex:(NSInteger) index;

@end
