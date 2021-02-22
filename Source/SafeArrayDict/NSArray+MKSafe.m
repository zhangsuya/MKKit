//
//  NSArray+MKSafe.m
//  MKKit
//
//  Created by zhangsuya on 2020/9/27.
//

#import "NSArray+MKSafe.h"

@implementation NSArray (MKSafe)
-(BOOL)isSafeRange:(NSRange)range {
   return ((range.location + range.length) <= self.count);
}

- (BOOL)isSafeIndexes:(NSIndexSet *)indexes {
   if (indexes && self.count > 0 && indexes.lastIndex < self.count) {
       return YES;
   }
   return NO;
}

- (id)mk_objectAtIndex:(NSUInteger)index {
   if (index < self.count) {
       id result = [self objectAtIndex:index];
       if ([result isKindOfClass:NSNull.class]) {
           return nil;
       }
       return result;
   } else {
       return nil;
   }
}

- (NSUInteger)mk_indexOfObject:(id)anObject inRange:(NSRange)range {
   if (![self isSafeRange:range] || anObject == nil) {
       return -1;
   }else {
       return [self indexOfObject:anObject inRange:range];
   }
}

- (NSUInteger)mk_indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
   if (![self isSafeRange:range] || anObject == nil) {
       return -1;
   }else {
       return [self mk_indexOfObjectIdenticalTo:anObject inRange:range];
   }
}

- (NSArray *)mk_arrayByAddingObject:(id)anObject {
   if (anObject == nil) {
       return nil;
   }else {
       return [self arrayByAddingObject:anObject];
   }
}

- (NSArray *)mk_subarrayWithRange:(NSRange)range {
   if (![self isSafeRange:range]) {
       return nil;
   }else {
       return [self subarrayWithRange:range];
   }
}

- (BOOL)mk_writeToURL:(NSURL *)url error:(NSError *__autoreleasing *)error {
   if (url == nil) {
       return NO;
   }else {
       return [self writeToURL:url error:error];
   }
}

- (NSArray *)mk_objectsAtIndexes:(NSIndexSet *)indexes {
   if ([self isSafeIndexes:indexes]) {
       return [self objectsAtIndexes:indexes];
   } else {
       return nil;
   }
}

- (id)mk_objectAtIndexedSubscript:(NSUInteger)idx {
   return [self mk_objectAtIndex:idx];
}

@end

@implementation NSMutableArray (MKSafe)

- (void)mk_addObject:(id)anObject {
    if (anObject == nil) {
    }else {
        [self addObject:anObject];
    }
}

- (void)mk_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject && index <= self.count) {
        [self insertObject:anObject atIndex:index];
    }
}

- (void)mk_removeObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

- (void)mk_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index < self.count && anObject) {
         [self replaceObjectAtIndex:index withObject:anObject];
    }
}

- (void)mk_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    if (idx1 < self.count && idx2 < self.count) {
        [self exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    }
}

- (void)mk_removeObject:(id)anObject inRange:(NSRange)range {
    if (![self isSafeRange:range]  || anObject == nil) {
    }else {
        [self removeObject:anObject inRange:range];
    }
}

- (void)mk_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
    if (![self isSafeRange:range] || anObject == nil) {
    }else {
        [self mk_removeObjectIdenticalTo:anObject inRange:range];
    }
}

- (void)mk_removeObjectsInRange:(NSRange)range {
    if (![self isSafeRange:range]) {
    }else {
        [self removeObjectsInRange:range];
    }
}

-(void)mk_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange {
    if (![self isSafeRange:range] || otherArray == nil || ![otherArray isSafeRange:otherRange]) {
    }else {
        [self replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
    }
}

- (void)mk_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray {
    if (![self isSafeRange:range] || otherArray == nil) {
    }else {
        [self replaceObjectsInRange:range withObjectsFromArray:otherArray];
    }
}

- (void)mk_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
    if (objects && indexes && objects.count == indexes.count && indexes.firstIndex <= self.count) {
        [self insertObjects:objects atIndexes:indexes];
    }
}

- (void)mk_removeObjectsAtIndexes:(NSIndexSet *)indexes {
    if ([self isSafeIndexes:indexes]) {
        [self removeObjectsAtIndexes:indexes];
    }
}

- (void)mk_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects {
    if ([self isSafeIndexes:indexes] && objects != nil && indexes.count == objects.count) {
        [self replaceObjectsAtIndexes:indexes withObjects:objects];
    }
}

- (void)mk_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if (obj) {
        if (idx < self.count) {
            [self replaceObjectAtIndex:idx withObject:obj];
        } else if (idx == self.count) {
            [self mk_addObject:obj];
        }
    }
}


@end
