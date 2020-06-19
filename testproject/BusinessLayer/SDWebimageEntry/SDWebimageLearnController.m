//
//  SDWebimageLearnController.m
//  testproject
//
//  Created by bolang on 2020/6/18.
//  Copyright © 2020 bolang. All rights reserved.
//

#import "SDWebimageLearnController.h"
#import "UIImageView+WebCache.h"

@interface SDWebimageLearnController ()

@end

@implementation SDWebimageLearnController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self SDtest];
    // Do any additional setup after loading the view.
}

- (void)SDtest{
    UIImageView *textView = [[UIImageView alloc] init];
    [textView sd_setImageWithURL:[NSURL URLWithString:@"http://www.domain.com/path/to/image.jpg"] placeholderImage:[UIImage imageNamed:@"V60.jpg"]];
    [self.view addSubview:textView];
    [textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(150);
        make.width.mas_equalTo(200);
    }];
}

@end
