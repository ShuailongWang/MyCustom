//
//  CustomInputView.h
//  RGFZZD
//
//  Created by admin on 17/2/17.
//  Copyright © 2017年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelBlock)();
typedef void(^ConfirmBlock)(NSString *inputContent);

@interface CustomInputView : UIView

@property (weak, nonatomic) IBOutlet UITextView *textView;  //文本框
//标题
@property (nonatomic, copy) NSString *titleName;
//输入文字的最大长度
@property (nonatomic, assign) NSInteger maxLength;

@property (nonatomic,copy)CancelBlock cancelHandler;
@property (nonatomic,copy)ConfirmBlock confirmHandler;

@end
