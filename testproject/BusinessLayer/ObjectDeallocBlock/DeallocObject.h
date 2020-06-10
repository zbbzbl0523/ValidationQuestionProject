//
//  DeallocObject.h
//  testproject
//
//  Created by bolang on 2020/6/5.
//  Copyright © 2020 bolang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeallocObject : NSObject

@property (nonatomic, copy) void(^deallocBlock)(void);

@property (nonatomic,copy)NSString *abc;

@end

NS_ASSUME_NONNULL_END
