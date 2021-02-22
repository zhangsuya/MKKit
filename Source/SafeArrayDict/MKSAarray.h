//
//  MKSAarray.h
//  MKKit
//
//  Created by zhangsuya on 2020/9/27.
//

#import <Foundation/Foundation.h>


// 安全NSArray字面量
// NSArray *arr1 = @[@"1", @"2", nil, @"3"]; // crash
// NSArray *arr = MKArr(@"1", @"2", nil, @"3");
// NSLog(@"%@", arr); @[@"1", @"2", @"3"];

#define _tyuiopMKArr20(a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19) \
arrWithItem(20,a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19)
#define _tyuiopMKArr19(a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18) \
arrWithItem(19,a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,nil)
#define _tyuiopMKArr18(a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17) \
arrWithItem(18,a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,nil,nil)
#define _tyuiopMKArr17(a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16) \
arrWithItem(17,a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,nil,nil,nil)
#define _tyuiopMKArr16(a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15) \
arrWithItem(16,a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,nil,nil,nil,nil)
#define _tyuiopMKArr15(a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14) \
arrWithItem(15,a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,nil,nil,nil,nil,nil)
#define _tyuiopMKArr14(a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13) \
arrWithItem(14,a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,nil,nil,nil,nil,nil,nil)
#define _tyuiopMKArr13(a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12) \
arrWithItem(13,a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,nil,nil,nil,nil,nil,nil,nil)
#define _tyuiopMKArr12(a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11) \
arrWithItem(12,a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,nil,nil,nil,nil,nil,nil,nil,nil)
#define _tyuiopMKArr11(a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10) \
arrWithItem(11,a,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,nil,nil,nil,nil,nil,nil,nil,nil,nil)
#define _tyuiopMKArr10(a,a1,a2,a3,a4,a5,a6,a7,a8,a9) \
arrWithItem(10,a,a1,a2,a3,a4,a5,a6,a7,a8,a9,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil)
#define _tyuiopMKArr9(a,a1,a2,a3,a4,a5,a6,a7,a8) \
arrWithItem(9,a,a1,a2,a3,a4,a5,a6,a7,a8,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil)
#define _tyuiopMKArr8(a,a1,a2,a3,a4,a5,a6,a7) \
arrWithItem(8,a,a1,a2,a3,a4,a5,a6,a7,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil)
#define _tyuiopMKArr7(a,a1,a2,a3,a4,a5,a6) \
arrWithItem(7,a,a1,a2,a3,a4,a5,a6,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil)
#define _tyuiopMKArr6(a,a1,a2,a3,a4,a5) \
arrWithItem(6,a,a1,a2,a3,a4,a5,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil)
#define _tyuiopMKArr5(a,a1,a2,a3,a4) \
arrWithItem(5,a,a1,a2,a3,a4,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil)
#define _tyuiopMKArr4(a,a1,a2,a3) \
arrWithItem(4,a,a1,a2,a3,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil)
#define _tyuiopMKArr3(a,a1,a2) \
arrWithItem(3,a,a1,a2,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil)
#define _tyuiopMKArr2(a,a1) \
arrWithItem(2,a,a1,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil)
#define _tyuiopMKArr1(a) \
arrWithItem(1,a,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil)

NSMutableArray *arrWithItem(int count, id obj1, id obj2,id obj3,id obj4,id obj5,id obj6,id obj7,id obj8,id obj9,id obj10,id obj11,id obj12,id obj13,id obj14,id obj15,id obj16,id obj17,id obj18,id obj19,id obj20);

#define _tyuiopMKArr(_1,_2,_3,_4,_5,_6,_7,_8,_9,_10,_11,_12,_13,_14,_15,_16,_17,_18,_19,_20,NAME,...) NAME
#define MKArr(item...) _tyuiopMKArr(item,_tyuiopMKArr20,_tyuiopMKArr19,_tyuiopMKArr18,_tyuiopMKArr17,_tyuiopMKArr16,_tyuiopMKArr15,_tyuiopMKArr14,_tyuiopMKArr13,_tyuiopMKArr12,_tyuiopMKArr11,_tyuiopMKArr10,_tyuiopMKArr9,_tyuiopMKArr8,_tyuiopMKArr7,_tyuiopMKArr6,_tyuiopMKArr5,_tyuiopMKArr4,_tyuiopMKArr3,_tyuiopMKArr2,_tyuiopMKArr1)(item)


