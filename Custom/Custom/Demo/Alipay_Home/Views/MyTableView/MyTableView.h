//
//  MyTableView.h
//  支付宝首页
//
//  Created by admin on 17/4/10.
//  Copyright © 2017年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyTableView : UITableView

@property(assign, nonatomic) CGFloat contentOffsetY;

- (void)startRefreshing;
- (void)endRefreshing;

@end
