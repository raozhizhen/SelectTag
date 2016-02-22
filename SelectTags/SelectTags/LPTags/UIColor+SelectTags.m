//
//  UIColor+SelectTags.m
//  SelectTags
//
//  Created by jm on 16/2/22.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import "UIColor+SelectTags.h"

@implementation UIColor (SelectTags)

+ (instancetype)ST_009788_mainColor {
    return [UIColor colorFromRGB:0x009788];
}

+ (instancetype)ST_969696_subMainColor {
    return [UIColor colorFromRGB:0x969696];
}

+ (instancetype)ST_F3F3F3_backgroundColor {
    return [UIColor colorFromRGB:0xF3F3F3];
}

+ (instancetype)ST_CECECE_backgroundColor2 {
    return [UIColor colorFromRGB:0xCECECE];
}

+ (instancetype)ST_DCDCDC_separatorColor {
    return [UIColor colorFromRGB:0xDCDCDC];
}

+ (UIColor *)colorFromRGB:(NSInteger)RGBValue {
    return [UIColor colorWithRed:((float)((RGBValue & 0xFF0000) >> 16))/255.0 green:((float)((RGBValue & 0xFF00) >> 8))/255.0 blue:((float)(RGBValue & 0xFF))/255.0 alpha:1.0];
}

@end
