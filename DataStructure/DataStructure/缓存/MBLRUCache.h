//
//  MBLRUCache.h
//  DataStructure
//
//  Created by Bowen on 2020/8/21.
//  Copyright © 2020 inke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBLRUCache<__covariant KeyType, __covariant ObjectType> : NSObject

- (instancetype)initWithMaxCountLRU:(NSUInteger)maxCountLRU;

@property (readonly) NSUInteger count;

- (NSEnumerator<KeyType> *)keyEnumerator;

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(KeyType key, ObjectType obj, BOOL *stop))block;

- (void)removeObjectForKey:(KeyType)aKey;
- (void)setObject:(ObjectType)anObject forKey:(KeyType <NSCopying>)aKey;

- (void)removeAllObjects;
- (void)removeObjectsForKeys:(NSArray<KeyType> *)keyArray;

/// 执行LRU算法，当访问的元素可能是被淘汰的时候，可以通过在block中返回需要访问的对象，会根据LRU机制自动添加
- (ObjectType)objectForKey:(KeyType)aKey updateObjectUsingBlock:(ObjectType (^)(BOOL isClean))block;


@end

NS_ASSUME_NONNULL_END
