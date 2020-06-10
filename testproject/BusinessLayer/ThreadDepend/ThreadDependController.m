//
//  ThreadDependController.m
//  testproject
//
//  Created by bolang on 2020/6/3.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "ThreadDependController.h"

@interface ThreadDependController ()

@property (nonatomic,strong)NSString *taskA;
@property (nonatomic,strong)NSString *taskB;

@end

@implementation ThreadDependController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)test{
    
    self.taskA = @"A没完成";
    self.taskB = @"B没完成";
    //1.创建信号量,组队列
    NSLog(@"1-- %@",[NSThread currentThread]);//1
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    
    //A请求
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"A group 1-- %@",[NSThread currentThread]);//3
        //任务放入子线程模拟异步请求
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"A group 子线程-- %@",[NSThread currentThread]);//5
            self.taskA = @"A完成了";
            dispatch_semaphore_signal(semaphore);
        });
        //让信号量等待
        NSLog(@"A group 2-- %@",[NSThread currentThread]);//3
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    //B请求
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"B group 1 -- %@",[NSThread currentThread]);//4
        //任务放入子线程
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"B group 子线程-- %@",[NSThread currentThread]);//6
            self.taskB = @"B完成了";
            dispatch_semaphore_signal(semaphore);
        });
        //让信号量等待
        NSLog(@"B group 2-- %@",[NSThread currentThread]);//4
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    
    //C任务
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"%@ --- %@",self.taskA,self.taskB);
    });
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
