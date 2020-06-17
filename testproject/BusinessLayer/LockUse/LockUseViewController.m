//
//  LockUseViewController.m
//  testproject
//
//  Created by bolang on 2020/6/17.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "LockUseViewController.h"

@interface LockUseViewController ()

@property (nonatomic,assign)int number;
@property (nonatomic,strong)NSLock *addLock;

@end

@implementation LockUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.number = 0;
    self.addLock = [[NSLock alloc] init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self mutiThreadTest];
    });
    
    // Do any additional setup after loading the view.
}

// 3.看使用信号量能否实现
/**
 按照打印结果，加了信号量，可以阻止数据竞争，且，将所有操作，同步化了，不像前面两个方法，并不会真正加到100
 */
- (void)mutiThreadTest{
    dispatch_semaphore_t t = dispatch_semaphore_create(2);
    dispatch_queue_t customerQueue = dispatch_queue_create("testQueue", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i<100; i++) {
        dispatch_async(customerQueue, ^{
            dispatch_semaphore_wait(t, DISPATCH_TIME_FOREVER);
            NSLog(@"%@",[NSThread currentThread]);
            self.number += 1;
            NSLog(@" -- %d result",self.number);
            dispatch_semaphore_signal(t);
        });
    }
    for (int i = 0; i<100; i++) {
        dispatch_async(customerQueue, ^{
            dispatch_semaphore_wait(t, DISPATCH_TIME_FOREVER);
            NSLog(@"%@",[NSThread currentThread]);
            self.number -= 1;
            NSLog(@" -- %d result",self.number);
            dispatch_semaphore_signal(t);
        });
    }
}

// 2.我们使用@synchronized来进行保护
// 用此方法，没有问题，可以实现数据保护的操作

/**
 @synchronized (obj)会转换成如下代码：
 
 @try {
  objc_sync_enter(obj);
  // do work
 } @finally {
  objc_sync_exit(obj);
 }
 
 底部实现原理是个递归锁 类似NSRecursiveLock
 
 注意：递归锁在被同一线程重复获取时，并不会产生死锁的问题！
 
 */
//- (void)mutiThreadTest{
//    dispatch_queue_t customerQueue = dispatch_queue_create("testQueue", DISPATCH_QUEUE_CONCURRENT);
//    for (int i = 0; i<100; i++) {
//        dispatch_async(customerQueue, ^{
//            @synchronized (self) {
//                NSLog(@"%@",[NSThread currentThread]);
//                self.number += 1;
//                NSLog(@" -- %d result",self.number);
//            }
//
//        });
//    }
//    for (int i = 0; i<100; i++) {
//        dispatch_async(customerQueue, ^{
//            @synchronized (self) {
//                NSLog(@"%@",[NSThread currentThread]);
//                self.number -= 1;
//                NSLog(@" -- %d result",self.number);
//            }
//        });
//    }
//}

/**
 
 */

// 1.我们使用NSLock锁对数据做保护
// 用此方法，没有问题，可以实现数据保护的操作
//- (void)mutiThreadTest{
//    dispatch_queue_t customerQueue = dispatch_queue_create("testQueue", DISPATCH_QUEUE_CONCURRENT);
//    for (int i = 0; i<100; i++) {
//        dispatch_async(customerQueue, ^{
//            [self.addLock lock];
//            NSLog(@"%@",[NSThread currentThread]);
//            self.number += 1;
//            NSLog(@" -- %d result",self.number);
//            [self.addLock unlock];
//        });
//    }
//    for (int i = 0; i<100; i++) {
//        dispatch_async(customerQueue, ^{
//            [self.addLock lock];
//            NSLog(@"%@",[NSThread currentThread]);
//            self.number -= 1;
//            NSLog(@" -- %d result",self.number);
//            [self.addLock unlock];
//        });
//    }
//}


// 此为一份可能造成数据竞争的代码，原因在于，NSLog是存在IO操作，导致线程阻塞，所以产生数据竞争，结果并不一定为0
// 基于此，做出很多延伸操作
//- (void)mutiThreadTest{
//    dispatch_queue_t customerQueue = dispatch_queue_create("testQueue", DISPATCH_QUEUE_CONCURRENT);
//    for (int i = 0; i<100; i++) {
//        dispatch_async(customerQueue, ^{
//            NSLog(@"%@",[NSThread currentThread]);
//            self.number += 1;
//            NSLog(@" -- %d result",self.number);
//        });
//    }
//    for (int i = 0; i<100; i++) {
//        dispatch_async(customerQueue, ^{
//            NSLog(@"%@",[NSThread currentThread]);
//            self.number -= 1;
//            NSLog(@" -- %d result",self.number);
//        });
//    }
//
//}

@end
