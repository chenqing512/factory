//
//  WGSharePublishCollectionCell.m
//  factory
//
//  Created by Qing Chen on 2018/4/16.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGSharePublishCollectionCell.h"

@interface WGSharePublishCollectionCell(){
    UIImageView         *_ivAvatar;
    UILabel             *_lblTitle;
}

@end

@implementation WGSharePublishCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupView];
    }
    return self;
}

-(void)setupView{
    _ivAvatar = [UIImageView new];
    _ivAvatar.clipsToBounds = YES;
    _ivAvatar.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_ivAvatar];
    [_ivAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.width.equalTo(@36);
        make.height.equalTo(@36);
    }];
    
    _lblTitle = [UILabel new];
    _lblTitle.numberOfLines = 1;
    _lblTitle.font = LoadFont(14);
    _lblTitle.textColor = [UIColor whiteColor];
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_lblTitle];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading).offset(2);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-2);
        make.top.equalTo(_ivAvatar.mas_bottom).offset(10);
    }];
}

-(void)setIndex:(NSInteger)index{
    _index = index;
    switch (index) {
        case ZZShareWeixin:{
            _ivAvatar.image = [UIImage imageNamed:@"share_weixin_icon"];
            _lblTitle.text = @"微信好友";
        }
            break;
        case ZZShareWeixinQuest:{
            _ivAvatar.image = [UIImage imageNamed:@"share_weixinquest_icon"];
            _lblTitle.text = @"微信朋友圈";
        }
            break;
        case ZZShareWeibo:{
            _ivAvatar.image = [UIImage imageNamed:@"share_weibo_icon"];
            _lblTitle.text = @"微博";
        }
            break;
        case ZZShareQQ:{
            _ivAvatar.image = [UIImage imageNamed:@"share_qq_icon"];
            _lblTitle.text = @"QQ";
        }
            break;
        case ZZShareQQZone:{
            _ivAvatar.image = [UIImage imageNamed:@"share_qqzone_icon"];
            _lblTitle.text = @"QQ空间";
        }
            break;
        case ZZShareLink:{
            _ivAvatar.image = [UIImage imageNamed:@"share_link_icon"];
            _lblTitle.text = @"复制链接";
        }
            break;
        default:
            break;
    }
}


+(CGSize)defaultSize{
    return CGSizeMake([WGUtil screenWidth]/4, 100);
}

@end
