//
//  BlockReturnCircleObject.h
//  testproject
//
//  Created by bolang on 2020/6/9.
//  Copyright © 2020 bolang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlockReturnCircleObject : NSObject

@property (nonatomic,copy)void (^objectBlock)(void);

@end

NS_ASSUME_NONNULL_END
