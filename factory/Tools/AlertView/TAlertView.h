//
//  TAlertView.h
//  factory
//
//  Created by chenqing on 2018/2/26.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^OnClickButton)();

typedef NS_ENUM(NSInteger, TAlertViewShareType) {
    TAlertViewShareWeixin = 1,
    TAlertViewShareQuan = 2,
    TAlertViewShareQQ = 3,
};

@protocol TAlertViewDelegate <NSObject>

-(void)shareWithType:(NSInteger)type;

@end

@interface TAlertView : UIView{
    OnClickButton onClickOKFunc;
    OnClickButton onClickCancelFunc;
}

@property (nonatomic, strong) UIView        *alertView;
@property (nonatomic, strong) UILabel       *lblTitle;
@property (nonatomic, strong) UILabel       *lblContent;
@property (nonatomic, strong) UIView        *viewOK;
@property (nonatomic, strong) UIImageView   *ivOK;
@property (nonatomic, strong) UILabel       *lblOK;
@property (nonatomic, strong) UIView        *viewCancel;
@property (nonatomic, strong) UIImageView   *ivCancel;
@property (nonatomic, strong) UILabel       *lblCancel;

@property (nonatomic, strong) UIButton      *btnContent;

@property (nonatomic, strong) UIImageView   *ivTitle;
@property (nonatomic, strong) NSTimer       *fadeOutTimer;

@property (nonatomic, weak) id<TAlertViewDelegate>      delegate;

-(id)initWithTitle:(NSString *)tipTitle tipContent:(NSString *)tipContent OKTitle:(NSString *)aOKTitle onOK:(OnClickButton)onOKFunc cancelTitle:(NSString *)aCancelTitle onCancel:(OnClickButton)onCancelFunc;//左取消右确定

-(id)initWithSuccessMsg:(NSString *)msg;
-(id)initWithErrorMsg:(NSString *)msg;
-(id)initWithNoticeMsg:(NSString *)okText;
-(id)initWithUploadImage:(NSString *)title num:(NSInteger)num;

-(id)initWithMessage:(NSString *)msg;

-(void)show;

-(void)showStatusWithDuration:(NSTimeInterval)interval;

-(void)dismiss;

@end
