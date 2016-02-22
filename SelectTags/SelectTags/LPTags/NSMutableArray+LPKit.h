//
//  NSMutableArray+LPKit.h
//  LoopeerLibrary
//
//  Created by dengjiebin on 12/31/14.
//  Copyright (c) 2014 Loopeer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (LPKit)


/**
 * Get the object at a given index in safe mode (nil if self is empty)
 *
 */
- (id)safeObjectAtIndex:(NSUInteger)index;


/**
 * Move an object from an index to another
 *
 */
- (void)moveObjectFromIndex:(NSUInteger)from
                    toIndex:(NSUInteger)to;

/**
 * Create a reversed array from self
 *
 */
- (NSMutableArray *)reversedArray;


/**
 * Sort an array by a given key with option for ascending or descending
 *
 */
+ (NSMutableArray *)sortArrayByKey:(NSString *)key
                             array:(NSMutableArray *)array
                         ascending:(BOOL)ascending;



@end
