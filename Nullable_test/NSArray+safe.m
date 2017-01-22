//
//  NSArray+safe.m
//  Nullable_test
//
//  Created by libo on 2017/1/22.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "NSArray+safe.h"
#import <objc/runtime.h>
@implementation NSArray (safe)
+ (void)load {
    Method originalMethod = class_getClassMethod(self, @selector(arrayWithObjects:count:));
    Method swizzledMethod = class_getClassMethod(self, @selector(zl_arrayWithObjects:count:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (instancetype)zl_arrayWithObjects:(const id [])objects count:(NSUInteger)cnt {

    id nObjects[cnt];
    int i = 0,j = 0;
    for (; i < cnt && j < cnt; i++) {
        if (objects[i]) {
            nObjects[j] = objects[i];
            j++;
        }
    }
    return [self zl_arrayWithObjects:objects count:j];
}


@end
