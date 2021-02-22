//
//  NSArray+MKSafe.h
//  MKKit
//
//  Created by zhangsuya on 2020/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray<ObjectType> (MKSafe)

- (ObjectType)mk_objectAtIndex:(NSUInteger)index;

- (NSUInteger)mk_indexOfObject:(ObjectType)anObject inRange:(NSRange)range;

- (NSUInteger)mk_indexOfObjectIdenticalTo:(ObjectType)anObject inRange:(NSRange)range;

- (NSArray<ObjectType> *)mk_arrayByAddingObject:(ObjectType)anObject;


- (NSArray<ObjectType> *)mk_subarrayWithRange:(NSRange)range;

- (BOOL)mk_writeToURL:(NSURL *)url error:(NSError **)error API_AVAILABLE(macos(10.13), ios(11.0), watchos(4.0), tvos(11.0));

- (NSArray<ObjectType> *)mk_objectsAtIndexes:(NSIndexSet *)indexes;

- (ObjectType)mk_objectAtIndexedSubscript:(NSUInteger)idx API_AVAILABLE(macos(10.8), ios(6.0), watchos(2.0), tvos(9.0));
@end

@interface NSMutableArray<ObjectType> (MKSafe)

- (void)mk_addObject:(ObjectType)anObject;

- (void)mk_insertObject:(ObjectType)anObject atIndex:(NSUInteger)index;

- (void)mk_removeObjectAtIndex:(NSUInteger)index;

- (void)mk_replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anObject;

- (void)mk_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;

- (void)mk_removeObject:(ObjectType)anObject inRange:(NSRange)range;

- (void)mk_removeObjectIdenticalTo:(ObjectType)anObject inRange:(NSRange)range;

- (void)mk_removeObjectsInRange:(NSRange)range;

- (void)mk_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<ObjectType> *)otherArray range:(NSRange)otherRange;

- (void)mk_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<ObjectType> *)otherArray;

- (void)mk_insertObjects:(NSArray<ObjectType> *)objects atIndexes:(NSIndexSet *)indexes;

- (void)mk_removeObjectsAtIndexes:(NSIndexSet *)indexes;

- (void)mk_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<ObjectType> *)objects;

- (void)mk_setObject:(ObjectType)obj atIndexedSubscript:(NSUInteger)idx API_AVAILABLE(macos(10.8), ios(6.0), watchos(2.0), tvos(9.0));

@end
NS_ASSUME_NONNULL_END
