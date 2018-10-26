//
//  DropDownTimeTablesView.h
//  DropDownTimeTablesView
//
//  Created by Golden on 2018/10/16.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DropDownSelectedBlcok)(NSString *first,NSString *sencond,NSString *third);

@interface DropDownTimeTablesView : UIView

@property (nonatomic, copy ) DropDownSelectedBlcok dropDownSelectedBlcok;

/**
 创建下拉视图

 @param titles 标题，三个
 @param info   下拉数据,是一个数组字典,会引起字典排序问题;(key:显示的内容 value:对应的id)。最好传一个Model数组
 @return self
 */
- (instancetype)initWithTitles:(NSArray<NSString *>*)titles WithInfo:(NSArray<NSDictionary *>*)info;
    
/**
 移除视图
 */
- (void)remove;

@end
