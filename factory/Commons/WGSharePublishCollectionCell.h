//
//  WGSharePublishCollectionCell.h
//  factory
//
//  Created by Qing Chen on 2018/4/16.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WG_SHARE_PUBLISH_COLLECTION_CELL        @"WG_SHARE_PUBLISH_COLLECTION_CELL"

@interface WGSharePublishCollectionCell : UICollectionViewCell

@property(nonatomic,assign) NSInteger index;

+(CGSize)defaultSize;

@end
