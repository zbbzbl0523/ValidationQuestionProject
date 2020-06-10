//
//  DelayCodeController.m
//  testproject
//
//  Created by bolang on 2020/6/10.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "DelayCodeController.h"

@interface DelayCodeController ()

@end

@implementation DelayCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self NSTimerTest];
    // Do any additional setup after loading the view.
}

// 统一打印方法
- (void)printSometing{
    NSLog(@" *** %@",[NSThread currentThread]);
    NSLog(@"delay print here");
}


/// 使用nstiemr 内嵌一个dispatch_after
- (void)NSTimerTest{
    NSTimeInterval time = 2.0;
    
    NSLog(@"before start delay");
    
    //    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(printSometing) userInfo:nil repeats:YES];
    //    NSTimer *timer = [NSTimer timerWithTimeInterval:time target:self selector:@selector(printSometing) userInfo:nil repeats:YES];
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    NSLog(@"after start delay");
    
    
    //    dispatch_time_t dispatchTime = dispatch_time(DISPATCH_TIME_NOW, 11.0*NSEC_PER_SEC);
    //    dispatch_after(dispatchTime, dispatch_get_main_queue(), ^{
    //        [timer invalidate];
    //    });
    //
    //    dispatch_time_t stopTime = dispatch_time(DISPATCH_TIME_NOW, 3.0*NSEC_PER_SEC);
    //    dispatch_after(stopTime, dispatch_get_main_queue(), ^{
    //        [timer setFireDate:[NSDate distantFuture]]; // 定时器暂停
    //    });
    //
    //    dispatch_time_t reopenTime = dispatch_time(DISPATCH_TIME_NOW, 9.0*NSEC_PER_SEC);
    //    dispatch_after(reopenTime, dispatch_get_main_queue(), ^{
    //        [timer setFireDate:[NSDate distantPast]]; // 定时器重开启
    //    });
    
    ///
    /// scheduledTimerWithTimeInterval: target: selector: userInfo: repeats:
    /// 上述方法将会自动创建一个timer加入到当前的runloop中，并自动执行
    ///
    ///
    /// timerWithTimeInterval: target: selector: userInfo: repeats:
    /// 此方法就不自动执行了
    /// 需要通过runloop 添加到指定runloop中，才会被执行
    ///
    
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(otherThreadFunc) object:@"objectMethodThread"];
    //手动启动线程
    [thread start];
    
}

- (void)otherThreadFunc{
    //    /// 经过验证，dispatch_after 是不需要runloop就可以了的
    //    NSLog(@" --- %@",[NSThread currentThread]);
    //    dispatch_queue_t cu = dispatch_queue_create("con", DISPATCH_QUEUE_CONCURRENT);
    //    for (int i = 0 ; i<10; i++) {
    //        dispatch_sync(cu, ^{
    //            dispatch_time_t dispatchTime = dispatch_time(DISPATCH_TIME_NOW, 5.0*NSEC_PER_SEC);
    //            dispatch_after(dispatchTime, cu, ^{
    //                NSLog(@" --- %@",[NSThread currentThread]);
    //                NSLog(@"希望在子线程执行，看看没有runloop会不会跑");
    //            });
    //        });
    //    }
    
    //    /// 如此，就不会打印了，因为timer没有被添加到一个runloop中
    NSTimeInterval time = 2.0;
    //    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(printSometing) userInfo:nil repeats:YES];
    //    [NSRunLoop currentRunLoop]
    
    NSLog(@" --- %@",[NSThread currentThread]);
    
    
    /// 在初始化之前，我们给此runloop创建
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [loop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(printSometing) userInfo:nil repeats:YES];
    [loop run];
    
    
}



///  NSObject方法
- (void)RunloopTest{
    
    /// performSelector: withObject: afterDelay:
    /// 此延时操作方法是存在于  runloop  中的。所以，必然与runloop有关
    ///
    
    NSTimeInterval time = 2.0;
    NSLog(@"before start delay");
    [self performSelector:@selector(printSometing) withObject:nil afterDelay:time];
    NSLog(@"after start delay");
}

- (void)dealloc
{
    NSLog(@"delay code page dealloc");
}

@end
