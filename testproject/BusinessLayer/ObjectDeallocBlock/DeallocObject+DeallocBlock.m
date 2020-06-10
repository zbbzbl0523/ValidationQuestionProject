//
//  DeallocObject+DeallocBlock.m
//  testproject
//
//  Created by bolang on 2020/6/5.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "DeallocObject+DeallocBlock.h"
#import <objc/runtime.h>

/* 以下为定义的寄生对象 */
@interface Parasite : NSObject
@property (nonatomic, copy) void(^deallocBlock)(void);
@end
@implementation Parasite

- (void)dealloc {
    if (self.deallocBlock) {
        self.deallocBlock();
    }
}
@end

@implementation DeallocObject (DeallocBlock)

- (void)deallocBlock_AddDeallocBlock:(void(^)(void))block {
    @synchronized (self) {
        static NSString *kAssociatedKey = nil;
        NSMutableArray *parasiteList = objc_getAssociatedObject(self, &kAssociatedKey);
        if (!parasiteList) {
            parasiteList = [NSMutableArray new];
            objc_setAssociatedObject(self, &kAssociatedKey, parasiteList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        Parasite *parasite = [Parasite new];
        parasite.deallocBlock = block;
        [parasiteList addObject: parasite];
    }
}

@end
