//
//  MKMacro.h
//  MKKit
//
//  Created by zhangsuya on 2020/9/29.
//

#ifndef MKMacro_h
#define MKMacro_h

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#ifndef LogFuncDuration
    #if DEBUG
        #define LogFuncDuration(LogFlagStr, _code_) \
        do { \
            [LogFlagStr isEqual:nil]; \
            NSTimeInterval a = CFAbsoluteTimeGetCurrent(); \
            _code_ \
            NSTimeInterval b = CFAbsoluteTimeGetCurrent(); \
            if (NSThread.isMainThread) { \
                NSLog(@"time.%@  %f", LogFlagStr, (b - a) * 1000); \
            } \
        } while(0);
    #else
        #define LogFuncDuration(LogFlagStr, _code_) _code_
    #endif
#endif

#ifndef YYSYNTH_DUMMY_CLASS
#define YYSYNTH_DUMMY_CLASS(_name_) \
@interface YYSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation YYSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif




static inline void asyncOnMainQueue(dispatch_block_t block) {
    if (NSThread.isMainThread) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

static inline void asyncOnGlobalQueue(dispatch_block_t block) {
    if (NSThread.isMainThread) {
        dispatch_async(dispatch_get_global_queue(0, 0), block);
    } else {
        block();
    }
}

// iOS系统版本
#define SYSTEM_VERSION    [[[UIDevice currentDevice] systemVersion] doubleValue]
// 标准系统状态栏高度
#define SYS_STATUSBAR_HEIGHT        20
// 热点栏高度
#define HOTSPOT_STATUSBAR_HEIGHT    20
// 工具栏（UINavigationController.UIToolbar）高度
#define TOOLBAR_HEIGHT                 44
// 标签栏（UITabBarController.UITabBar）高度
#define TABBAR_HEIGHT                 49
// 导航栏（UINavigationController.UINavigationBar）高度
#define NAVIGATION_BAR_HEIGHT         44

#define PerformSelectorNoLeakWarning(_func_) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
_func_; \
_Pragma("clang diagnostic pop") \
} while (0)

#define BeforeMain_AfterLoad(funcName) \
__attribute__((constructor))\
static void funcName(void)

#define ActionJump(_action_) PerformSelectorNoLeakWarning(ActionJumpReal(_action_));

#ifndef NSLog
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif
#endif

#endif /* MKMacro_h */
