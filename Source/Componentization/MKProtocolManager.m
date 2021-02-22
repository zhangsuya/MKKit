//
//  MKProtocolManager.m
//  MKKit
//
//  Created by zhangsuya on 2020/9/29.
//

#import "MKProtocolManager.h"
#import "MKLoadManager.h"
#import <objc/runtime.h>

@interface MKProtocolManager ()

@property (nonatomic, strong) NSRecursiveLock *lock;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSDictionary<NSString *, id> *> *classDict;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSDictionary<NSString *, id> *> *instanceDict;

@end

@implementation MKProtocolManager

+ (MKProtocolManager *)sharedInstance {
    static MKProtocolManager * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _classDict = [NSMutableDictionary dictionary];
        _instanceDict = [NSMutableDictionary dictionary];
    }
    return self;
}

void checkValidForObject(id obj, Protocol *protocol) {
    void(^check)(BOOL isInstanceMethod) = ^(BOOL isInstanceMethod){
        unsigned int count = 0;
        struct objc_method_description *methods = protocol_copyMethodDescriptionList(protocol, YES, isInstanceMethod, &count);
        for (int i = 0; i < count; i++) {
            struct objc_method_description desc = methods[i];
            if (!(isInstanceMethod ? [[obj class] instancesRespondToSelector:desc.name] : [[obj class] respondsToSelector:desc.name])) {
                NSString *errStr = [NSString stringWithFormat:@"\n⚠️⚠️⚠️⚠️(重要)⚠️⚠️⚠️⚠️---------\n%@未实现%@中的%@方法\n⚠️⚠️⚠️⚠️--------",[obj class], protocol, NSStringFromSelector(desc.name)];
//                [MKKitHandle log:errStr level:MKSErrorLevel_error];
            }
        }
    };
    check(YES);
    check(NO);
}

- (NSRecursiveLock *)lock {
    if (!_lock) {
        _lock = [[NSRecursiveLock alloc] init];
    }
    return _lock;
}

+ (void)registerObj:(id)object isClass:(BOOL)isClass forProtocol:(Protocol *)protocol priority:(MKPMPriority)priority {
    if (!protocol || !object) {
        return;
    }
//    if (MKKitHandle.isDebugMode) {
//        checkValidForObject(object, protocol);
//    }
    [self.sharedInstance.lock lock];
    NSString *key = NSStringFromProtocol(protocol);
    NSMutableDictionary *targetDict = isClass ? self.sharedInstance.classDict : self.sharedInstance.instanceDict;
    NSDictionary *dict = targetDict[key];
    if (dict == nil || [dict[@"priority"] integerValue] < priority) {
        targetDict[key] = @{@"priority":@(priority), @"object":object};
        [self.sharedInstance.lock unlock];
    } else {
        [self.sharedInstance.lock unlock];
        NSString *str = [NSString stringWithFormat:@"%@协议已经被%@类注册过,不能再次注册%@", key, targetDict[key], object];
//        [MKKitHandle log:str level:MKSErrorLevel_error];
    }
}

+ (id)getObjWithProtocol:(Protocol *)protocol isClass:(BOOL)isClass {
    if (!protocol) {
        return nil;
    }
    NSMutableDictionary *targetDict = isClass ? self.sharedInstance.classDict : self.sharedInstance.instanceDict;
    [self.sharedInstance.lock lock];
    NSString *key = NSStringFromProtocol(protocol);
    NSDictionary *dict = targetDict[key];
    id object = dict[@"object"];
    if (!object) {
        if (isClass) {
            object = [self.sharedInstance.instanceDict[key][@"object"] class];
        } else {
            id clsObj = self.sharedInstance.classDict[key][@"object"];
            if ([clsObj respondsToSelector:@selector(interfaceCreateInstance)]) {
                object = [self.sharedInstance.classDict[key][@"object"] interfaceCreateInstance];
            } else {
                object = [self.sharedInstance.classDict[key][@"object"] new];
            }
        }
    }
    [self.sharedInstance.lock unlock];
//    if (!object && MKKitHandle.isDebugMode) {
    if (!object) {
        NSString *str = [NSString stringWithFormat:@"\n⚠️⚠️⚠️⚠️⚠️(重要)⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️\n%@对应的组件不存在\n⚠️⚠️⚠️⚠️⚠️⚠️(重要)⚠️⚠️⚠️⚠️⚠️⚠️", NSStringFromProtocol(protocol)];
        NSLog(@"%@", str);
    }
    return object;
}

@end

@implementation MKProtocolManager (cls)

+ (void)registerClass:(Class<MKBaseComProtocol> _Nonnull)aClass forProtocol:(Protocol *_Nonnull)protocol {
    [self registerClass:aClass forProtocol:protocol priority:MKPMPriority_normal];
}

+ (void)registerClass:(Class<MKBaseComProtocol>)aClass forProtocol:(Protocol *)protocol priority:(MKPMPriority)priority {
    [self registerObj:aClass isClass:YES forProtocol:protocol priority:priority];
}

+ (Class)getClassWithProtocol:(Protocol *)protocol {
    return [self getObjWithProtocol:protocol isClass:YES];
}

+ (id)getInstanceWithProtocol:(Protocol *)protocol {
    return [self getObjWithProtocol:protocol isClass:NO];
}

@end


@implementation MKProtocolManager (instance)

+ (void)registerInstance:(id<MKBaseComProtocol>)object forProtocol:(Protocol *)protocol priority:(MKPMPriority)priority {
    [self registerObj:object isClass:NO forProtocol:protocol priority:priority];
}

@end
