//
//  TTabBar.m
//  timingapp
//
//  Created by Kelu iOS on 16/10/27.
//  Copyright © 2016年 huiian. All rights reserved.
//

#import "TTabBar.h"

@interface TTabBar()<TTabBarItemDelegate>{
    CGFloat         _angel;
}

@end

@implementation TTabBar

-(UIView *)createLine{
    UIView  *view = [UIView new];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1f];
    return view;
}

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

-(void)setItemsArray:(NSArray *)itemsArray{
    _itemsArray = itemsArray;
    self.backgroundColor = [UIColor whiteColor];
    CGFloat width = [Variable screenWidth]/([itemsArray count]);
    for (TTabBarItem *item in _itemsArray) {
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
    TTabBarItem *item = [_itemsArray objectAtIndex:selectedIndex];
    [item setStateToSelectedWithAnimation:NO];
    if(self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]){
        [self.delegate tabBar:self didSelectItemAtIndex:selectedIndex];
    }
}

-(void)jumpToIndex:(NSInteger) index{
    _selectedIndex = index;
    
    TTabBarItem    *item = [_itemsArray objectAtIndex:1];
    [item setStateToNormalSettingWithAnimation:YES];
    
    TTabBarItem    *jumpItem = [_itemsArray objectAtIndex:_selectedIndex];
    [jumpItem setStateToSelectedWithAnimation:NO];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]){
        [self.delegate tabBar:self didSelectItemAtIndex:_selectedIndex];
    }
}


#pragma mark -- TTabBarItemDelegate
-(void)tabBarItemPopNavigation:(TTabBarItem *)tabBarItem{
    if ([self.delegate respondsToSelector:@selector(tabBar:popNavigation:)]) {
        [self.delegate tabBar:self popNavigation:tabBarItem.tag];
    }
}

-(TTabBarItem  *)getItemByIndex:(NSInteger)index{
    for(TTabBarItem  *view in self.subviews){
        if([view isKindOfClass:[TTabBarItem class]] && view.tag == index)
            return view;
    }
    
    return nil;
}

- (void)tabBarItemChangeStateToSelected:(TTabBarItem *)tabBarItem {
    
    NSInteger newlySelectedIndex = tabBarItem.tag;
    
    if(_selectedIndex == newlySelectedIndex) {
        return;
    }
    
    _selectedIndex = newlySelectedIndex;
    
    for (TTabBarItem *item in _itemsArray) {
        [item setStateToNormalSettingWithAnimation:YES];
    }
    
    [tabBarItem setStateToSelectedWithAnimation:YES];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]){
        [self.delegate tabBar:self didSelectItemAtIndex:_selectedIndex];
    }
}

@end

#define DOT_RADIUS  (8)

@interface TTabBarItem(){
    MASConstraint       *_masConsDotWidth;
    MASConstraint       *_masConsDotHeight;
}

@end

@implementation TTabBarItem

-(id)initWithNomelImage:(UIImage *)normalImage normalSettingImage:(UIImage *)normalSettingImage hightImage:(UIImage *)hightImage{
    self = [super init];
    if (self) {
        _normalImage = normalImage;
        _normalSettingImage = normalSettingImage;
        _hightImage = hightImage;
        
        _unreadView = [UIView new];
        _unreadView.backgroundColor = [UIColor redColor];
        _unreadView.layer.cornerRadius = 5;
        _unreadView.clipsToBounds = YES;
        
        _numberLabel  = [UILabel new];
//        _numberLabel.backgroundColor = SharedColor.dotRed;
        _numberLabel.textColor = [UIColor clearColor];
        _numberLabel.font = [UIFont systemFontOfSize:17];
        _numberLabel.layer.cornerRadius = DOT_RADIUS;
        _numberLabel.clipsToBounds = YES;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        
        [self setupView];
    }
    return self;
}

