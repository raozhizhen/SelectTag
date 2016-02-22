//
//  UIColor+SelectTags.h
//  SelectTags
//
//  Created by jm on 16/2/22.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SelectTags)

+ (instancetype)ST_009788_mainColor;          /**<主色*/
+ (instancetype)ST_969696_subMainColor;       /**<辅助色*/
+ (instancetype)ST_F3F3F3_backgroundColor;    /**<背景颜色*/
+ (instancetype)ST_CECECE_backgroundColor2;   /**<背景颜色2*/
+ (instancetype)ST_DCDCDC_separatorColor;     /**<分割线颜色*/

+ (UIColor *)colorFromRGB:(NSInteger)RGBValue;

@end
