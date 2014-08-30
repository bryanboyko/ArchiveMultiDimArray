//
//  BBBag.h
//  ArchiveMultiDimArray
//
//  Created by Bryan Boyko on 8/29/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBItem.h"

@interface BBBag : NSObject <NSCoding>

// designated initializer
- (instancetype)initWithBagName:(NSString *)bagName itemsInBag:(NSMutableArray *)itemsInBag;


@property (nonatomic, copy) NSString *bagName;
@property (nonatomic) NSMutableArray *itemsInBag;

- (void)removeItemFromBag:(BBItem *)item;

@end
