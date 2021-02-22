//
//  MKMachOManager.h
//  MKKit
//
//  Created by zhangsuya on 2020/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
__attribute__((objc_subclassing_restricted))

@interface MKMachOManager : NSObject

extern void execObjectLoad(void);

@end

NS_ASSUME_NONNULL_END
