//
//  LPTagTextFieldCell.h
//  BangTuiKe
//
//  Created by jm on 15/11/10.
//  Copyright © 2015年 Loopeer. All rights reserved.
//
/**
 *  标签页输入框cell
 */
#import <UIKit/UIKit.h>
#import "LPTagModel.h"

@protocol LPAddTagDelegate <NSObject>
/**
 *  添加一个新标签
 *
 *  @param tagModel 添加的标签
 */
- (void)addTag:(LPTagModel *)tagModel;
/**
 *  删除最后一个标签
 */
- (void)deleteTag;
@end

@interface LPTagTextFieldCell : UICollectionViewCell

@property (nonatomic, strong)id<LPAddTagDelegate> delegate;

+ (NSString *)cellReuseIdentifier;

@end
