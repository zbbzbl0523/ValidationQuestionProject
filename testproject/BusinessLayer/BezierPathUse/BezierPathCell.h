//
//  BezierPathCell.h
//  testproject
//
//  Created by bolang on 2020/6/4.
//  Copyright © 2020 bolang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BezierPathCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong)NSString *number;

@end

NS_ASSUME_NONNULL_END
