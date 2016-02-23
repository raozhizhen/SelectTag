//
//  LPRoundedCornerView.m
//  SelectTags
//
//  Created by jm on 16/2/22.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import "LPRoundedCornerView.h"

@implementation LPRoundedCornerView {
    CGSize _size;
    CGFloat _radius;
    UIColor *_borderColor;
    CGFloat _borderWidth;
    UIColor *_backgroundColor;
    UIImage *_backgroundImage;
}

- (instancetype)initWithSize:(CGSize)size CornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage {
    self = [super init];
    if (self) {
        _size = size;
        _radius = radius;
        _borderColor = borderColor;
        _borderWidth = borderWidth;
        _backgroundColor = backgroundColor;
        _backgroundImage = backgroundImage;
        [self setUpView];
    }
    return self;
}

- (void)setUpView {
    float fw = _size.width;//180
    float fh = _size.height;//280
    float fr = _radius;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat red, green, blue, alpha;
    [_borderColor getRed:&red green:&green blue:&blue alpha:&alpha];
    CGContextSetRGBStrokeColor(context, red, green, blue, alpha);//画笔线的颜色
    CGContextSetLineWidth(context, _borderWidth);//线的宽度
    
    CGContextMoveToPoint(context, fw, fh-fr);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, fw-fr, fh, fw, fh-fr, fr);  // 右下角角度
    CGContextAddArcToPoint(context, 0, fh, 0, fh-fr, fr/2); // 左下角角度 原点坐标，半径，始末弧度，顺逆时针
    CGContextAddArcToPoint(context, fw, fh, fw-fr, fh, fr/2); // 左上角
    CGContextAddArcToPoint(context, fw, fh, fw, fh-fr, fr/2); // 右上角
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
}

@end
