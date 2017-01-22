//
//  NSMutableDictionary+safe.m
//  Nullable_test
//
//  Created by libo on 2017/1/22.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "NSMutableDictionary+safe.h"
#import <objc/runtime.h>
@implementation NSMutableDictionary (safe)

+ (void)load {
    Class dictClass = NSClassFromString(@"__NSDictionaryM");
    Method originalMethod = class_getInstanceMethod(dictClass, @selector(setObject:forKey:));
    Method swizzledMethod = class_getInstanceMethod(dictClass, @selector(zl_setObject:forKey:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)zl_setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if (!anObject)
        return;
    [self zl_setObject:anObject forKey:aKey];
    
}

@end
