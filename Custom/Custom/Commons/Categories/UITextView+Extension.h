//
//  UITextView+Extension.h
//  RGfzzd
//
//  Created by admin on 16/12/21.
//  Copyright © 2016年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

/*  ！！！！！！！ 特殊说明。如果你想对textView.text直接赋值  ！！！！！！！！
 *       请务必在对textView.placehoulder和textView.limitLength之前进行
 *       格式：      textView.text = @"请务必写在placeholder和limitLength之前";
 *                  textView.placeholder = @"喜欢请Star";
 *                  textView.limitLength = @20;//如果赋值长度大于此长度会被自动截断！
 */
@property (nonatomic,strong) NSString *placeholder;//占位符
@property (copy, nonatomic) NSNumber *limitLength;//限制字数
@property (copy, nonatomic) NSNumber *startLength;

@end
