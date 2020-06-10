//
//  CategoryPropertyController.m
//  testproject
//
//  Created by bolang on 2020/6/3.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "CategoryPropertyController.h"
#import "CategoryPropertyObject.h"
#import "CategoryPropertyObject+SchoolClass.h"

@interface CategoryPropertyController ()

@end

@implementation CategoryPropertyController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CategoryPropertyObject *object = [[CategoryPropertyObject alloc] init];
    object.objectName = @"123";
    object.objectType = @"normal";
    object.schoolName = @"育才二小";
    
    NSLog(@"%@",object.schoolName);
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}



@end
