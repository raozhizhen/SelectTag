//
//  LPTagCollectionView.h
//  SocialSport
//
//  Created by jm on 15/10/13.
//  Copyright © 2015年 Loopeer. All rights reserved.
//
/**
 *  标签collectionView
 */
#import <Foundation/Foundation.h>
#import "LPTagModel.h"
#import <UIKit/UIKit.h>

@protocol LPSwitchTagDelegate <NSObject>
/**
 *  返回选择的标签
 *
 *  @param tagModel 选择的标签
 */
- (void)switchTag:(LPTagModel *)tagModel;
/**
 *  取消选择的标签
 *
 *  @param tagModel 标签
 */
- (void)disSwitchTag:(LPTagModel *)tagModel;
@end

@interface LPTagCollectionView : UICollectionView

@property (nonatomic, assign) NSInteger maximumNumber;/**<最多选项数,默认不限制*/
@property (nonatomic, strong) NSArray *tagArray;/**<标签数组,数组里存放LPTagModel*/
@property (nonatomic, strong) id <LPSwitchTagDelegate> tagDelegate;

@end
