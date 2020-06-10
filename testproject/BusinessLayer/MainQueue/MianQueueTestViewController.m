//
//  MianQueueTestViewController.m
//  testproject
//
//  Created by bolang on 2020/5/26.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "MianQueueTestViewController.h"

@interface MianQueueTestViewController ()

@end

@implementation MianQueueTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)text{
    
//    dispatch_queue_t queue = dispatch_queue_create("testQueue", nil);
//    dispatch_sync(queue, ^{
        BOOL isMianQueue = [[self class] isMainQueue];
        NSLog(@"123 - %d",isMianQueue);
//    });
    
}

- (UILabel*)labelWithText: (NSString*)text {
    __block UILabel*theLabel;
    if([NSThread isMainThread]) {
        theLabel = [[UILabel alloc] init];
        [theLabel setText:text];
        
    }else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            theLabel = [[UILabel alloc] init];
            [theLabel setText:text];
            
        });
    }
    return theLabel;
}

+ (BOOL)isMainQueue {
    static const void* mainQueueKey =@"mainQueue";
    static void* mainQueueContext =@"mainQueue";
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_queue_set_specific(dispatch_get_main_queue(), mainQueueKey, mainQueueContext,nil);
    });
    return dispatch_get_specific(mainQueueKey) == mainQueueContext;
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
