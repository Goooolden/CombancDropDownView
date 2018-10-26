//
//  DropDownTableView.h
//  DropDownTimeTablesView
//
//  Created by Golden on 2018/10/16.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedCellBlock)(NSString *listName);

@interface DropDownTableView : UITableView
//显示列表数据
@property (nonatomic, copy  ) NSArray *listArray;
//判断DropDownTableView是否是隐藏状态
@property (nonatomic, assign) BOOL isShow;
//点击选择后的回调
@property (nonatomic, copy  ) SelectedCellBlock selectedCellBlock;

//显示
- (void)show;
//隐藏
- (void)hidden;
@end
