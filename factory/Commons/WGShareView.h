//
//  WGShareView.h
//  factory
//
//  Created by Qing Chen on 2018/4/16.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WGShareViewDelegate <NSObject>

-(void)shareViewWithType:(NSInteger)type withPublish:(NSInteger )publish;

@end

@interface WGShareView : UIView

@property (nonatomic, weak) id<WGShareViewDelegate>   delegate;
@property (nonatomic, strong) MASConstraint* bottomConstraint;

-(void)show;
-(void)disMiss;

@end
