//
//  BBItemStore.m
//  ArchiveMultiDimArray
//
//  Created by Bryan Boyko on 8/29/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import "BBItemStore.h"
#import "BBItem.h"

@interface BBItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BBItemStore

+ (instancetype)sharedStore{
    static BBItemStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}


- (instancetype)init
{
    @throw [NSException exceptionWithName:@"singleton" reason:@"use shared store init method" userInfo:nil];
    return nil;
}


- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        self.privateItems = [[NSMutableArray alloc] init];
        
        NSString *path = [self itemArchivePath];
        self.privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // if the array hadnt been saved before, create a new empty one
        if (!self.privateItems) {
            self.privateItems = [[NSMutableArray alloc] init];
        }
    }
    return self;
}


- (NSArray *)allItems
{
    return self.privateItems;
}


- (BBItem *)createItem
{
    BBItem *item = [[BBItem alloc] init];
    
    [self.privateItems addObject:item];
    
    return item;
}


- (void)removeItem:(BBItem *)item
{
    [self.privateItems removeObjectIdenticalTo:item];
}

- (NSString *)itemArchivePath
{
    NSArray *documentDictionaries = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // get the document directory from the list
    NSString *documentDirectory = [documentDictionaries firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}



- (BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    
    // returns YES on success
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}


@end
