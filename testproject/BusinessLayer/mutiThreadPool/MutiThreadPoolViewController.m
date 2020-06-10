//
//  MutiThreadPoolViewController.m
//  testproject
//
//  Created by bolang on 2020/5/26.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "MutiThreadPoolViewController.h"

@interface MutiThreadPoolViewController ()

@end

@implementation MutiThreadPoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self text];
    // Do any additional setup after loading the view.
}

- (void)text{
    /// 创建一个并行队列
    dispatch_queue_t workConcurrentQueue = dispatch_queue_create("cccc", DISPATCH_QUEUE_CONCURRENT);
    
    /// 创建一个串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("sss", nil);
    
    /// 创建一个并行量为3的信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(3);
    
    for (int i = 0 ; i < 10; i++) {
        dispatch_async(serialQueue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_async(workConcurrentQueue, ^{
                NSLog(@"thread-info: %@ 开始执行任务%d",[NSThread currentThread],i);
                sleep(2);
                NSLog(@"thread-info: %@ 结束执行任务%d",[NSThread currentThread],i);
                dispatch_semaphore_signal(semaphore);
            });
        });
    }
    
}

@end
