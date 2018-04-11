//
//  TAlertView.h
//  factory
//
//  Created by chenqing on 2018/2/26.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "TAlertView.h"

@implementation TAlertView

-(id)initWithToast{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _alertView = [UIView new];
        _alertView.clipsToBounds = YES;
        _alertView.layer.cornerRadius = 5.f;
        _alertView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        [self addSubview:_alertView];
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(-20);
            make.width.equalTo(@270);
            make.height.equalTo(@100);
        }];
        
        _btnContent = [UIButton new];
        _btnContent.titleLabel.font = [UIFont systemFontOfSize:15];
        _btnContent.titleLabel.numberOfLines = 0;
        [_btnContent setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnContent.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_alertView addSubview:_btnContent];
        [_btnContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_alertView.mas_centerY);
            make.leading.equalTo(_alertView.mas_leading).offset(15);
            make.trailing.equalTo(_alertView.mas_trailing).offset(-15);
            make.height.equalTo(@36);
        }];
        
        //        _ivTitle = [UIImageView new];
        //        [_alertView addSubview:_ivTitle];
        //        [_ivTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.centerY.equalTo(_alertView.mas_centerY);
        //            make.leading.equalTo(_alertView.mas_leading).offset(36);
        //            make.width.equalTo(@36);
        //            make.height.equalTo(@36);
        //        }];
        //
        //
        //        _lblTitle = [UILabel new];
        //        _lblTitle.textAlignment = NSTextAlignmentCenter;
        //        _lblTitle.numberOfLines = 0;
        //        _lblTitle.textColor = [UIColor blackColor];
        //        _lblTitle.font = [UIFont systemFontOfSize:15];
        //        [_alertView addSubview:_lblTitle];
        //        [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.center.equalTo(_alertView);
        //            make.leading.equalTo(_alertView.mas_leading).offset(80);
        //            make.trailing.equalTo(_alertView.mas_trailing).offset(-36);
        //        }];
        
    }
    
    return self;
}

-(id)initWithSuccessMsg:(NSString *)msg{
    self = [self initWithToast];
    //    [_btnContent setImage:[UIImage imageNamed:@"alertview_success_tip"] forState:UIControlStateNormal];
    [_btnContent setTitle:msg forState:UIControlStateNormal];
    [self addrightIconWithImageName:@"alertview_success_tip"];
    //    _lblTitle.text = msg;
    return self;
}

-(id)initWithErrorMsg:(NSString *)msg{
    self = [self initWithToast];
    //    [_btnContent setImage:[UIImage imageNamed:@"alertview_error_tip"] forState:UIControlStateNormal];
    [self addrightIconWithImageName:@"alertview_error_tip"];
    [_btnContent setTitle:msg forState:UIControlStateNormal];
    //    _lblTitle.text = msg;
    return self;
}

-(id)initWithMessage:(NSString *)msg{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _alertView = [UIView new];
        _alertView.clipsToBounds = YES;
        _alertView.layer.cornerRadius = 5.f;
        _alertView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_alertView];
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(-20);
            make.width.equalTo(@270);
            make.height.equalTo(@100);
        }];
        
        _btnContent = [UIButton new];
        _btnContent.titleLabel.font = [UIFont systemFontOfSize:17];
        _btnContent.titleLabel.numberOfLines = 0;
        _btnContent.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btnContent setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnContent.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_alertView addSubview:_btnContent];
        [_btnContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_alertView.mas_centerY);
            make.leading.equalTo(_alertView.mas_leading).offset(15);
            make.trailing.equalTo(_alertView.mas_trailing).offset(-15);
            make.height.equalTo(@36);
        }];
        
    }
    
    [_btnContent setTitle:msg forState:UIControlStateNormal];
    return self;
}

- (void)addrightIconWithImageName:(NSString *)imageName{
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:imageName];
    [_alertView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo(imageView.mas_height).multipliedBy(1.2);
    }];
}

