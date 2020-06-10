//
//  ObjectDeallocBlockController.m
//  testproject
//
//  Created by bolang on 2020/6/5.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "ObjectDeallocBlockController.h"
#import "DeallocObject.h"
#import "DeallocObject+DeallocBlock.h"

@interface ObjectDeallocBlockController ()

@end

@implementation ObjectDeallocBlockController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    DeallocObject *object = [DeallocObject new];
    [object deallocBlock_AddDeallocBlock:^{
        NSLog(@"被移除了！");
    }];
//    object.deallocBlock = ^{
//        NSLog(@"被移除了！");
//    };
    
    // Do any additional setup after loading the view.
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
