//
//  TableViewConstructor.h
//  testproject
//
//  Created by bolang on 2020/6/4.
//  Copyright © 2020 bolang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewConstructor : NSObject

/// 普通tableivew的构造函数
+ (UITableView *)returnDefaultPlainStyleTableView:(id)delegateAndDataSourceTarget;

@end

NS_ASSUME_NONNULL_END
