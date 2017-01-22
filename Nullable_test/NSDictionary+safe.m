//
//  NSDictionary+safe.m
//  Nullable_test
//
//  Created by libo on 2017/1/22.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "NSDictionary+safe.h"
#import <objc/runtime.h>
@implementation NSDictionary (safe)

+ (void)load {
    Method originalMethod = class_getClassMethod(self, @selector(dictionaryWithObjects:forKeys:count:));
    Method swizzledMethod = class_getClassMethod(self, @selector(zl_dictionaryWithObjects:forKeys:count:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (instancetype)zl_dictionaryWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt {

    id nObjects[cnt];
    id nKeys[cnt];
    int i = 0, j = 0;
    for (; i < cnt && j < cnt; i++) {
        if (objects[i] && keys[i]) {
            nObjects[j] = objects[i];
            nKeys[j] = keys[i];
            j++;
        }
    }
    return [self zl_dictionaryWithObjects:nObjects forKeys:nKeys count:j];
}

@end
