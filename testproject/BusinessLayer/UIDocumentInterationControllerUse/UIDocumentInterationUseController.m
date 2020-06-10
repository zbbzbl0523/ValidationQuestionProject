//
//  UIDocumentInterationUseController.m
//  testproject
//
//  Created by bolang on 2020/6/9.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "UIDocumentInterationUseController.h"

@interface UIDocumentInterationUseController ()<UIDocumentInteractionControllerDelegate>

@property (nonatomic,strong)UIDocumentInteractionController * document;

@end

@implementation UIDocumentInterationUseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self saveButton];
    [self addButton];
    
    
    // Do any additional setup after loading the view.
}

- (void)saveButton{
    UIButton *showButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, 200, 100)];
    [showButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showButton setTitle:@"保存到tmp中" forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(saveToTmp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton];
}

- (void)addButton{
    UIButton *showButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 100)];
    [showButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showButton setTitle:@"展示PDF" forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(docOpenFunc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showButton];
}

- (void)docOpenFunc{
    NSURL *pathUrl = [[NSBundle mainBundle] URLForResource:@"计算机" withExtension:@"pdf"];
    self.document = [UIDocumentInteractionController interactionControllerWithURL:pathUrl];
    self.document.delegate = self;
    [self presentUIDocument];
}

- (void)presentOptionsMenu{
    [self.document presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
}

- (void)presentUIDocument{
    [self.document presentPreviewAnimated:YES ];
}

// 预览的时候需要加上系统的代理方法
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller{
    NSLog(@"跳到菜单页面");
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application{
    NSLog(@"123");
}

- (void)saveToTmp{
    
}

@end
