//
//  TableViewConstructor.m
//  testproject
//
//  Created by bolang on 2020/6/4.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "TableViewConstructor.h"

@implementation TableViewConstructor

+ (UITableView *)returnDefaultPlainStyleTableView:(id)delegateAndDataSourceTarget{
    UITableView *tableview =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableview.delegate = delegateAndDataSourceTarget;
    tableview.dataSource = delegateAndDataSourceTarget;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.tableFooterView = [[UIView alloc] init];
    tableview.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    tableview.estimatedRowHeight = 0;
    tableview.estimatedSectionFooterHeight = 0;
    tableview.estimatedSectionHeaderHeight = 0;
    return tableview;
}

@end
