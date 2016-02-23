//
//  LPRoundedCornerView.h
//  SelectTags
//
//  Created by jm on 16/2/22.
//  Copyright © 2016年 Jim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPRoundedCornerView : UIView

- (instancetype)initWithSize:(CGSize)size CornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor backgroundImage:(UIImage *)backgroundImage;

@end
