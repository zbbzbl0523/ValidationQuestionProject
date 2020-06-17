//
//  BLTransAnimation.h
//  testproject
//
//  Created by bolang on 2020/6/17.
//  Copyright © 2020 bolang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TransitionType) {
    TransitionTypePresent = 0, //管理present动画
    TransitionTypeDissmis,
};

@interface BLTransAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic) TransitionType transitionType;

@end

NS_ASSUME_NONNULL_END
