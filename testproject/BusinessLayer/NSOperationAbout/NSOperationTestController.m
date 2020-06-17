//
//  NSOperationTestController.m
//  testproject
//
//  Created by bolang on 2020/6/11.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "NSOperationTestController.h"

@interface NSOperationTestController ()

@end

@implementation NSOperationTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSLog(@"0");
    // 开始异步请求操作（部分代码略）
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"1");
        // This function returns non-zero if a thread is woken. Otherwise, zero is returned.
        // 2.在网络请求结束后发送通知信号
        dispatch_semaphore_signal(semaphore);
    });
    // Returns zero on success, or non-zero if the timeout occurred.
    // 3.发送等待信号
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"2");
    // Do any additional setup after loading the view.
}

- (void)NSOperationTest{
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
//        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作 此耗时操作还是同步的
        NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        
        NSLog(@"111");
        dispatch_semaphore_t single = dispatch_semaphore_create(0);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (int i = 0; i<100000000; i++) {
                @autoreleasepool {
                    NSString *ad = [NSString new];
                }
            }
            NSLog(@"333");
            NSLog(@"3---%@", [NSThread currentThread]);
            dispatch_semaphore_signal(single);
        });
        dispatch_semaphore_wait(single, DISPATCH_TIME_FOREVER);
        NSLog(@"222");
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
//        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"  aaa  ---%@", [NSThread currentThread]); // 打印当前线程
    }];
    
    // 3.添加依赖
    [op2 addDependency:op1]; // 让op2 依赖于 op1，则先执行op1，在执行op2
    
    // 4.添加操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
}

@end
