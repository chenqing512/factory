//
//  UIImage+Common.m
//  factory
//
//  Created by chenqing on 2018/2/26.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)

/**
 由视图创建图片
 @return 图片对象
 */
+(UIImage*) imageWithView:(UIView*)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    return image;
}

+(UIImage*) imageWithColor:(UIColor*)color size:(CGSize)size
{
    
    CGSize imageSize = CGSizeMake(size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}


/**
 获取图片对象
 @param name 图片名称
 @param bundleName Bundle名称
 @return 图片对象
 */
+(UIImage*) imageNamed:(NSString *)name bundleName:(NSString*)bundleName
{
    return [UIImage imageNamed:@""];
}



/**
 *    等比缩放照片
 *
 *    @param     size     缩放的图片尺寸。如果该尺寸不是按照等比设置，则函数按照宽度或高度最大比例进行等比缩放。
 *
 *    @return    等比缩放后的图片对象
 */
-(UIImage*) scaleImageWithSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, newSize.width, newSize.height));
    CGContextSetInterpolationQuality(context,1);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height) blendMode:kCGBlendModeNormal alpha:1];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


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
{
    int w = size.width;
    int h = size.height;
    
    //UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //消除警告
    NSInteger f = kCGImageAlphaPremultipliedFirst;
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (CGBitmapInfo)f);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    //addRoundedRectToPath(context, rect, ovalWidth, ovalHeight);
    //(
    if (ovalWidth == 0 || ovalHeight == 0){
        CGContextAddRect(context, rect);
    } else {
        float fw, fh;
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextScaleCTM(context, ovalWidth, ovalHeight);
        fw = CGRectGetWidth(rect) / ovalWidth;
        fh = CGRectGetHeight(rect) / ovalHeight;
        CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
        CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
        CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
        CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
        CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
        CGContextClosePath(context);
        CGContextRestoreGState(context);
    }
    
    //)
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}



/**
 *  裁剪图片
 *
 *    @param     rect     裁剪范围
 *
 *    @return    裁剪后的图片对象
 */

-(UIImage*)clipImageWithRect:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, subImageRef);
    UIImage *viewImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    return viewImage;
}




/**
 * 获取灰度化图片
 *
 *    @return    灰度化图片
 */
- (UIImage *)grayImage
{
    int width = self.size.width;
    int height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    //kCGImageAlphaNone
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,0);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), self.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

// 截屏
+ (UIImage *)screenshot
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    
    if (NULL != UIGraphicsBeginImageContextWithOptions) {
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    } else {
        UIGraphicsBeginImageContext(imageSize);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            CGContextSaveGState(context);
            
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            
            CGContextConcatCTM(context, [window transform]);
            
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            [[window layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}




+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize, image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    CGRect rect = (CGRect){0.f, 0.f, self.size};
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 1.0;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 1.0;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

//裁剪图片
+(UIImage *)cutImage:(UIImage*)image{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < ([Variable screenWidth] / [Variable screenHeight])) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * [Variable screenHeight] / [Variable screenWidth];
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * [Variable screenWidth] / [Variable screenHeight];
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
