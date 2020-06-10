//
//  BlockReturnCircleObject.m
//  testproject
//
//  Created by bolang on 2020/6/9.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "BlockReturnCircleObject.h"

@implementation BlockReturnCircleObject

- (void)dealloc
{
    NSLog(@"object 被回收了");
}

- (instancetype)init{
    /// 此方法用于验证，在block内写__strong typeof(self) 会不会引起循环引用
    self = [super init];
    if (self) {
        __weak typeof(self) weakself = self;
        self.objectBlock = ^{
            __strong typeof(weakself) strongself = weakself;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [NSThread sleepForTimeInterval:1];
                NSLog(@" 打印自身  --  %@",strongself);
            });
        };
    }
    return self;
}

@end
