//
//  MKSafe.h
//  MKKit
//
//  Created by zhangsuya on 2020/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKSafeArray<__covariant ObjectType> : NSObject
@property (nonatomic, weak) NSArray *_Nullable originArray;
- (ObjectType _Nullable)objectAtIndexedSubscript:(NSUInteger)idx;
@end

@interface MKSafeMutableArray<ObjectType> : MKSafeArray<ObjectType>
- (void)setObject:(ObjectType _Nullable)obj atIndexedSubscript:(NSUInteger)idx;
@end

@interface MKSafeDictionary<__covariant KeyType, __covariant ObjectType> : NSObject
@property (nonatomic, weak) NSDictionary *_Nullable originDict;

- (ObjectType _Nullable)objectForKeyedSubscript:(KeyType<NSCopying>_Nullable)key;
@end

@interface MKSafeMutableDictionary<KeyType, ObjectType> : MKSafeDictionary<KeyType, ObjectType>
- (void)setObject:(_Nullable ObjectType)obj forKeyedSubscript:(KeyType<NSCopying>_Nullable)key;
@end

@interface NSArray<ObjectType> (SafeArray)
/** id value = array.mkSafe[10] */
@property (nonatomic, readonly)MKSafeArray<ObjectType> *_Nonnull mkSafe;
@end

@interface NSMutableArray<ObjectType> (SafeArray)
/** array.mkSafe[0] = @"a" */
@property (nonatomic, readonly)MKSafeMutableArray<ObjectType> *_Nonnull mkSafe;
@end

@interface NSDictionary<KeyType, ObjectType> (SafeDictionary)
/** id value = dict.mkSafe[@"name"]" */
@property (nonatomic, readonly)MKSafeDictionary<KeyType, ObjectType> *_Nonnull mkSafe;
@end

@interface NSMutableDictionary<KeyType, ObjectType> (SafeDictionary)
/** dict.mkSafe[@"name"] = @"xiaoming" */
@property (nonatomic, readonly)MKSafeMutableDictionary<KeyType, ObjectType> *_Nonnull mkSafe;
@end

NS_ASSUME_NONNULL_END
