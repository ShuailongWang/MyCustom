//
//  UITextView+Extension.m
//  RGfzzd
//
//  Created by admin on 16/12/21.
//  Copyright © 2016年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import "UITextView+Extension.h"
#import <objc/runtime.h>

@interface UITextView()<UITextViewDelegate>

@property (nonatomic,strong) UILabel *placeholderLabel;//占位符
@property (nonatomic,strong) UILabel *wordCountLabel;//计算字数

@end

static NSString *PLACEHOLDLABEL = @"placelabel";
static NSString *PLACEHOLD = @"placehold";
static NSString *WORDCOUNTLABEL = @"wordcount";
static NSString *LabelIndex = @"LabelIndex";
static const void *limitLengthKey = &limitLengthKey;

@implementation UITextView (Extension)




#pragma mark -- set/get...

//占位label
-(void)setPlaceholderLabel:(UILabel *)placeholderLabel {
    
    objc_setAssociatedObject(self, &PLACEHOLDLABEL, placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UILabel *)placeholderLabel {
    
    return objc_getAssociatedObject(self, &PLACEHOLDLABEL);
    
}

//占位文字
- (void)setPlaceholder:(NSString *)placeholder {
    
    
    objc_setAssociatedObject(self, &PLACEHOLD, placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setPlaceHolderLabel:placeholder];
}
- (NSString *)placeholder {
    
    return objc_getAssociatedObject(self, &PLACEHOLD);
}

//长度文字
- (UILabel *)wordCountLabel {
    
    return objc_getAssociatedObject(self, &WORDCOUNTLABEL);
    
}
- (void)setWordCountLabel:(UILabel *)wordCountLabel {
    
    objc_setAssociatedObject(self, &WORDCOUNTLABEL, wordCountLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

//长度数字
- (NSNumber *)limitLength {
    
    return objc_getAssociatedObject(self, limitLengthKey);
}
- (void)setLimitLength:(NSNumber *)limitLength {
    objc_setAssociatedObject(self, limitLengthKey, limitLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addLimitLengthObserver:[limitLength intValue]];
    
    [self setWordcountLable:limitLength];
    
}

//富文本文字
-(NSNumber*)startLength{
    return objc_getAssociatedObject(self, &LabelIndex);
}
-(void)setStartLength:(NSNumber *)startLength{
    objc_setAssociatedObject(self, &LabelIndex, startLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self setPlaceholderIndex:[startLength intValue]];
}


#pragma mark - 富文本
- (void)setPlaceholderIndex:(int)strLength{
    NSString *labelStr = self.placeholderLabel.text;
    int endLength = (int)labelStr.length - strLength - 1;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:labelStr];
    [attrStr addAttribute:NSForegroundColorAttributeName value:HEXColor(0x009EEF) range:NSMakeRange(strLength, endLength)];
    
    self.placeholderLabel.attributedText = attrStr;
}

#pragma mark -- 配置占位符标签

- (void)setPlaceHolderLabel:(NSString *)placeholder {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextViewTextDidChangeNotification object:self];
    /*
     *  占位字符
     */
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.font = [UIFont systemFontOfSize:13.];
    self.placeholderLabel.text = placeholder;
    self.placeholderLabel.numberOfLines = 0;
    self.placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.placeholderLabel.textColor = [UIColor grayColor];
    CGRect rect = [placeholder boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame)-7, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.]} context:nil];
    self.placeholderLabel.frame = CGRectMake(7, 7, rect.size.width, rect.size.height);
    [self addSubview:self.placeholderLabel];
    self.placeholderLabel.hidden = self.text.length > 0 ? YES : NO;
    
}

#pragma mark -- 配置字数限制标签

- (void)setWordcountLable:(NSNumber *)limitLength {
    
    /*
     *  字数限制
     */
    self.wordCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 65, CGRectGetHeight(self.frame) - 20, 60, 20)];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    self.wordCountLabel.textColor = [UIColor lightGrayColor];
    self.wordCountLabel.font = [UIFont systemFontOfSize:13.];
    if (self.text.length > [limitLength integerValue]) {
        self.text = [self.text substringToIndex:[self.limitLength intValue]];
    }
    self.wordCountLabel.text = [NSString stringWithFormat:@"%lu/%@",(unsigned long)self.text.length,limitLength];
    [self addSubview:self.wordCountLabel];
    
}


#pragma mark -- 增加限制位数的通知
- (void)addLimitLengthObserver:(int)length {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitLengthEvent) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark -- 限制输入的位数
- (void)limitLengthEvent {
    
    if ([self.text length] > [self.limitLength intValue]) {
        
        self.text = [self.text substringToIndex:[self.limitLength intValue]];
    }
}


#pragma mark -- NSNotification

- (void)textFieldChanged:(NSNotification *)notification {
    if (self.placeholder) {
        self.placeholderLabel.hidden = YES;
        
        if (self.text.length == 0) {
            
            self.placeholderLabel.hidden = NO;
        }
    }
    if (self.limitLength) {
        
        NSInteger wordCount = self.text.length;
        if (wordCount > [self.limitLength integerValue]) {
            wordCount = [self.limitLength integerValue];
        }
        self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/%@",wordCount,self.limitLength];
    }
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];
}




@end
