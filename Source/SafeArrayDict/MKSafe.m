//
//  MKSafe.m
//  MKKit
//
//  Created by zhangsuya on 2020/9/27.
//

#import "MKSafe.h"
#import "NSArray+MKSafe.h"
#import "NSDictionary+MKSafe.h"
#import <objc/runtime.h>

@implementation NSArray(SafeArray)

- (MKSafeArray *)mkSafe {
    MKSafeArray *arr = objc_getAssociatedObject(self, @selector(mkSafe));
    if (!arr) {
        arr = [MKSafeArray new];
        arr.originArray = self;
        objc_setAssociatedObject(self, @selector(mkSafe), arr, OBJC_ASSOCIATION_RETAIN);
    }
    return arr;
}

@end

@implementation NSDictionary(SafeDictionary)

- (MKSafeDictionary *)mkSafe {
    MKSafeDictionary *dict = objc_getAssociatedObject(self, @selector(mkSafe));
    if (!dict) {
        dict = [MKSafeDictionary new];
        dict.originDict = self;
        objc_setAssociatedObject(self, @selector(mkSafe), dict, OBJC_ASSOCIATION_RETAIN);
    }
    return dict;
}

@end

@implementation NSObject(Safe)

- (id)mkSafe {
    NSString *error = [NSString stringWithFormat:@"%@ is not NSDictionary or NSArray",self];
    NSAssert(NO, error);
    return nil;
}

@end


@implementation MKSafeArray
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-value"
- (id)objectAtIndex:(NSUInteger)index {
    return [self.originArray mk_objectAtIndex:index];
}
#pragma clang diagnostic pop

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self objectAtIndex:idx];
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if ([self.originArray isKindOfClass:NSMutableArray.class]) {
        [(NSMutableArray *)self.originArray mk_setObject:obj atIndexedSubscript:idx];
    }
}

@end


@implementation MKSafeDictionary
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-value"
- (id)objectForKey:(id)aKey {
    return [self.originDict mk_objectForKey:aKey];
}

#pragma clang diagnostic pop

- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if ([self.originDict isKindOfClass:NSMutableDictionary.class]) {
        [(NSMutableDictionary *)self.originDict mk_setObject:obj forKey:key];
    }
}

@end

