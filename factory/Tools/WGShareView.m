//
//  WGShareView.m
//  factory
//
//  Created by Qing Chen on 2018/4/16.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGShareView.h"
#import "WGSharePublishCollectionCell.h"
#define SHARE_TYPE_NUM  (5)

@interface WGShareView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UICollectionView        *_shareCollectionView;
    UIView                  *_line;
    UICollectionView        *_copyCollectionView;
    UIImageView             *_ivCancel;
    UIView                  *_viewBlank;
}

@end

@implementation WGShareView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    UICollectionViewFlowLayout * fLayout = [[UICollectionViewFlowLayout alloc] init];
    fLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _copyCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:fLayout];
    _copyCollectionView.clipsToBounds = YES;
    _copyCollectionView.scrollEnabled = NO;
    [self addSubview:_copyCollectionView];
    _copyCollectionView.showsHorizontalScrollIndicator = NO;
    _copyCollectionView.showsVerticalScrollIndicator = NO;
    _copyCollectionView.backgroundColor = [UIColor blackColor];
    [_copyCollectionView registerClass:[WGSharePublishCollectionCell class] forCellWithReuseIdentifier:WG_SHARE_PUBLISH_COLLECTION_CELL];
    _copyCollectionView.delegate = self;
    _copyCollectionView.dataSource = self;
    [_copyCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.leading.equalTo(self.mas_leading).offset(0);
        make.trailing.equalTo(self.mas_trailing).offset(0);
        make.height.equalTo(@([WGSharePublishCollectionCell defaultSize].height));
    }];
    
    _line = [WGUtil createLine];
    _line.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    [self addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_copyCollectionView.mas_top);
        make.leading.equalTo(self.mas_leading).offset(10);
        make.trailing.equalTo(self.mas_trailing).offset(-10);
        make.height.equalTo(@0.5);
    }];
    
    UICollectionViewFlowLayout * fLayoutTwo = [[UICollectionViewFlowLayout alloc] init];
    fLayoutTwo.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _shareCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:fLayoutTwo];
    _shareCollectionView.clipsToBounds = YES;
    _shareCollectionView.scrollEnabled = NO;
    [self addSubview:_shareCollectionView];
    _shareCollectionView.showsHorizontalScrollIndicator = NO;
    _shareCollectionView.showsVerticalScrollIndicator = NO;
    _shareCollectionView.backgroundColor = _copyCollectionView.backgroundColor;
    [_shareCollectionView registerClass:[WGSharePublishCollectionCell class] forCellWithReuseIdentifier:WG_SHARE_PUBLISH_COLLECTION_CELL];
    _shareCollectionView.delegate = self;
    _shareCollectionView.dataSource = self;
    [_shareCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_copyCollectionView.mas_top);
        make.leading.equalTo(self.mas_leading).offset(0);
        make.trailing.equalTo(self.mas_trailing).offset(0);
        make.height.equalTo(@([WGSharePublishCollectionCell defaultSize].height));
    }];
    
    _viewBlank = [UIView new];
    _viewBlank.userInteractionEnabled = YES;
    [_viewBlank addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelView)]];
    [self addSubview:_viewBlank];
    [_viewBlank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading);
        make.trailing.equalTo(self.mas_trailing);
        make.bottom.equalTo(_shareCollectionView.mas_top);
        make.top.equalTo(self.mas_top);
    }];
}

-(void)show
{
    UIWindow * keyWindow =[UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    __block MASConstraint * botomConstraint;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(keyWindow.mas_top);
        make.leading.equalTo(keyWindow.mas_leading);
        make.trailing.equalTo(keyWindow.mas_trailing);
        botomConstraint = make.bottom.equalTo(keyWindow.mas_bottom).with.offset([WGSharePublishCollectionCell defaultSize].height * 2);
    }];
    [self layoutIfNeeded];
    
    botomConstraint.offset = 0;
    self.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.9];
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
    _bottomConstraint=botomConstraint;
}

-(void)cancelView{
    [self disMiss];
}

-(void)disMiss
{
    _bottomConstraint.offset = [WGSharePublishCollectionCell defaultSize].height * 2;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark --UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _copyCollectionView) {
        if (SHARE_TYPE_NUM > 4) {
            return SHARE_TYPE_NUM - 4 + 1;
        }
        return 1;
    }else if (collectionView == _shareCollectionView) {
        if (SHARE_TYPE_NUM > 4) {
            return 4;
        }
        return SHARE_TYPE_NUM;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WGSharePublishCollectionCell * aCell =[collectionView dequeueReusableCellWithReuseIdentifier:WG_SHARE_PUBLISH_COLLECTION_CELL forIndexPath:indexPath];
    NSInteger num = SHARE_TYPE_NUM;
    if (SHARE_TYPE_NUM > 4) {
        num = 4;
    }
    if (collectionView == _copyCollectionView) {
        aCell.index = indexPath.item + num;
    }else if (collectionView == _shareCollectionView) {
        aCell.index = indexPath.item;
    }
    return aCell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger num = SHARE_TYPE_NUM;
    if (SHARE_TYPE_NUM > 4) {
        num = 4;
    }
    if (collectionView == _copyCollectionView) {
        [_delegate shareViewWithType:indexPath.item + num withPublish:0];
    }else if (collectionView == _shareCollectionView) {
        [_delegate shareViewWithType:indexPath.item withPublish:0];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [WGSharePublishCollectionCell defaultSize];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, -1, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}



@end