-(id)initWithNoticeMsg:(NSString *)okText{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _alertView = [UIView new];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.clipsToBounds = YES;
        _alertView.layer.cornerRadius = 4.f;
        [self addSubview:_alertView];
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(@270);
            make.height.equalTo(@140);
        }];
        
        _lblContent = [UILabel new];
        _lblContent.textColor = [UIColor blackColor];
        _lblContent.font = [UIFont systemFontOfSize:14.f];
        _lblContent.numberOfLines = 0;
        _lblContent.textAlignment = NSTextAlignmentCenter;
        [_alertView addSubview:_lblContent];
        [_lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_alertView.mas_centerX);
            make.centerY.equalTo(_alertView.mas_centerY).offset(-25);
            make.leading.equalTo(_alertView.mas_leading).offset(30);
            make.trailing.equalTo(_alertView.mas_trailing).offset(-30);
        }];
        
        //确定
        _viewOK = [UIView new];
        _viewOK.clipsToBounds = YES;
        [_alertView addSubview:_viewOK];
        [_viewOK mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_alertView.mas_leading);
            make.trailing.equalTo(_alertView.mas_trailing);
            make.height.equalTo(@50);
            make.bottom.equalTo(_alertView.mas_bottom);
        }];
        _viewOK.userInteractionEnabled = YES;
        [_viewOK addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickCancel)]];
        
        UIView *line = [WGUtil createLine];
        [_viewOK addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_viewOK.mas_leading);
            make.trailing.equalTo(_viewOK.mas_trailing);
            make.top.equalTo(_viewOK.mas_top);
            make.height.equalTo(@0.5);
        }];
        
        _lblOK = [UILabel new];
        _lblOK.text = okText;
        _lblOK.textColor = [UIColor redColor];
        _lblOK.font = [UIFont boldSystemFontOfSize:16.f];
        _lblOK.numberOfLines = 1;
        _lblOK.textAlignment = NSTextAlignmentCenter;
        [_viewOK addSubview:_lblOK];
        [_lblOK mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_viewOK.mas_centerY);
            make.centerX.equalTo(_viewOK.mas_centerX);
        }];
    }
    
    return self;
}

-(id)initWithUploadImage:(NSString *)title num:(NSInteger)num{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _alertView = [UIView new];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.clipsToBounds = YES;
        _alertView.layer.cornerRadius = 4.f;
        [self addSubview:_alertView];
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(@145);
            make.height.equalTo(@170);
        }];
        
        _ivTitle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"album_upload_circle"]];
        [_alertView addSubview:_ivTitle];
        [_ivTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_alertView.mas_top).offset(20);
            make.centerX.equalTo(_alertView.mas_centerX);
            make.width.equalTo(@60);
            make.height.equalTo(@60);
        }];
        
        _lblTitle = [UILabel new];
        _lblTitle.textColor = [UIColor blackColor];
        _lblTitle.font = [UIFont systemFontOfSize:14.f];
        _lblTitle.numberOfLines = 1;
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.text = title;
        [_alertView addSubview:_lblTitle];
        [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_alertView.mas_centerX);
            make.top.equalTo(_ivTitle.mas_bottom).offset(20);
            make.leading.equalTo(_alertView.mas_leading).offset(10);
            make.trailing.equalTo(_alertView.mas_trailing).offset(-10);
        }];
        
        
        _lblContent = [UILabel new];
        _lblContent.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        _lblContent.font = [UIFont systemFontOfSize:14.f];
        _lblContent.numberOfLines = 1;
        _lblContent.textAlignment = NSTextAlignmentCenter;
        _lblContent.text = [NSString stringWithFormat:@"(0/%ld)",(long)num];
        [_alertView addSubview:_lblContent];
        [_lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lblTitle.mas_bottom).offset(10);
            make.centerX.equalTo(_alertView.mas_centerX);
            make.leading.equalTo(_alertView.mas_leading).offset(10);
            make.trailing.equalTo(_alertView.mas_trailing).offset(-10);
        }];
        
    }
    
    return self;
}

