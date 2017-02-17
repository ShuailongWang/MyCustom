//
//  CustomInput.m
//  RGFZZD
//
//  Created by admin on 17/2/17.
//  Copyright © 2017年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import "CustomInput.h"
#import "CustomInputView.h"


@implementation CustomInput

+ (CustomInputView*)inputView {
    static dispatch_once_t once;
    
    static CustomInputView *inputView;
#if !defined(BB_APP_EXTENSIONS)
    dispatch_once(&once, ^{ inputView = [[CustomInputView alloc] init];});
#else
    dispatch_once(&once, ^{ inputView = [[CustomInputView alloc] init]; });
#endif
    
    inputView.cancelHandler = ^{
        [CustomInput dismissKeyboardAndBgBtutton:[self backgroundView]];
    };
    
    
    
    return inputView;
}

+ (UIButton*)backgroundView {
    static dispatch_once_t once;
    
    static UIButton *backgroundView;
#if !defined(BB_APP_EXTENSIONS)
    dispatch_once(&once, ^{ backgroundView = [[UIButton alloc] init];});
#else
    dispatch_once(&once, ^{ backgroundView = [[UIButton alloc] init];});
#endif
    
    backgroundView.backgroundColor = [UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:0.5];
    backgroundView.frame = [UIScreen mainScreen].bounds;
    [backgroundView addTarget:self action:@selector(dismissKeyboardAndBgBtutton:) forControlEvents:UIControlEventTouchUpInside];
    
    return backgroundView;
}


+(void)showInput:(ConfirmBlock)confirmHandler{
    
    [[UIApplication sharedApplication].keyWindow addSubview:[self backgroundView]];
    
    UITextView *inputTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    inputTextView.inputAccessoryView = [self inputView];
    [[self backgroundView] addSubview:inputTextView];
    
    [inputTextView becomeFirstResponder];
    [[self inputView].textView becomeFirstResponder];
    
    
    [self inputView].confirmHandler = ^(NSString *inputContent){
        
        [CustomInput dismissKeyboardAndBgBtutton:[self backgroundView]];
        confirmHandler(inputContent);
    };
}


+(void)dismissKeyboardAndBgBtutton:(UIButton *)sender{
    
    [[self inputView].textView resignFirstResponder];
    [sender removeFromSuperview];
}


+(void)setNormalContent:(NSString *)content{
    
    [self inputView].textView.text = content;
}


+(void)setMaxContentLength:(NSInteger)lenght{
    
    [self inputView].maxLength = lenght;
}

+(void)setDescTitle:(NSString *)descTitle{
    
    [self inputView].titleName = descTitle;
}

@end
