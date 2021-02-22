//
//  MKMachOManager.m
//  MKKit
//
//  Created by zhangsuya on 2020/9/27.
//
#import "MKMachOManager.h"
#include <mach-o/getsect.h>
#include <dlfcn.h>
#import "MKMacro.h"
#import "MKMachOMacro.h"

#ifndef __LP64__
#define _mk_mach_header mach_header
#define _mk_section section
typedef uint32_t _mk_uint;
#define mk_getsectbynamefromheader getsectbynamefromheader
#else
#define _mk_mach_header mach_header_64
#define _mk_section section_64
typedef uint64_t _mk_uint;
#define mk_getsectbynamefromheader getsectbynamefromheader_64
#endif

const struct _mk_mach_header *machHeader = NULL;
@implementation MKMachOManager

static uintptr_t *getMemory(NSString *sectionName, unsigned long *size) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        static NSString *configuration = @"";
        Dl_info info;
        dladdr((__bridge const void *)(configuration), &info);
        machHeader = (struct _mk_mach_header*)info.dli_fbase;
    });
    return (uintptr_t*)getsectiondata(machHeader, _MKMacroDataName, [sectionName UTF8String], size);
}

void execObjectLoad(void) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        char *sectionName = _MKObjectLoadMacroSectionName;
        Dl_info info;
        dladdr((const void *)&execObjectLoad, &info);
        const _mk_uint mach_header = (_mk_uint)info.dli_fbase;
        const struct _mk_section *section = mk_getsectbynamefromheader((void *)mach_header, _MKMacroDataName, sectionName);
        if (section == NULL) return;
        int addrOffset = sizeof(struct _MK_Load_Priority_Func);
        unsigned long long counter = section->size / addrOffset;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:counter];
        _MKLoadTemplate funcs[counter];
        for (int i = 0; i < counter; i++) {
            _mk_uint addr = section->offset + addrOffset * i + mach_header;
            struct _MK_Load_Priority_Func template = *(struct _MK_Load_Priority_Func *)(addr);
            int level = template.priority;
            [arr addObject:@{@"level":@(level),@"index":@(i)}];
            funcs[i] = template.func;
        }
        [arr sortUsingComparator:^NSComparisonResult(NSDictionary * _Nonnull obj1, NSDictionary *  _Nonnull obj2) {
            return [obj1[@"level"] integerValue] < [obj2[@"level"] integerValue];
        }];
        for (NSDictionary *dict in arr) {
            NSInteger index = [dict[@"index"] integerValue];
            _MKLoadTemplate template = funcs[index];
            if (template) {
                template();
            }
        }
    });
}

__unused static void execLoad(NSString *sectionName) {
    if (sectionName.length) {
        unsigned long size = 0;
        uintptr_t *memory = getMemory(sectionName, &size);
        NSUInteger counter = size/sizeof(void*);
        if (counter > 0) {
            for(int idx = 0; idx < counter; ++idx){
                _MKLoadTemplate template = (_MKLoadTemplate)memory[idx];
                if (template) {
                    template();
                }
            }
        }
    }
}


@end
