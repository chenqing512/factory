//
//  UIView+Common.m
//  factory
//
//  Created by chenqing on 2018/2/26.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "UIView+Common.h"

@implementation UIView (Common)

- (id)findFirstResponder{
    if ([self isFirstResponder]) {
        return self;
    }
    for(UIView *subView in self.subviews){
        id responder=[subView findFirstResponder];
        if (responder) {
            return responder;
        }
    }
    return nil;
}

@end
