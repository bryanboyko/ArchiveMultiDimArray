//
//  BBBag.m
//  ArchiveMultiDimArray
//
//  Created by Bryan Boyko on 8/29/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import "BBBag.h"

@implementation BBBag

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.bagName = [aDecoder decodeObjectForKey:@"bagName"];
        self.itemsInBag = [aDecoder decodeObjectForKey:@"itemsInBag"];
    }
    return self;
}


- (instancetype)initWithBagName:(NSString *)bagName itemsInBag:(NSMutableArray *)itemsInBag
{
    self = [super init];
    if (self) {
        self.bagName = bagName;
        self.itemsInBag = [[NSMutableArray alloc] init];

        NSLog(@"itemsinbag: %@", self.itemsInBag);
    }
    return self;
}


- (instancetype)init{
    
    return [self initWithBagName:@"bag" itemsInBag:nil];
}


- (void)removeItemFromBag:(BBItem *)item
{
    [self.itemsInBag removeObjectIdenticalTo:item];
}


- (void)dealloc
{
    NSLog(@"Destroyed: %@", self);
}


- (NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"bagName:%@", self.bagName];
                                   
    return descriptionString;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.bagName forKey:@"bagName"];
    [aCoder encodeObject:self.itemsInBag forKey:@"itemsInBag"];
}
                                

@end
