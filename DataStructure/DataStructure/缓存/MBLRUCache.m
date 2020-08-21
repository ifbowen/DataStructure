//
//  MBLRUCache.m
//  DataStructure
//
//  Created by Bowen on 2020/8/21.
//  Copyright © 2020 inke. All rights reserved.
//

#import "MBLRUCache.h"

@interface MBLRUCache ()

@property (nonatomic, strong) NSMutableDictionary *dict;
@property (nonatomic, strong) NSMutableArray *arrayForLRU;
@property (nonatomic, assign) NSUInteger maxCountLRU;

@end

@implementation MBLRUCache

- (instancetype)initWithMaxCountLRU:(NSUInteger)maxCountLRU
{
    self = [super init];
    if (self) {
        _dict = [[NSMutableDictionary alloc] initWithCapacity:maxCountLRU];
        _arrayForLRU = [[NSMutableArray alloc] initWithCapacity:maxCountLRU];
        _maxCountLRU = maxCountLRU;
    }
    return self;
}

#pragma mark - NSDictionary

- (NSUInteger)count
{
    return [_dict count];
}

- (NSEnumerator *)keyEnumerator
{
    return [_dict keyEnumerator];
}

- (id)objectForKey:(id)aKey
{
    return [self objectForKey:aKey updateObjectUsingBlock:^id(BOOL isClean) {
        return nil;
    }];
}

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id, id, BOOL *))block
{
    [_dict enumerateKeysAndObjectsUsingBlock:block];
}

#pragma mark - NSMutableDictionary

- (void)removeObjectForKey:(id)aKey
{
    [_dict removeObjectForKey:aKey];
    [self _removeObjectLRU:aKey];
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    BOOL isExist = ([_dict objectForKey:aKey] != nil);
    [_dict setObject:anObject forKey:aKey];
    
    if (isExist) {
        [self _adjustPositionLRU:aKey];
    } else {
        [self _addObjectLRU:aKey];
    }
}

- (void)removeAllObjects
{
    [_dict removeAllObjects];
    [_arrayForLRU removeAllObjects];
}

- (void)removeObjectsForKeys:(NSArray *)keyArray
{
    [_dict removeObjectsForKeys:keyArray];
    [_arrayForLRU removeObjectsInArray:keyArray];
}

#pragma mark - LRUMutableDictionary

- (id)objectForKey:(id)aKey updateObjectUsingBlock:(id (^)(BOOL))block
{
    id object = [_dict objectForKey:aKey];
    if (object) {
        [self _adjustPositionLRU:aKey];
    }
    if (block) {
        BOOL isClean = object ? NO : YES;
        id newObject = block(isClean);
        if (newObject) {
            [self setObject:newObject forKey:aKey];
            return [_dict objectForKey:aKey];
        }
    }
    return object;
}

#pragma mark - LRU

- (void)_adjustPositionLRU:(id)anObject
{
    NSUInteger idx = [_arrayForLRU indexOfObject:anObject];
    if (idx != NSNotFound) {
        [_arrayForLRU removeObjectAtIndex:idx];
        [_arrayForLRU insertObject:anObject atIndex:0];
    }
}

- (void)_addObjectLRU:(id)anObject
{
    [_arrayForLRU insertObject:anObject atIndex:0];
    // 当超出LRU算法限制之后，将最不常使用的元素淘汰
    if ((_maxCountLRU > 0) && (_arrayForLRU.count > _maxCountLRU)) {
        [_dict removeObjectForKey:[_arrayForLRU lastObject]];
        [_arrayForLRU removeLastObject];
    }
}

- (void)_removeObjectLRU:(id)anObject
{
    [_arrayForLRU removeObject:anObject];
}

@end
