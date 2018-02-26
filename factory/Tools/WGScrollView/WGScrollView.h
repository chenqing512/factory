//
//  WGScrollView.h
//  factory
//
//  Created by chenqing on 2018/2/26.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGScrollView : UIScrollView

@property (unsafe_unretained, nonatomic, readonly) UIImageView *verticalIndicator;
@property (unsafe_unretained, nonatomic, readonly) UIImageView *horizontalIndicator;
- (NSArray *)contentSubviews;
- (void)contentSizeToFit;
- (void)scrollToTopAnimated:(BOOL)animation;
- (void)scrollToBottomAnimated:(BOOL)animation;

@end
