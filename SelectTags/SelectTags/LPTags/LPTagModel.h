//
//  LPTagModel.h
//  SocialSport
//
//  Created by jm on 15/10/23.
//  Copyright © 2015年 Loopeer. All rights reserved.
//
/**
 *  标签model
 */
#import <Foundation/Foundation.h>

@interface LPTagModel : NSObject

@property (nonatomic, strong) NSNumber *identifier;/**<活动标签id*/
@property (nonatomic, copy) NSString *name;/**<标签名称*/
@property (nonatomic, assign) BOOL isChoose;/**<是否被选择*/

@end
