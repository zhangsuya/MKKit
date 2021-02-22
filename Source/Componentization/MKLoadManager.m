//
//  MKLoadManager.m
//  MKKit
//
//  Created by zhangsuya on 2020/9/29.
//

#import "MKLoadManager.h"
#import "MKMacro.h"

@implementation MKLoadManager

+ (void)load {
    LogFuncDuration(@"MKLoadManager", execObjectLoad();)
}

@end
