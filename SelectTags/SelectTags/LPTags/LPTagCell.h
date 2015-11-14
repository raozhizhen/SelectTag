//
//  LPTagCell.h
//  SocialSport
//
//  Created by jm on 15/10/13.
//  Copyright © 2015年 Loopeer. All rights reserved.
//
/**
 *  标签Cell
 */
#import <UIKit/UIKit.h>
#import "LPTagModel.h"

typedef NS_ENUM(NSInteger, LPTagCellType) {
    LPTagCellTypeNormal,/**<正常*/
    LPTagCellTypeSelected1,/**<选中状态1，带背景颜色*/
    LPTagCellTypeSelected2/**<选中状态2*/
};

@interface LPTagCell : UICollectionViewCell

@property (nonatomic, strong) LPTagModel *model;
@property (nonatomic, assign) LPTagCellType type;
@property (nonatomic, strong) UILabel *textLabel;

+ (NSString *)cellReuseIdentifier;

@end
