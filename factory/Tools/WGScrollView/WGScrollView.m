//
//  WGScrollView.m
//  factory
//
//  Created by chenqing on 2018/2/26.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGScrollView.h"

@implementation WGScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initSelf];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initSelf];
    }
    return self;
}

- (void)scrollToTopAnimated:(BOOL)animation
{
    [self setContentOffset:CGPointMake(0, 0) animated:animation];
}
- (void)scrollToBottomAnimated:(BOOL)animation
{
    float offsetY = self.contentSize.height - self.frame.size.height - 10;
    offsetY = offsetY > 0 ? offsetY : 0;
    [self setContentOffset:CGPointMake(0, offsetY) animated:animation];
}


- (void)initSelf
{
    @try
    {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [self flashScrollIndicators];
        for (UIImageView *indicator in self.subviews)
        {
            CGSize size = indicator.frame.size;
            if (size.width > size.height)
            {
                _horizontalIndicator = indicator;   //水平
            }
            else
            {
                _verticalIndicator = indicator;     //垂直
            }
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"%s %zi %@",__FUNCTION__,__LINE__,exception);
    }
}


- (void)contentSizeToFit
{
    CGRect contentRect = CGRectZero;
    for (UIView *subview in self.subviews)
    {
        if (![subview isEqual:_verticalIndicator] && !subview.hidden)
        {
            contentRect = CGRectUnion(contentRect, subview.frame);
        }
    }
    float contentHeight = contentRect.size.height;
    if (contentHeight > self.bounds.size.height)
    {
        contentHeight += 10;
    }
    self.contentSize = CGSizeMake(self.frame.size.width, contentHeight);
}

- (NSArray *)contentSubviews
{
    __autoreleasing NSMutableArray *subviews = [NSMutableArray arrayWithArray:[self subviews]];
    [subviews removeObject:_horizontalIndicator];
    [subviews removeObject:_verticalIndicator];
    return subviews;
}


- (void)willRemoveSubview:(UIView *)subview
{
    if (![subview isKindOfClass:NSClassFromString(@"UIAutocorrectInlinePrompt")] &&
        ![subview isKindOfClass:NSClassFromString(@"UISelectionGrabberDot")])
    {
        [self contentSizeToFit];
    }
}

- (void)didAddSubview:(UIView *)subview
{
    if (![subview isKindOfClass:NSClassFromString(@"UIAutocorrectInlinePrompt")] &&
        ![subview isKindOfClass:NSClassFromString(@"UISelectionGrabberDot")])
    {
        [self contentSizeToFit];
    }
}

@end
