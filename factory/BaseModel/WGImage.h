//
//  WGImage.h
//  factory
//
//  Created by Qing Chen on 2018/4/13.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface WGImage : NSObject

@property (nonatomic, strong) PHAsset *phasset;
@property (nonatomic, strong) NSData  *imgData;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) UIImage  *img;

@end