-(id)initWithTitle:(NSString *)tipTitle tipContent:(NSString *)tipContent OKTitle:(NSString *)aOKTitle onOK:(OnClickButton)onOKFunc cancelTitle:(NSString *)aCancelTitle onCancel:(OnClickButton)onCancelFunc{
    
    onClickOKFunc = onOKFunc;
    onClickCancelFunc = onCancelFunc;
    
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _alertView = [UIView new];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.clipsToBounds = YES;
        _alertView.layer.cornerRadius = 4.f;
        [self addSubview:_alertView];
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(@270);
        }];
        
        _lblContent = [UILabel new];
        _lblContent.text = tipContent;
        _lblContent.textColor = [UIColor blackColor];
        _lblContent.font = [UIFont systemFontOfSize:14];
        _lblContent.numberOfLines = 0;
        _lblContent.textAlignment = NSTextAlignmentCenter;
        [_alertView addSubview:_lblContent];
        [_lblContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_alertView.mas_centerX);
            make.top.equalTo(_alertView.mas_top).offset(20);
            make.leading.equalTo(_alertView.mas_leading).offset(30);
            make.trailing.equalTo(_alertView.mas_trailing).offset(-30);
        }];
        
        _lblTitle = [UILabel new];
        _lblTitle.text = tipTitle;
        _lblTitle.textColor = [UIColor blackColor];
        _lblTitle.font = [UIFont boldSystemFontOfSize:14];
        _lblTitle.numberOfLines = 0;
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        [_alertView addSubview:_lblTitle];
        [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_alertView.mas_centerX);
            make.top.equalTo(_lblContent.mas_bottom).offset(10);
            make.leading.equalTo(_alertView.mas_leading).offset(30);
            make.trailing.equalTo(_alertView.mas_trailing).offset(-30);
        }];
        
        UIView *lineHorizon = [WGUtil createLine];
        [_alertView addSubview:lineHorizon];
        [lineHorizon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_alertView.mas_leading);
            make.trailing.equalTo(_alertView.mas_trailing);
            make.top.equalTo(_lblTitle.mas_bottom).offset(tipContent.length > 0 ? 10 : 25);
            make.height.equalTo(@0.5);
        }];
        
        UIView *lineVertical = [WGUtil createLine];
        [_alertView addSubview:lineVertical];
        [lineVertical mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineHorizon.mas_bottom);
            make.centerX.equalTo(_alertView.mas_centerX);
            make.bottom.equalTo(_alertView.mas_bottom);
            make.height.equalTo(@50);
            make.width.equalTo(@0.5);
        }];
        //取消
        _viewCancel = [UIView new];
        _viewCancel.clipsToBounds = YES;
        [_alertView addSubview:_viewCancel];
        [_viewCancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_alertView.mas_leading);
            make.trailing.equalTo(lineVertical.mas_leading);
            make.top.equalTo(lineHorizon.mas_bottom);
            make.bottom.equalTo(_alertView.mas_bottom);
        }];
        _viewCancel.userInteractionEnabled = YES;
        [_viewCancel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickCancel)]];
        
        _lblCancel = [UILabel new];
        _lblCancel.text = aCancelTitle;
        _lblCancel.textColor = [UIColor blackColor];
        _lblCancel.font = [UIFont boldSystemFontOfSize:16.f];
        _lblCancel.numberOfLines = 1;
        _lblCancel.textAlignment = NSTextAlignmentLeft;
        [_alertView addSubview:_lblCancel];
        [_lblCancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_viewCancel.mas_centerY);
            make.centerX.equalTo(_viewCancel.mas_centerX).offset(13.5);
        }];
        
        _ivCancel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alertview_no_icon"]];
        [_viewCancel addSubview:_ivCancel];
        [_ivCancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_viewCancel.mas_centerY);
            make.trailing.equalTo(_lblCancel.mas_leading).offset(-5);
            make.width.equalTo(@17);
            make.height.equalTo(@17);
        }];
        //确定
        _viewOK = [UIView new];
        _viewOK.clipsToBounds = YES;
        [_alertView addSubview:_viewOK];
        [_viewOK mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(lineVertical.mas_trailing);
            make.trailing.equalTo(_alertView.mas_trailing);
            make.top.equalTo(lineHorizon.mas_bottom);
            make.bottom.equalTo(_alertView.mas_bottom);
        }];
        _viewOK.userInteractionEnabled = YES;
        [_viewOK addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickOK)]];
        
        _lblOK = [UILabel new];
        _lblOK.text = aOKTitle;
        _lblOK.textColor = [UIColor blackColor];
        _lblOK.font = [UIFont boldSystemFontOfSize:16.f];
        _lblOK.numberOfLines = 1;
        _lblOK.textAlignment = NSTextAlignmentLeft;
        [_alertView addSubview:_lblOK];
        [_lblOK mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_viewOK.mas_centerY);
            make.centerX.equalTo(_viewOK.mas_centerX).offset(13.5);
        }];
        
        _ivOK = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alertview_yes_icon"]];
        [_viewOK addSubview:_ivOK];
        [_ivOK mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_viewOK.mas_centerY);
            make.trailing.equalTo(_lblOK.mas_leading).offset(-5);
            make.width.equalTo(@17);
            make.height.equalTo(@17);
        }];
        
    }
    
    return self;
}

-(void)onClickJustOK{
    if (onClickOKFunc)
    {
        onClickOKFunc();
    }
}

-(void)onClickOK{
    _alertView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _alertView.alpha=0.0;
        _alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
    } completion:nil];
    
    [UIView animateWithDuration:.3 animations:^{
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        if (onClickOKFunc)
        {
            onClickOKFunc();
        }
        [self removeFromSuperview];
        
    }];
}


-(void)onClickCancel{
    _alertView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _alertView.alpha=0.0;
        _alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
    } completion:nil];
    
    [UIView animateWithDuration:.3 animations:^{
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        if (onClickCancelFunc)
        {
            onClickCancelFunc();
        }
        [self removeFromSuperview];
        
    }];
}

-(void)show{
    UIWindow * window =[UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(window.mas_top);
        make.leading.equalTo(window.mas_leading);
        make.trailing.equalTo(window.mas_trailing);
        make.bottom.equalTo(window.mas_bottom);
    }];
    [self layoutIfNeeded];
    
    
    self.alpha = 0;
    [UIView animateWithDuration:.2 animations:^{
        self.alpha = 1;
    }];
    
    _alertView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _alertView.alpha=1.0;
        _alertView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)showStatusWithDuration:(NSTimeInterval)interval{
    [self show];
    _fadeOutTimer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_fadeOutTimer forMode:NSRunLoopCommonModes];
}

-(void)dismiss{
    [self onClickCancel];
}

-(void)tapShare:(UIButton *)button{
    [_delegate shareWithType:button.tag];
}


@end
