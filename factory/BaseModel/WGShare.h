//
//  WGShare.h
//  factory
//
//  Created by Qing Chen on 2018/4/13.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGShare : NSObject

@property(nonatomic,copy) NSString* weiboTitle;
@property(nonatomic,copy) NSString* weiboIntroduction;
@property(nonatomic,copy) NSString* wechatTitle;
@property(nonatomic,copy) NSString* wechatIntroduction;
@property(nonatomic,copy) NSString* qqTitle;
@property(nonatomic,copy) NSString* qqIntroduction;
@property(nonatomic,copy) NSString* imageUrl;
@property(nonatomic,copy) NSString* wechatBrowseUrl;
@property(nonatomic,copy) NSString* nonWechatBrowseUrl;
@property (nonatomic,copy)NSString *shareUrl;

@property(nonatomic,assign) NSInteger type;
@property(nonatomic,assign) NSInteger albumID;

@end
