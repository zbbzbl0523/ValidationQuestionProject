//
//  DelayCodeController.m
//  testproject
//
//  Created by bolang on 2020/6/10.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "DelayCodeController.h"

@interface DelayCodeController ()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation DelayCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self dispatchTimerTest];
    // Do any additional setup after loading the view.
}

// 统一打印方法
- (void)printSometing{
    NSLog(@" *** %@",[NSThread currentThread]);
    NSLog(@"delay print here");
}

#pragma  mark -  创建一个不需要手动添加的定时器
- (void)nstimerDonotAdd{
    NSTimeInterval time = 2.0;
    NSLog(@"before start delay");
    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(printSometing) userInfo:nil repeats:YES];
    NSLog(@"after start delay");
}


#pragma mark - 创建一个需要手动添加到runloop的定时器
- (void)nstimerNeedAddToRunloop{
    NSTimeInterval time = 2.0;
    
    NSLog(@"before start delay");
    NSTimer *timer = [NSTimer timerWithTimeInterval:time target:self selector:@selector(printSometing) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    NSLog(@"after start delay");
}

///
/// scheduledTimerWithTimeInterval: target: selector: userInfo: repeats:
/// 上述方法将会自动创建一个timer加入到当前的runloop中，并自动执行
///
///
/// timerWithTimeInterval: target: selector: userInfo: repeats:
/// 此方法就不自动执行了
/// 需要通过runloop 添加到指定runloop中，才会被执行
///

#pragma mark - timer的暂停与恢复
- (void)NSTimerTestStopAndRestart{
    NSTimeInterval time = 2.0;

    NSLog(@"before start delay");
    NSTimer *timer = [NSTimer timerWithTimeInterval:time target:self selector:@selector(printSometing) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    NSLog(@"after start delay");
    
    
    dispatch_time_t dispatchTime = dispatch_time(DISPATCH_TIME_NOW, 11.0*NSEC_PER_SEC);
    dispatch_after(dispatchTime, dispatch_get_main_queue(), ^{
        [timer invalidate];
    });
    
    dispatch_time_t stopTime = dispatch_time(DISPATCH_TIME_NOW, 3.0*NSEC_PER_SEC);
    dispatch_after(stopTime, dispatch_get_main_queue(), ^{
        [timer setFireDate:[NSDate distantFuture]]; // 定时器暂停
    });
    
    dispatch_time_t reopenTime = dispatch_time(DISPATCH_TIME_NOW, 9.0*NSEC_PER_SEC);
    dispatch_after(reopenTime, dispatch_get_main_queue(), ^{
        [timer setFireDate:[NSDate distantPast]]; // 定时器重开启
    });
}





#pragma mark - dispatch_after 是否需要runloop
- (void)dispatchTimerTest{
    /// 创建一个新线程，此线程不给runloop （[NSRunLoop currentRunLoop]即可创建其对应runloop）看看dispatch_after能不能运行
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(otherThreadFunc) object:@"objectMethodThread"];
    //手动启动线程
    [thread start];
    
}

- (void)otherThreadFunc{
    /// 经过验证，dispatch_after 是不需要runloop就可以了的
    dispatch_queue_t concurrentQueue = dispatch_queue_create("con", DISPATCH_QUEUE_CONCURRENT);
//    for (int i = 0 ; i<10; i++) {
//        dispatch_sync(concurrentQueue, ^{
//            dispatch_time_t dispatchTime = dispatch_time(DISPATCH_TIME_NOW, 5.0*NSEC_PER_SEC);
//            dispatch_after(dispatchTime, concurrentQueue, ^{
//                NSLog(@" --- %@",[NSThread currentThread]);
//                NSLog(@"希望在子线程执行，看看没有runloop会不会跑");
//            });
//        });
//    }
    // 以上方法为一次性的延时，执行完结束了
    
    
    // GCD也可以创建一个timer,重复执行的
    __weak typeof(self)weakSelf = self;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,concurrentQueue);
    dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, (1.0 * NSEC_PER_SEC)), (2.0 * NSEC_PER_SEC), 0);
    dispatch_source_set_event_handler(self.timer, ^{
        [weakSelf printSometing];
    });
    dispatch_resume(self.timer);
    /// 注意一个问题，此方法的timer，会造成循环引用，因为timer需要由自己持有，否则创建完就会立马被销毁，然后无法开启。
    /// @property (nonatomic, strong) dispatch_source_t timer;  添加此代码
    
    
    /// 作为对比验证，验证nstimer是依赖于runloop的
    //    /// 如此，就不会打印了，因为timer没有被添加到一个runloop中
//    NSTimeInterval time = 2.0;
//
//    /// 在初始化之前，我们给此runloop创建
//    NSRunLoop *loop = [NSRunLoop currentRunLoop];
//    /// 然后打印看看
//    NSLog(@" --- %@",[NSThread currentThread]);
//    /// 添加nstimer
//    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(printSometing) userInfo:nil repeats:YES];
//    [loop run];
//    [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(printSometing) userInfo:nil repeats:YES];
    
    
    // 问题？！
    // 为什么117执行完 loop run后，118开始的代码，不执行了？！
    // 需要注意执行顺序
    
    //    此方法是为了让runloop不退出，保活线程
    //    [loop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
    
}



#pragma mark - NSObject方法
- (void)RunloopTest{
    
    /// performSelector: withObject: afterDelay:
    /// 此延时操作方法是存在于  runloop  中的。所以，必然与runloop有关
    ///
    
    NSTimeInterval time = 2.0;
    NSLog(@"before start delay");
    [self performSelector:@selector(printSometing) withObject:nil afterDelay:time];
    NSLog(@"after start delay");
}


#pragma mark - dealloc 用于测试vc是否被持有而不被释放，造成内存泄漏
- (void)dealloc
{
    NSLog(@"delay code page dealloc");
}

@end
