//
//  BBItem.h
//  ArchiveMultiDimArray
//
//  Created by Bryan Boyko on 8/29/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBItem : NSObject <NSCoding>

@property (nonatomic) NSString *itemName;

// Designated initializer for BNRItem
- (instancetype)initWithItemName:(NSString *)itemName;
- (instancetype)init;

@end
