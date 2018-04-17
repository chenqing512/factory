//
//  WGBaseTableView.m
//  factory
//
//  Created by Qing Chen on 2018/4/16.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "WGBaseTableView.h"
#import "WGNoContentView.h"

@interface WGBaseTableView(){
    WGNoContentView *_noContentView;
}
@end

@implementation WGBaseTableView


/**
 展示无数据占位图
 
 @param emptyViewType 无数据占位图的类型
 */
- (void)showEmptyViewWithType:(NSInteger)emptyViewType{
    
    // 如果已经展示无数据占位图，先移除
    if (_noContentView) {
        [_noContentView removeFromSuperview];
        _noContentView = nil;
    }
    
    //------- 再创建 -------//
    _noContentView = [[WGNoContentView alloc]initWithFrame:self.bounds];
    [self addSubview:_noContentView];
    _noContentView.type = emptyViewType;
    
    //------- 添加单击手势 -------//
    [_noContentView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(noContentViewDidTaped:)]];
}

/**
 移除无数据占位图
 */
- (void)removeEmptyView{
    [_noContentView removeFromSuperview];
    _noContentView = nil;
}



/**
 无数据占位图点击

 @param noContentView view
 */
- (void)noContentViewDidTaped:(WGNoContentView *)noContentView{
    if (self.noContentViewTapedBlock)
    {
        self.noContentViewTapedBlock(); // 调用回调函数
    }
}

@end
