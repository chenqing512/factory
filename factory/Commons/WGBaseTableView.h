//
//  WGBaseTableView.h
//  factory
//
//  Created by Qing Chen on 2018/4/16.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGBaseTableView : UITableView


@property (copy,nonatomic) void(^noContentViewTapedBlock)();// 无数据占位图点击的回调函数

/*   使用方式
 // 展示无数据占位图
 [self.tableView showEmptyViewWithType:NoContentTypeNetwork];
 // 无数据占位图点击的回调
 self.tableView.noContentViewTapedBlock = ^{
 [SVProgressHUD showSuccessWithStatus:@"没网"];
 };
 
 // 移除无数据占位图
 [self.tableView removeEmptyView];
 
 */

/**
 展示无数据占位图
 
 @param emptyViewType 无数据占位图的类型
 */
- (void)showEmptyViewWithType:(NSInteger)emptyViewType;

/**
 移除无数据占位图
 */
- (void)removeEmptyView;


@end
