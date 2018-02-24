//
//  WGTabBar.m
//  factory
//
//  Created by chenqing on 2018/2/24.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGTabBar.h"
#import "WGTabBarItem.h"
@interface WGTabBar()<WGTabBarItemDelegate>{
    CGFloat         _angel;
}

@end

@implementation WGTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _angel = 0;
        UIView *line = [self createLine];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.mas_leading);
            make.trailing.equalTo(self.mas_trailing);
            make.top.equalTo(self.mas_top);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}

-(UIView *)createLine{
    UIView  *view = [UIView new];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1f];
    return view;
}

-(void)setItemsArray:(NSArray *)itemsArray{
    _itemsArray = itemsArray;
    self.backgroundColor = [UIColor whiteColor];
    CGFloat width = [Variable screenWidth]/([itemsArray count]);
    for (WGTabBarItem *item in _itemsArray) {
        NSInteger index = item.tag;
        item.delegate = self;
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.leading.equalTo(self.mas_leading).offset(index * width);
            make.bottom.equalTo(self.mas_bottom);
            make.width.equalTo(@(width));
        }];
        [self sendSubviewToBack:item];
    }
}

-(void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    WGTabBarItem *item = [_itemsArray objectAtIndex:selectedIndex];
    [item setStateToSelectedWithAnimation:NO];
    if(self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]){
        [self.delegate tabBar:self didSelectItemAtIndex:selectedIndex];
    }
}

-(void)jumpToIndex:(NSInteger) index{
    _selectedIndex = index;
    
    WGTabBarItem    *item = [_itemsArray objectAtIndex:1];
    [item setStateToNormalSettingWithAnimation:YES];
    
    WGTabBarItem    *jumpItem = [_itemsArray objectAtIndex:_selectedIndex];
    [jumpItem setStateToSelectedWithAnimation:NO];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]){
        [self.delegate tabBar:self didSelectItemAtIndex:_selectedIndex];
    }
}


#pragma mark -- WGTabBarItemDelegate
-(void)tabBarItemPopNavigation:(WGTabBarItem *)tabBarItem{
    if ([self.delegate respondsToSelector:@selector(tabBar:popNavigation:)]) {
        [self.delegate tabBar:self popNavigation:tabBarItem.tag];
    }
}

-(WGTabBarItem  *)getItemByIndex:(NSInteger)index{
    for(WGTabBarItem  *view in self.subviews){
        if([view isKindOfClass:[WGTabBarItem class]] && view.tag == index)
            return view;
    }
    
    return nil;
}

- (void)tabBarItemChangeStateToSelected:(WGTabBarItem *)tabBarItem {
    
    NSInteger newlySelectedIndex = tabBarItem.tag;
    
    if(_selectedIndex == newlySelectedIndex) {
        return;
    }
    
    _selectedIndex = newlySelectedIndex;
    
    for (WGTabBarItem *item in _itemsArray) {
        [item setStateToNormalSettingWithAnimation:YES];
    }
    
    [tabBarItem setStateToSelectedWithAnimation:YES];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]){
        [self.delegate tabBar:self didSelectItemAtIndex:_selectedIndex];
    }
}

@end
