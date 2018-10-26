//
//  DropDownTableViewCell.m
//  DropDownTimeTablesView
//
//  Created by Golden on 2018/10/17.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "DropDownTableViewCell.h"
#import "UIColor+DropDownCatagory.h"
#import "Masonry.h"

@interface DropDownTableViewCell ()

@end

@implementation DropDownTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.titleNameLabel = [[UILabel alloc]init];
    self.titleNameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
    self.titleNameLabel.textColor = [UIColor colorNamed:@"#38383d"];
    [self.contentView addSubview:self.titleNameLabel];
    
    self.selectedBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.selectedBtn setBackgroundImage:[UIImage imageNamed:@"Radio_false"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.selectedBtn];
    
    [self.titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.width.height.mas_equalTo(15);
    }];
}

@end
