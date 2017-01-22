//
//  NSNull+safe.m
//  Nullable_test
//
//  Created by libo on 2017/1/22.
//  Copyright © 2017年 蝉鸣. All rights reserved.
//

#import "NSNull+safe.h"
#import <objc/runtime.h>
@implementation NSNull (safe)

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {

    NSMethodSignature *signature = [super methodSignatureForSelector:sel];
    if (!signature) {
        signature = [NSMethodSignature signatureWithObjCTypes:@encode(void)];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {

}

@end
