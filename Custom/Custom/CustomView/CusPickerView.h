//
//  CusPickerView.h
//  UIPickerView
//
//  Created by admin on 17/2/10.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CusPickerView : UIView

- (void)hide;
- (void)show;

/**数据*/
@property (nonatomic, strong) NSArray *dataList;
/**回调*/
@property (copy,nonatomic) void(^myBlock)(NSString *selectStr);


@end
