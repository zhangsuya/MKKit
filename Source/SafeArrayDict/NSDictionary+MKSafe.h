//
//  NSDictionary+MKSafe.h
//  MKKit
//
//  Created by zhangsuya on 2020/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<KeyType, ObjectType> (MKSafe)

- (BOOL)mk_writeToURL:(NSURL *)url error:(NSError **)error API_AVAILABLE(macos(10.13), ios(11.0), watchos(4.0), tvos(11.0));

+ (instancetype)mk_dictionaryWithObject:(id)object forKey:(id <NSCopying>)key;

- (ObjectType)mk_objectForKey:(KeyType)aKey;

- (id)mk_valueForKey:(id)aKay;

- (NSString *)mk_stringValueForKey:(id)aKay;
- (void)mk_addEntriesFromDictionary:(NSDictionary<KeyType, ObjectType> *)otherDictionary;

@end

@interface NSMutableDictionary<KeyType,ObjectType> (MKSafe)

- (void)mk_setObject:(ObjectType)anObject forKey:(KeyType <NSCopying>)aKey;
- (void)mk_setValue:(id)value forKey:(NSString *)key;
- (void)mk_addEntriesFromDictionary:(NSDictionary<KeyType, ObjectType> *)otherDictionary;

@end
NS_ASSUME_NONNULL_END
