//
//  MKSAarray.m
//  MKKit
//
//  Created by zhangsuya on 2020/9/27.
//

#import "MKSAarray.h"

// 安全NSArray字面量

// NSArray *arr1 = @[@"1", @"2", nil, @"3"]; // crash

// NSArray *arr = MKArr(@"1", @"2", nil, @"3");
// NSLog(@"%@", arr); @[@"1", @"2", @"3"];



NSMutableArray *arrWithItem(int count, id obj1, id obj2,id obj3,id obj4,id obj5,id obj6,id obj7,id obj8,id obj9,id obj10,id obj11,id obj12,id obj13,id obj14,id obj15,id obj16,id obj17,id obj18,id obj19,id obj20) {
    NSMutableArray *arr = [NSMutableArray array];
#define _AddIfNeed(obj)  if(obj){ [arr addObject:obj];}
    _AddIfNeed(obj1);
    _AddIfNeed(obj2);
    _AddIfNeed(obj3);
    _AddIfNeed(obj4);
    _AddIfNeed(obj5);
    _AddIfNeed(obj6);
    _AddIfNeed(obj7);
    _AddIfNeed(obj8);
    _AddIfNeed(obj9);
    _AddIfNeed(obj10);
    _AddIfNeed(obj11);
    _AddIfNeed(obj12);
    _AddIfNeed(obj13);
    _AddIfNeed(obj14);
    _AddIfNeed(obj15);
    _AddIfNeed(obj16);
    _AddIfNeed(obj17);
    _AddIfNeed(obj18);
    _AddIfNeed(obj19);
    _AddIfNeed(obj20);
    if (arr.count != count) {
        NSLog(@"MKArray : 数据中不能插入nil");
    }
    return arr;
}


