//
//  DeallocObject+DeallocBlock.h
//  testproject
//
//  Created by bolang on 2020/6/5.
//  Copyright © 2020 bolang. All rights reserved.
//
#import "DeallocObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeallocObject (DeallocBlock)

- (void)deallocBlock_AddDeallocBlock:(void (^)(void))block;

@end

NS_ASSUME_NONNULL_END
