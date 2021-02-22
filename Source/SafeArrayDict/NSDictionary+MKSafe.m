//
//  NSDictionary+MKSafe.m
//  MKKit
//
//  Created by zhangsuya on 2020/9/27.
//

#import "NSDictionary+MKSafe.h"

@implementation NSDictionary (MKSafe)

- (BOOL)mk_writeToURL:(NSURL *)url error:(NSError * _Nullable __autoreleasing *)error {
    if (url == nil) {
        return NO;
    }else {
        return [self writeToURL:url error:error];
    }
}

+ (instancetype)mk_dictionaryWithObject:(id)object forKey:(id)key {
    if (object == nil || key == nil) {
        return nil;
    }else {
        return [NSDictionary dictionaryWithObject:object forKey:key];
    }
}

- (id)mk_objectForKey:(id)aKey {
    if (aKey) {
        id result = [self objectForKey:aKey];
        if ([result isKindOfClass:NSNull.class]) {
            return nil;
        }
        return result;
    }
    return nil;
}

- (id)mk_valueForKey:(id)aKay {
    if (aKay) {
        id result = [self valueForKey:aKay];
        if ([result isKindOfClass:NSNull.class]) {
            return nil;
        }
        return result;
    }
    return nil;
}

- (NSString *)mk_stringValueForKey:(id)aKay {
    id obj = [self mk_valueForKey:aKay];
    if (!obj) {
        return nil;
    }
    if ([obj isKindOfClass:NSString.class]) {
        return obj;
    } else if ([obj isKindOfClass:NSNumber.class]) {
        return [obj stringValue];
    }
    return nil;
}

- (void)mk_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject && aKey && [self isKindOfClass:NSMutableDictionary.class]) {
        [(NSMutableDictionary *)self setObject:anObject forKey:aKey];
    }
}

- (void)mk_setValue:(id)value forKey:(NSString *)key {
    if (key && [self isKindOfClass:NSMutableDictionary.class]) {
        [(NSMutableDictionary *)self setValue:value forKey:key];
    }
}

- (void)mk_addEntriesFromDictionary:(NSDictionary *)otherDictionary {
    if (otherDictionary &&
        [otherDictionary isKindOfClass:NSDictionary.class] &&
        [self isKindOfClass:NSMutableDictionary.class]) {
        [(NSMutableDictionary *)self addEntriesFromDictionary:otherDictionary];
    }
}


@end
