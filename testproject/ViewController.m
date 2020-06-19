//
//  ViewController.m
//  testproject
//
//  Created by bolang on 2020/5/25.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "ViewController.h"
#import "MutiThreadPoolViewController.h"
#import "CategoryPropertyController.h"
#import "BezierPathController.h"
#import "KindOrMemberAboutController.h"
#import "ObjectDeallocBlockController.h"
#import "LifeCircleController.h"
#import "ThreadCommunicationController.h"
#import "BlockReturnCircleController.h"
#import "UIDocumentInterationUseController.h"
#import "DocumentSaveController.h"
#import "DelayCodeController.h"
#import "NSOperationTestController.h"
#import "BLTransAnimation.h"
#import "TransAnimationController.h"
#import "LockUseViewController.h"
#import "SDWebimageLearnController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (nonatomic,strong)UITableView *fisrtPageTableView;

@property (nonatomic,strong)NSMutableArray *datasource;

@end

static NSString *queueAbout = @"是否为主队列判断";
static NSString *threadPoolAbout = @"实现指定线程数的线程池";
static NSString *CategoryPropertyAbout = @"如何在分类中添加属性";
static NSString *BezierPathAbout = @"贝塞尔曲线";
static NSString *KindOrMemberAbout = @"King OR Member";
static NSString *ObjectDeallocBlock = @"为对象添加一个释放时触发的block";
static NSString *UIViewControllLifeCircle = @"UIViewControll声明周期";
static NSString *ThreadCommunication = @"线程间的通信";
static NSString *BlockReturnCircle = @"block循环引用";
static NSString *UIDocumentInterationUse = @"UIDocumentInterationUse文件预览";
static NSString *DocumentSave = @"DocumentSave文件缓存";
static NSString *DelayCode = @"延迟操作测试";
static NSString *NSOperationTest = @"NSOperation测试";
static NSString *TransAnimation = @"TransAnimation转场动画";
static NSString *LockUse = @"多线程 锁测试";
static NSString *SDtest = @"SDwebimage";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createrDataSource];
    [self createTableView];
    //    [self text];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

// MARK: - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (fromVC == self && [toVC isKindOfClass:[TransAnimationController class]]) {
        return [[BLTransAnimation alloc] init];
    }
    
    return nil;
}

- (void)createrDataSource{
    self.datasource = [NSMutableArray new];
    [self.datasource addObject:SDtest];
    [self.datasource addObject:LockUse];
    [self.datasource addObject:TransAnimation];
    [self.datasource addObject:NSOperationTest];
    [self.datasource addObject:queueAbout];
    [self.datasource addObject:threadPoolAbout];
    [self.datasource addObject:CategoryPropertyAbout];
    [self.datasource addObject:BezierPathAbout];
    [self.datasource addObject:KindOrMemberAbout];
    [self.datasource addObject:ObjectDeallocBlock];
    [self.datasource addObject:UIViewControllLifeCircle];
    [self.datasource addObject:ThreadCommunication];
    [self.datasource addObject:BlockReturnCircle];
    [self.datasource addObject:UIDocumentInterationUse];
    [self.datasource addObject:DocumentSave];
    [self.datasource addObject:DelayCode];
}

- (void)createTableView{
    self.fisrtPageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.fisrtPageTableView];
    self.fisrtPageTableView.delegate = self;
    self.fisrtPageTableView.dataSource = self;
    self.fisrtPageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.fisrtPageTableView.tableFooterView = [[UIView alloc] init];
    self.fisrtPageTableView.backgroundColor = [UIColor whiteColor];
    self.fisrtPageTableView.estimatedRowHeight = 0;
    self.fisrtPageTableView.estimatedSectionFooterHeight = 0;
    self.fisrtPageTableView.estimatedSectionHeaderHeight = 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = self.datasource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *didSelectedCell = self.datasource[indexPath.row];
    if ([didSelectedCell isEqualToString:SDtest]) {
        SDWebimageLearnController *vc = [SDWebimageLearnController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([didSelectedCell isEqualToString:LockUse]) {
        LockUseViewController *vc = [LockUseViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([didSelectedCell isEqualToString:threadPoolAbout]) {
        MutiThreadPoolViewController *vc = [MutiThreadPoolViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([didSelectedCell isEqualToString:CategoryPropertyAbout]) {
        CategoryPropertyController *vc = [CategoryPropertyController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([didSelectedCell isEqualToString:BezierPathAbout]) {
        BezierPathController *vc = [BezierPathController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([didSelectedCell isEqualToString:KindOrMemberAbout]) {
        KindOrMemberAboutController *vc = [KindOrMemberAboutController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([didSelectedCell isEqualToString:ObjectDeallocBlock]) {
        ObjectDeallocBlockController *vc = [ObjectDeallocBlockController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([didSelectedCell isEqualToString:UIViewControllLifeCircle]) {
        LifeCircleController *vc = [LifeCircleController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([didSelectedCell isEqualToString:ThreadCommunication]) {
        ThreadCommunicationController *vc = [ThreadCommunicationController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([didSelectedCell isEqualToString:BlockReturnCircle]) {
        BlockReturnCircleController *vc = [BlockReturnCircleController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([didSelectedCell isEqualToString:UIDocumentInterationUse]) {
        UIDocumentInterationUseController *vc = [UIDocumentInterationUseController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([didSelectedCell isEqualToString:DocumentSave]) {
        DocumentSaveController *vc = [DocumentSaveController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([didSelectedCell isEqualToString:DelayCode]) {
        DelayCodeController *vc = [DelayCodeController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([didSelectedCell isEqualToString:NSOperationTest]) {
        NSOperationTestController *vc = [NSOperationTestController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([didSelectedCell isEqualToString:TransAnimation]) {
        TransAnimationController *vc = [TransAnimationController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
