//
//  MKProtocolManager.h
//  MKKit
//
//  Created by zhangsuya on 2020/9/29.
//

#import <Foundation/Foundation.h>
#import "MKBaseComProtocol.h"
#import "MKLoadManager.h"
//#import "<#header#>"

typedef NS_ENUM(NSUInteger, MKPMPriority) {
    MKPMPriority_normal = 0,
    MKPMPriority_high,
};

/**
 绑定类与协议 (.m中只能使用一次，若想多次使用，可用 MKSAnnotationClassWithId )
 */
#define MKSAnnotationClass(_class_name, _protocol_name...) _GetMKSAnnotationClassMacro(_class_name, _protocol_name, _MKS3AnnotationClass, _MKS2AnnotationClass, ...)(_class_name,_protocol_name)

/**
 绑定实例与协议 (.m中只能使用一次，若想多次使用，可用 MKSAnnotationInstanceWithId )
 */
//#define MKSAnnotationInstance(_instance, _protocol_name...) _GetMKSAnnotationInstanceMacro(_instance, _protocol_name, _MKS3AnnotationInstance, _MKS2AnnotationInstance, ...)(_instance,_protocol_name)

/**
 绑定类与协议 (一个.m可以写多次 只要id不一样就行)
 */
#define MKSAnnotationClassWithId(AnyString, _class_name, _protocol_name...) _GetMKSAnnotationClassMacroWithId(_id_, _class_name, _protocol_name, _MKS3AnnotationClassWithId, _MKS2AnnotationClassWithId, ...)(AnyString,_class_name,_protocol_name)

/**
 绑定实例与协议 (一个.m可以写多次 只要id不一样就行)
 */
//#define MKSAnnotationInstanceWithId(AnyString, _instance, _protocol_name...) _GetMKSAnnotationInstanceMacroWithId(AnyString, _instance, _protocol_name, _MKS3AnnotationInstanceWithId, _MKS2AnnotationInstanceWithId, ...)(_id_,_instance,_protocol_name)


/**
 组件A 向MKProtocolManager 注册 A的接口
 组件B 用A接口向MKProtocolManager取 组件A的实例或Class
 */
NS_ASSUME_NONNULL_BEGIN
__attribute__((objc_subclassing_restricted))
@interface MKProtocolManager : NSObject

@end

@interface MKProtocolManager (cls)

+ (void)registerClass:(Class<MKBaseComProtocol> _Nonnull)aClass forProtocol:(Protocol *_Nonnull)protocol priority:(MKPMPriority)priority;
+ (void)registerClass:(Class<MKBaseComProtocol> _Nonnull)aClass forProtocol:(Protocol *_Nonnull)protocol;



/// 获取注册的Class
+ (Class _Nullable)getClassWithProtocol:(Protocol *_Nonnull)protocol;

/// 注册的一般是class, 可重写class的+ (instancetype)interfaceCreateInstance;方法   控制该方法获取的是 单例 还是 实例
+ (id _Nullable)getInstanceWithProtocol:(Protocol *_Nonnull)protocol;

@end
NS_ASSUME_NONNULL_END
