//
//  UIImage+JMRoundedCorner.h
//  SelectTags
//
//  Created by jm on 16/2/18.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JMRoundedCorner)

//给UIImage来个圆角
- (UIImage *)yal_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius;

@end
