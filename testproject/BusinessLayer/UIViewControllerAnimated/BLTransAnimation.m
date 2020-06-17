//
//  BLTransAnimation.m
//  testproject
//
//  Created by bolang on 2020/6/17.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "BLTransAnimation.h"


@interface BLTransAnimation()<CAAnimationDelegate>

@property (nonatomic) id<UIViewControllerContextTransitioning> transitionContext;


@end

@implementation BLTransAnimation

/// 返回转场动效的动画时间
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    /// 转场动画的效果，最后都是需要自己实现的。这里就由参数控制，判断是什么类型的转场，从而做不同动效
    if (self.transitionType == TransitionTypePresent) {
        [self presentAnimation:transitionContext];
    } else if (self.transitionType == TransitionTypeDissmis) {
        [self dismissAnimation:transitionContext];
    }
}

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:tempView];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    CGRect rect = CGRectMake(50, [UIScreen mainScreen].bounds.size.height - 50, 2, 2);
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:sqrt(screenHeight * screenHeight + screenWidth * screenWidth)  startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    tempView.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    
    animation.fromValue = (__bridge id)(startPath.CGPath);
    animation.toValue = (__bridge id)((endPath.CGPath));
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:@"PointNextPath"];
    self.transitionContext = transitionContext;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    UIView *containerView = [self.transitionContext containerView];
    [containerView.subviews.lastObject removeFromSuperview];
    [self.transitionContext completeTransition:YES];
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    
    CGRect rect = CGRectMake(50, [UIScreen mainScreen].bounds.size.height - 50, 2, 2);
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:sqrt(screenHeight * screenHeight + screenWidth * screenWidth)  startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    tempView.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    
    animation.fromValue = (__bridge id)(startPath.CGPath);
    animation.toValue = (__bridge id)((endPath.CGPath));
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:animation forKey:@"PointNextPath"];
    self.transitionContext = transitionContext;
}


// 以下是一个基础的使用
//#pragma mark - UIViewControllerAnimatedTransitioning 转场动画遵循的协议
///// 具体转场动画做的动画内容
//- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
//    // 获取fromVc和toVc
//    // 当前vc
//    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    // 下一个vc
//    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//
//    UIView *fromView = [[UIView alloc] init];;
//    UIView *toView = [[UIView alloc] init];
//
//    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
//        // fromVc 的view
//        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//        // toVc的view
//        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//    } else {
//        // fromVc 的view
//        fromView = fromVc.view;
//        // toVc的view
//        toView =toVc.view;
//    }
//
//    CGFloat x = [UIScreen mainScreen].bounds.size.width;
//
//    // 转场环境
//    UIView *containView = [transitionContext containerView];
//    toView.frame = CGRectMake(-x, 0, containView.frame.size.width, containView.frame.size.height);
//
//    [containView addSubview:fromView];
//    [containView addSubview:toView];
//
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        fromView.transform = CGAffineTransformTranslate(fromView.transform, x, 0);
//        toView.transform = CGAffineTransformTranslate(toView.transform, x, 0);
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:YES];
//    }];
//}
//
///// 转场动画执行时间
//- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
//    return 0.5;
//}

@end
