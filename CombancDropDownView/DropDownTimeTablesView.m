//
//  DropDownTimeTablesView.m
//  DropDownTimeTablesView
//
//  Created by Golden on 2018/10/16.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "DropDownTimeTablesView.h"
#import "DropDownTableView.h"
#import "Masonry.h"
#import "UIColor+DropDownCatagory.h"

@interface DropDownTimeTablesView ()
//titleArray
@property (nonatomic, copy  ) NSArray *titlesArray;
//infoDicArray
@property (nonatomic, copy  ) NSArray *infoArray;
//backgroundView
@property (nonatomic, strong) UIView *backView;
//sectionView
@property (nonatomic, strong) UIView *sectionView;
//年级Btn
@property (nonatomic, strong) UIButton *gradeBtn;
//班级Btn
@property (nonatomic, strong) UIButton *classBtn;
//科目Btn
@property (nonatomic, strong) UIButton *subjectBtn;
//listView
@property (nonatomic, strong) UIView *listView;
//optionView
@property (nonatomic, strong) DropDownTableView *gradeTableView;
@property (nonatomic, strong) DropDownTableView *classTableView;
@property (nonatomic, strong) DropDownTableView *subjectTabelView;
//selectCellName
@property (nonatomic, copy  ) NSString *gradeSelected;
@property (nonatomic, copy  ) NSString *classSelected;
@property (nonatomic, copy  ) NSString *subjectSelected;
@end

@implementation DropDownTimeTablesView

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles WithInfo:(NSArray<NSDictionary *> *)info {
    self = [super init];
    if (self) {
        NSAssert(titles.count == 3, @"标题数目不对");
        NSAssert(info.count == 3, @"info数目不对");
        _titlesArray = titles;
        _infoArray = info;
        self.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44+3+200);
        [self configUI];
    }
    return self;
}

- (void)configUI {
    __weak typeof(self) weakSelf = self;
    
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(48);
    }];
    
    [self.backView addSubview:self.sectionView];
    [self.sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.top.equalTo(self.backView).offset(1);
        make.height.mas_equalTo(44);
    }];
    
    [self.sectionView addSubview:self.gradeBtn];
    [self.gradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(42);
        make.centerY.equalTo(self.sectionView);
    }];
    
    [self.sectionView addSubview:self.classBtn];
    [self.classBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.sectionView);
    }];
    
    [self.sectionView addSubview:self.subjectBtn];
    [self.subjectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-42);
        make.centerY.equalTo(self.sectionView);
    }];
    
    [self addSubview:self.gradeTableView];
    [self addSubview:self.classTableView];
    [self addSubview:self.subjectTabelView];
    
    [self.gradeTableView setSelectedCellBlock:^(NSString *listName) {
        weakSelf.gradeSelected = listName;
        if (weakSelf.dropDownSelectedBlcok) {
            weakSelf.dropDownSelectedBlcok(weakSelf.gradeSelected, weakSelf.classSelected, weakSelf.subjectSelected);
        }
    }];
    [self.classTableView setSelectedCellBlock:^(NSString *listName) {
        weakSelf.classSelected = listName;
        if (weakSelf.dropDownSelectedBlcok) {
            weakSelf.dropDownSelectedBlcok(weakSelf.gradeSelected, weakSelf.classSelected, weakSelf.subjectSelected);
        }
    }];
    [self.subjectTabelView setSelectedCellBlock:^(NSString *listName) {
        weakSelf.subjectSelected = listName;
        if (weakSelf.dropDownSelectedBlcok) {
            weakSelf.dropDownSelectedBlcok(weakSelf.gradeSelected, weakSelf.classSelected, weakSelf.subjectSelected);
        }
    }];
}

- (void)btnClicked:(UIButton *)sender {
    if (sender == self.gradeBtn) {
        [self.classTableView hidden];
        [self.subjectTabelView hidden];
        if (self.gradeTableView.isShow) {
            [self.gradeTableView hidden];
        }else {
            [self.gradeTableView show];
        }
        [self.gradeTableView setListArray:[_infoArray[0] allKeys]];
    }else if (sender == self.classBtn) {
        [self.gradeTableView hidden];
        [self.subjectTabelView hidden];
        if (self.classTableView.isShow) {
            [self.classTableView hidden];
        }else {
            [self.classTableView show];
        }
        [self.classTableView setListArray:[_infoArray[1] allKeys]];
    }else if (sender == self.subjectBtn) {
        [self.gradeTableView hidden];
        [self.classTableView hidden];
        if (self.subjectTabelView.isShow) {
            [self.subjectTabelView hidden];
        }else {
            [self.subjectTabelView show];
        }
        [self.subjectTabelView setListArray:[_infoArray[2] allKeys]];
    }
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor colorWithHex:@"#d9d9d9"];
    }
    return _backView;
}

- (UIView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[UIView alloc]init];
        _sectionView.backgroundColor = [UIColor whiteColor];
    }
    return _sectionView;
}

- (UIButton *)gradeBtn {
    if (!_gradeBtn) {
        _gradeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _gradeBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        [_gradeBtn setTitle:_titlesArray[0] forState:UIControlStateNormal];
        [_gradeBtn setImage:[UIImage imageNamed:@"icon_list"] forState:UIControlStateNormal];
        _gradeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);
        [_gradeBtn setTitleColor:[UIColor colorWithHex:@"#38383d"] forState:UIControlStateNormal];
        [_gradeBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gradeBtn;
}

- (UIButton *)classBtn {
    if (!_classBtn) {
        _classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _classBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        [_classBtn setTitle:_titlesArray[1] forState:UIControlStateNormal];
        [_classBtn setImage:[UIImage imageNamed:@"icon_list"] forState:UIControlStateNormal];
        _classBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);
        [_classBtn setTitleColor:[UIColor colorWithHex:@"#38383d"] forState:UIControlStateNormal];
        [_classBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _classBtn;
}

- (UIButton *)subjectBtn {
    if (!_subjectBtn) {
        _subjectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _subjectBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        [_subjectBtn setTitle:_titlesArray[2] forState:UIControlStateNormal];
        [_subjectBtn setImage:[UIImage imageNamed:@"icon_list"] forState:UIControlStateNormal];
        _subjectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);
        [_subjectBtn setTitleColor:[UIColor colorWithHex:@"#38383d"] forState:UIControlStateNormal];
        [_subjectBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subjectBtn;
}

- (UIView *)listView {
    if (!_listView) {
        _listView = [[UIView alloc]init];
    }
    return _listView;
}

- (DropDownTableView *)gradeTableView {
    if (!_gradeTableView) {
        _gradeTableView = [[DropDownTableView alloc]initWithFrame:CGRectMake(0, 44+1+3, self.bounds.size.width, 0)];
    }
    return _gradeTableView;
}

- (DropDownTableView *)classTableView {
    if (!_classTableView) {
        _classTableView = [[DropDownTableView alloc]initWithFrame:CGRectMake(0, 44+1+3, self.bounds.size.width, 0)];
    }
    return _classTableView;
}

- (DropDownTableView *)subjectTabelView {
    if (!_subjectTabelView) {
        _subjectTabelView = [[DropDownTableView alloc]initWithFrame:CGRectMake(0, 44+1+3, self.bounds.size.width, 0)];
    }
    return _subjectTabelView;
}

- (void)remove {
    [self removeFromSuperview];
}

@end
