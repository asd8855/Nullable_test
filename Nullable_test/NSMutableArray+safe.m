//
//  NSMutableArray+safe.m
//  Nullable_test
//
//  Created by libo on 2017/1/22.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "NSMutableArray+safe.h"
#import <objc/runtime.h>
@implementation NSMutableArray (safe)
+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class arrayClass = NSClassFromString(@"__NSArrayM");
        Method originalMethod1 = class_getInstanceMethod(arrayClass, @selector(insertObject:atIndex:));
        Method swizzledMethod1 = class_getInstanceMethod(arrayClass, @selector(zl_insertObject:atIndex:));
        method_exchangeImplementations(originalMethod1, swizzledMethod1);
        
        Method originalMethod2 = class_getInstanceMethod(arrayClass, @selector(setObject:atIndex:));
        Method swizzledMethod2 = class_getInstanceMethod(arrayClass, @selector(zl_setObject:atIndex:));
        method_exchangeImplementations(originalMethod2, swizzledMethod2);
        
        Method originalMethod3 = class_getInstanceMethod(arrayClass, @selector(setObject:atIndexedSubscript:));
        Method swizzledMethod3 = class_getInstanceMethod(arrayClass, @selector(zl_setObject:atIndexedSubscript:));
        method_exchangeImplementations(originalMethod3, swizzledMethod3);
    });

}

- (void)zl_insertObject:(id)anObject atIndex:(NSUInteger)index {

    if (!anObject)
        return;
    [self zl_insertObject:anObject atIndex:index];
}

- (void)zl_setObject:(id)obj atIndex:(NSUInteger)idx {

    if (!obj)
        return;
    [self zl_setObject:obj atIndex:idx];
}

- (void)zl_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if (!obj)
        return;
    [self zl_setObject:obj atIndexedSubscript:idx];
}

@end
