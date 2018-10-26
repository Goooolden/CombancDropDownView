//
//  DropDownTableView.m
//  DropDownTimeTablesView
//
//  Created by Golden on 2018/10/16.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "DropDownTableView.h"
#import "DropDownTableViewCell.h"

static NSString *const DROPDOWN_CELLID = @"DROPDOWN_CELLID";

@interface DropDownTableView ()<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) NSMutableArray *selectedArray;

@end

@implementation DropDownTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.isShow = NO;
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = 80;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DropDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DROPDOWN_CELLID];
    if (!cell) {
        cell = [[DropDownTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DROPDOWN_CELLID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleNameLabel.text = self.listArray[indexPath.row];
    [cell.selectedBtn setBackgroundImage:[UIImage imageNamed:@"Radio_false"] forState:UIControlStateNormal];
    for (NSIndexPath *selectIndexPath in self.selectedArray) {
        if (indexPath.row == selectIndexPath.row) {
            [cell.selectedBtn setBackgroundImage:[UIImage imageNamed:@"Radio_true"] forState:UIControlStateNormal];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.selectedArray containsObject:indexPath]) {
        [self.selectedArray removeObject:indexPath];
    }else {
        [self.selectedArray removeAllObjects];
        [self.selectedArray addObject:indexPath];
        if (self.selectedCellBlock) {
            self.selectedCellBlock(self.listArray[indexPath.row]);
        }
    }
    [self reloadData];
}

- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = [[NSMutableArray array]init];
    }
    return _selectedArray;
}

- (void)setListArray:(NSArray *)listArray {
    _listArray = listArray;
    [self reloadData];
}

- (void)show {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.frame;
        frame.size.height = 200;
        self.frame = frame;
        self.isShow = YES;
    }];
}

- (void)hidden {
    CGRect frame = self.frame;
    frame.size.height = 0;
    self.frame = frame;
    self.isShow = NO;
}

@end
