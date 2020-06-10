//
//  ThreadCommunicationController.m
//  testproject
//
//  Created by bolang on 2020/6/8.
//  Copyright © 2020 bolang. All rights reserved.
//

/*
 线程间的通信
 1. GCD方式
 */

#import "ThreadCommunicationController.h"

@interface ThreadCommunicationController ()

@end

@implementation ThreadCommunicationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /// 测试GCD的线程通信
    [self GCDWay];
    
    // Do any additional setup after loading the view.
}

- (void)GCDWay{
    /*
     
     首先一个知识点： 在iOS中，在主队列中任务，必定在主线程中运行
     
     */
    
    // 自定义一个并发队列
    dispatch_queue_t custom_queue = dispatch_queue_create("concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i=0; i<10; i++) {
        dispatch_async(custom_queue, ^{
            NSLog(@"## 并行队列 %d -- %@ ##",i, [NSThread currentThread]);
            //数据更新完毕回调主线程 线程之间的通信
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"### 我在主线程 %d 通信 -- %@ ##", i , [NSThread currentThread]);
            });
        });
    }
    
    //
    
}


@end
