//
//  BlockReturnCircleController.m
//  testproject
//
//  Created by bolang on 2020/6/9.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "BlockReturnCircleController.h"
#import "BlockReturnCircleObject.h"

@interface BlockReturnCircleController ()

@end

@implementation BlockReturnCircleController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self networkText];
    // Do any additional setup after loading the view.
}

/**
 用于验证 https://www.jianshu.com/p/3b53c5734493
 此链接中的监听循环引用问题
 */
- (void)networkText{
//    __weak typeof(self) weakself = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        self.view.backgroundColor = [UIColor systemBlueColor];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        self.view.backgroundColor = [UIColor systemBlueColor];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(objectTest) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

///  此方法用于验证，在block内写__strong typeof(self) 会不会引起循环引用
- (void)objectTest{
    BlockReturnCircleObject *object = [[BlockReturnCircleObject alloc] init];
    object.objectBlock();
}

- (void)dealloc
{
    NSLog(@"BlockReturnCircleController dealloc");
}

@end
