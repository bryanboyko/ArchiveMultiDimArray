//
//  BBBagStore.m
//  ArchiveMultiDimArray
//
//  Created by Bryan Boyko on 8/29/14.
//  Copyright (c) 2014 none. All rights reserved.
//

#import "BBBagStore.h"
#import "BBBag.h"

@interface BBBagStore ()

@property (nonatomic) NSMutableArray *privateBags;

@end

@implementation BBBagStore

+ (instancetype)sharedStore{
    static BBBagStore *sharedStore = nil;
    
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
        self.privateBags = [[NSMutableArray alloc] init];
        
        NSString *path = [self bagArchivePath];
        self.privateBags = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // if the array hadnt been saved before, create a new empty one
        if (!self.privateBags) {
            self.privateBags = [[NSMutableArray alloc] init];
        }
    }
    return self;
}


- (NSArray *)allBags
{
    return self.privateBags;
}


- (BBBag *)createBag
{
    BBBag *bag = [[BBBag alloc] init];
    
    [self.privateBags addObject:bag];
    
    return bag;
}


- (void)removeBag:(BBBag *)bag
{
    [self.privateBags removeObjectIdenticalTo:bag];
}

- (NSString *)bagArchivePath
{
    NSArray *documentDictionaries = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // get the document directory from the list
    NSString *documentDirectory = [documentDictionaries firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"bags.archive"];
}



- (BOOL)saveChanges
{
    NSString *path = [self bagArchivePath];
    
    // returns YES on success
    return [NSKeyedArchiver archiveRootObject:self.privateBags toFile:path];
}




@end
