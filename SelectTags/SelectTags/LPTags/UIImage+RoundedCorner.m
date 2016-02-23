//
//  UIImage+RoundedCorner.m
//  SelectTags
//
//  Created by jm on 16/2/22.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import "UIImage+RoundedCorner.h"

@implementation UIImage (RoundedCorner)
- (UIImage *)imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius {
    return [UIImage imageWithRoundedCornersAndSize:sizeToFit CornerRadius:radius borderColor:nil borderWidth:0 backgroundColor:nil backgroundImage:self];
}

+ (UIImage *)imageWithRoundedCornersAndSize:(CGSize)sizeToFit CornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    return [UIImage imageWithRoundedCornersAndSize:sizeToFit CornerRadius:radius borderColor:borderColor borderWidth:0 backgroundColor:nil backgroundImage:nil];
}

+ (UIImage *)imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius andColor:(UIColor *)color {
    return [UIImage imageWithRoundedCornersAndSize:sizeToFit CornerRadius:radius borderColor:nil borderWidth:0 backgroundColor:color backgroundImage:nil];
}

+ (UIImage *)imageWithRoundedCornersAndSize:(CGSize)sizeToFit CornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage {
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, UIScreen.mainScreen.scale);
//    UIImage *image;

    if ((borderWidth != 0 && borderColor) || backgroundColor) {
//        [image drawInRect:rect];

        //设置上下文
        CGContextRef context = UIGraphicsGetCurrentContext();
        //边框大小
        CGContextSetLineWidth(context, borderWidth);
        //边框颜色
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
        //矩形填充颜色
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGFloat height = sizeToFit.height;
        CGFloat width = sizeToFit.width;
    
        CGContextMoveToPoint(context, width, radius);  // 开始坐标右边开始
        CGContextAddArcToPoint(context, width, height, width - radius, height, radius);  // 右下角角度
        CGContextAddArcToPoint(context, 0, height, 0, height - radius, radius); // 左下角角度
        CGContextAddArcToPoint(context, 0, 0, width, 0, radius); // 左上角
        CGContextAddArcToPoint(context, width, 0, width, radius, radius); // 右上角
        CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    }
    if (backgroundImage) {
        CGRect rect = (CGRect){0.f, 0.f, sizeToFit};
        //        CGColorSpaceRef colorspace = CGImageGetColorSpace(backgroundImage.CGImage);
        //
        //        CGContextRef context = CGBitmapContextCreate(NULL,
        //                                                     sizeToFit.width , // Changed this
        //                                                     sizeToFit.height, // Changed this
        //                                                     CGImageGetBitsPerComponent(backgroundImage.CGImage),
        //                                                     CGImageGetBytesPerRow(backgroundImage.CGImage)/CGImageGetWidth(backgroundImage.CGImage)*sizeToFit.width, // Changed this
        //                                                     colorspace,
        //                                                     CGImageGetAlphaInfo(backgroundImage.CGImage));
        //
        // Removed clipping code
        
        // draw image to context
        //        CGContextDrawImage(context, CGContextGetClipBoundingBox(context), backgroundImage.CGImage);
        
        // extract resulting image from context
        //        CGImageRef imgRef = CGBitmapContextCreateImage(context);
        CGContextAddPath(UIGraphicsGetCurrentContext(),
                         [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
        CGContextClip(UIGraphicsGetCurrentContext());
        [backgroundImage drawInRect:rect];
    }
    
    UIImage *outImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outImage;
}

+ (UIImage *)yal_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius andColor:(UIColor *)color {
    CGRect rect = (CGRect){0.f, 0.f, sizeToFit};
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    UIImage *image = [UIImage createImageWithColor:color];
    
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    [image drawInRect:rect];
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

+ (UIImage *)createImageWithColor:(UIColor *)color {
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
