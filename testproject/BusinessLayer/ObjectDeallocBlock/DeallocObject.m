//
//  DeallocObject.m
//  testproject
//
//  Created by bolang on 2020/6/5.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "DeallocObject.h"

@implementation DeallocObject

- (void)dealloc
{
    NSLog(@"123");
    if (self.deallocBlock) {
        self.deallocBlock();
    }
}

@end
