//
//  KindOrMemberAboutController.m
//  testproject
//
//  Created by bolang on 2020/6/4.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "KindOrMemberAboutController.h"
#import "FOOObject.h"

@interface KindOrMemberAboutController ()

@end

@implementation KindOrMemberAboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self textFunc];
    // Do any additional setup after loading the view.
}

- (void)textFunc{
    NSLog(@"%d",[[NSObject class] isKindOfClass:[NSObject class]]);
    NSLog(@"%d",[[NSObject class] isMemberOfClass:[NSObject class]]);
    
    
    NSObject *object = [NSObject new];
    NSLog(@"----- %d",[[object class] isKindOfClass:[NSObject class]]);
    
    FOOObject *foo = [FOOObject new];
    NSLog(@"----- %d",[[foo class] isKindOfClass:[FOOObject class]]);
    NSLog(@"----- %d",[[foo class] isMemberOfClass:[FOOObject class]]);
    /**
     结论：
     kingof是回溯父类比较isa指针的。
     memberclass是直接比较当前两个类的isa指针的
     
     */
}


@end
