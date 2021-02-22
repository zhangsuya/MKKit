//
//  MKLoadManager.h
//  MKKit
//
//  Created by zhangsuya on 2020/9/29.
//

#import <Foundation/Foundation.h>
#import "MKMachOManager.h"

#ifndef NSLog
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif
#endif

// -----load方法统一管理，使用MKLoad宏替换 系统+(void)load方法-------
#define _tyuiopMKLoad2(int_priority, _id) _MKLoadFunc(int_priority, _id)
#define _tyuiopMKLoad1(int_priority) _MKLoadFunc(int_priority, uibfa)
#define _tyuiopMKLoad(_1, _2, NAME, ...) NAME
#define MKLoad(int_priority, id...) _tyuiopMKLoad(int_priority, id, _tyuiopMKLoad2, _tyuiopMKLoad1)(int_priority, ##id)

NS_ASSUME_NONNULL_BEGIN

@interface MKLoadManager : NSObject

@end

NS_ASSUME_NONNULL_END
