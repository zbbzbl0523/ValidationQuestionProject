//
//  BezierPathController.m
//  testproject
//
//  Created by bolang on 2020/6/4.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "BezierPathController.h"
#import "TableViewConstructor.h"
#import "BezierPathCell.h"

@interface BezierPathController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableview;

@end

@implementation BezierPathController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableview];
    // Do any additional setup after loading the view.
}


- (void)createTableview{
    self.tableview = [TableViewConstructor returnDefaultPlainStyleTableView:self];
    [self.view addSubview:self.tableview];
    [self.tableview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BezierPathCell *cell = [BezierPathCell cellWithTableView:tableView];
    cell.number = @"贝塞尔测试";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 900;
}



@end
