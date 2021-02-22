//
//  MKMachOMacro.h
//  MKKit
//
//  Created by zhangsuya on 2020/9/29.
//

#ifndef MKMachOMacro_h
#define MKMachOMacro_h

#define _MKMacroDataName "__DATA"

#define _MKLoadFuncDefine(_KEY, _SECTIONNAME) \
typedef void (*MKLoadTemplate)(void); \
static void _mk##_KEY##Load(void); \
static MKLoadTemplate _varmg##_KEY##Load __attribute((used, section(_MKMacroDataName "," _SECTIONNAME))) = _mg##_KEY##Load; \
static void _mk##_KEY##Load(void)

typedef void (*_MKLoadTemplate)(void);
//---MGLoad------------
struct _MK_Load_Priority_Func {
    int priority;
    _MKLoadTemplate func;
};
#define _MKObjectLoadMacroSectionName "__mkobjectload"
#define _MKLoadFunc(_int_priority, _id_) \
static void _mkobjectLoad##_id_(void); \
__attribute((used, section(_MKMacroDataName "," _MKObjectLoadMacroSectionName))) \
static const struct _MK_Load_Priority_Func var_mkobjLoad##_id_ = (struct _MK_Load_Priority_Func){_int_priority, _mkobjectLoad##_id_}; \
static void _mkobjectLoad##_id_(void)

#endif /* MKMachOMacro_h */
