//
//  CategoryPropertyObject+SchoolClass.m
//  testproject
//
//  Created by bolang on 2020/6/3.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "CategoryPropertyObject+SchoolClass.h"
#import <objc/runtime.h>

static NSString *schoolPropertyKey = @"schoolName";

@implementation CategoryPropertyObject (SchoolClass)

- (void)setSchoolName:(NSString *)schoolName{
    objc_setAssociatedObject(self, &schoolPropertyKey, schoolName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)schoolName{
    return objc_getAssociatedObject(self, &schoolPropertyKey);
}

@end
