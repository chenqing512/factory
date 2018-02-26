//
//  UIImage+Common.h
//  factory
//
//  Created by chenqing on 2018/2/26.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Common)

/**
 由视图创建图片
 @return 图片对象
 */
+(UIImage*) imageWithView:(UIView*)view;

/**
 根据颜色创建UIImage
 */
+(UIImage*) imageWithColor:(UIColor*)color size:(CGSize)size;


/**
 获取图片对象
 @param name 图片名称
 @param bundleName Bundle名称
 @return 图片对象
 */
+(UIImage*) imageNamed:(NSString *)name bundleName:(NSString*)bundleName;



/**
 *    等比缩放照片
 *
 *    @param     size     缩放的图片尺寸。如果该尺寸不是按照等比设置，则函数按照宽度或高度最大比例进行等比缩放。
 *
 *    @return    等比缩放后的图片对象
 */
-(UIImage*) scaleImageWithSize:(CGSize)size;


/**
 *    创建圆角图片
 *
 *    @param     size     圆角图像的图片尺寸
 *    @param     ovalWidth     圆角宽度
 *    @param     ovalHeight     圆角高度
 *
 *    @return    圆角图片对象引用
 */
- (UIImage *)createRoundedRectWithsize:(CGSize)size
                             ovalWidth:(CGFloat)ovalWidth
                            ovalHeight:(CGFloat)ovalHeight;


/**
 *  裁剪图片
 *
 *    @param     rect     裁剪范围
 *
 *    @return    裁剪后的图片对象
 */

-(UIImage*)clipImageWithRect:(CGRect)rect;




/**
 * 获取灰度化图片
 *
 *    @return    灰度化图片
 */
- (UIImage *)grayImage;


+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

/**
 *  图片切圆
 *
 *  @param radius 半径
 *
 *  @return UIImage
 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;
/**
 *  等比例压缩
 *
 *  @param sourceImage 缩放的图片
 *  @param size        缩放后的尺寸
 *
 *  @return UIImage
 */
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

//裁剪图片
+(UIImage *)cutImage:(UIImage*)image;

+ (UIImage *)imageWithColor:(UIColor *)color;

@end