-(void)setupView{
   // DLog(@"setupView");
    _iv = [UIImageView new];
    
    _ivBg = [UIImageView new];
    _ivBg.clipsToBounds = YES;
    _ivBg.contentMode = UIViewContentModeScaleAspectFill;
    _ivBg.image = [UIImage imageNamed:@"tabbar_bg"];
    [self addSubview:_ivBg];
    [self addSubview:_iv];
    [self addSubview:_unreadView];
    [self addSubview:_numberLabel];
    [self layoutNormal];
    [self layoutDot];
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (void)layoutNormal{
   // DLog(@"layoutNormal");
    [_ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.leading.equalTo(self.mas_leading);
        make.trailing.equalTo(self.mas_trailing);
    }];
    
//    [_ivBg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.bottom.equalTo(self.mas_bottom);
//        if (isLeft) {
//            make.leading.equalTo(self.mas_leading);
//            make.trailing.equalTo(self.mas_centerX).offset(-radius);
//        }else{
//            make.leading.equalTo(self.mas_centerX).offset(radius);
//            make.trailing.equalTo(self.mas_trailing);
//        }
//    }];
    
    _iv.image = _normalImage;
    _ivBg.image = [UIImage imageNamed:@"tabbar_bg"];
    CGSize size = _normalImage.size;
    [_iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(2);
        make.width.equalTo(@(size.width));
        make.height.equalTo(@(size.height));
    }];
    
}

-(void)tap:(UITapGestureRecognizer *)tap{
   // DLog(@"-(void)tap:(UITapGestureRecognizer *)tap");
    
    if(_isSelected) {
        if ([self.delegate respondsToSelector:@selector(tabBarItemPopNavigation:)]) {
            [self.delegate tabBarItemPopNavigation:self];
        }
        return;
    }
    
    _iv.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:.1 animations:^{
            _iv.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:.6 animations:^{
            _iv.transform = CGAffineTransformMakeScale(.9, .9);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:.3 animations:^{
            _iv.transform = CGAffineTransformIdentity;
        }];
        
    } completion:^(BOOL finished) {
        [self bringSubviewToFront:_unreadView];
        [self bringSubviewToFront:_numberLabel];
    }];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(tabBarItemChangeStateToSelected:)]){
        [self.delegate tabBarItemChangeStateToSelected:self];
    }
}

-(void)layoutDot{
    [_unreadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_iv.mas_trailing).offset(1);
        make.centerY.equalTo(_iv.mas_centerY);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    
    _unreadView.hidden = YES;
    
    [self addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_iv.mas_trailing).offset(1);
        make.centerY.equalTo(_iv.mas_centerY);
        _masConsDotWidth = make.width.equalTo(@(DOT_RADIUS * 2));
        _masConsDotHeight = make.height.equalTo(@(DOT_RADIUS * 2));
    }];
    _numberLabel.hidden = YES;
}

-(void)layoutSelected{
  //  DLog(@"layoutSelected");
    _iv.image = _hightImage;
    _ivBg.image = [UIImage imageNamed:@"tabbar_bg_selected"];
//    [self checkDot];
}

-(void)layoutNormalSetting{
   // DLog(@"layoutNormalSetting");
    _iv.image = _normalSettingImage;
    _ivBg.image = [UIImage imageNamed:@"tabbar_bg"];
//    [self checkDot];
}

-(void)setStateToSelectedWithAnimation:(BOOL)animation{
   // DLog(@"setStateToSelectedWithAnimation");
    if(animation){
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.7 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
            [self layoutSelected];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            _isSelected=YES;
        }];
    }else{
        [self layoutSelected];
        [self layoutIfNeeded];
        _isSelected=YES;
    }
    
}

-(void)setStateToNormalSettingWithAnimation:(BOOL)animation{
   // DLog(@"setStateToNormalSettingWithAnimation");
    if(animation){
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.7 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
            [self layoutNormalSetting];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            _isSelected=NO;
        }];
    }else{
        [self layoutNormalSetting];
        [self layoutIfNeeded];
        _isSelected=NO;
    }
}


-(void)showMsgCount:(NSInteger)count{
   // DLog(@"红点显示:%ld",(long)count);
    _count = count;
    _unreadView.hidden = YES;
    if(_count == 0) {
        [self.numberLabel setHidden:YES];
        self.numberLabel.text = @"0";
    } else {
        [self.numberLabel setHidden:NO];
        if (_count > 9) {
            _masConsDotWidth.offset = DOT_RADIUS * 2.5;
        }else{
            _masConsDotWidth.offset = DOT_RADIUS * 2;
        }
        self.numberLabel.text = _count > 99 ? @"99" : [NSString stringWithFormat:@"%ld", (long)_count];
    }
}
@end
