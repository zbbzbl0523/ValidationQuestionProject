//
//  BezierPathCell.m
//  testproject
//
//  Created by bolang on 2020/6/4.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "BezierPathCell.h"
@interface BezierPathCell()

@property (nonatomic,strong)UIView *backGroundWhiteView;
@property (nonatomic,strong)UILabel *numberLabel;

@end

static CGFloat marginBorder = 5;
static CGFloat WidthProportion = 365.0 / 375.0;

@implementation BezierPathCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#DEDEDE"];
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView{
    self.backGroundWhiteView = [[UIView alloc] init];
    [self addSubview:self.backGroundWhiteView];
    self.backGroundWhiteView.backgroundColor = [UIColor whiteColor];
    
    /// 简单方法，可以使用masonry做布局
//    self.backGroundWhiteView.layer.cornerRadius = 5;
//    self.backGroundWhiteView.layer.masksToBounds = true;
//    [self.backGroundWhiteView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.mas_left).offset(13);
//        make.right.mas_equalTo(self.mas_right).offset(-13);
//        make.top.mas_equalTo(self.mas_top).offset(marginBorder);
//        make.bottom.mas_equalTo(self.mas_bottom).offset(-marginBorder);
//    }];
    
    /// 复杂方法，不可以使用masonry做布局
    self.backGroundWhiteView.frame = CGRectMake((1 - WidthProportion) * [UIScreen mainScreen].bounds.size.width /2 , 5, WidthProportion * [UIScreen mainScreen].bounds.size.width, 790);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.backGroundWhiteView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.backGroundWhiteView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.backGroundWhiteView.layer.mask = maskLayer;
    
    
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.text = @"测试";
    [self.backGroundWhiteView addSubview:self.numberLabel];
    [self.numberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.backGroundWhiteView).offset(-5);
        make.left.mas_equalTo(self.backGroundWhiteView.mas_left).offset(10);
    }];
}

- (void)setNumber:(NSString *)number{
    _number = number;
    self.numberLabel.text = number;
    
    self.backGroundWhiteView.frame = CGRectMake((1 - WidthProportion) * [UIScreen mainScreen].bounds.size.width /2 , 5, WidthProportion * [UIScreen mainScreen].bounds.size.width, 890);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.backGroundWhiteView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.backGroundWhiteView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.backGroundWhiteView.layer.mask = maskLayer;
}

#pragma mark -- 类方法  复用
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"BezierPathCell";
    BezierPathCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[BezierPathCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}



@end
