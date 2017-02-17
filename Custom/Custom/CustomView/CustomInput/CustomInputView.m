//
//  CustomInputView.m
//  RGFZZD
//
//  Created by admin on 17/2/17.
//  Copyright © 2017年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import "CustomInputView.h"

@interface CustomInputView()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;   //标题
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *numLabel; //长度

@property (weak, nonatomic) IBOutlet UIButton *freshButton; //完成
@property (weak, nonatomic) IBOutlet UIButton *conalButton; //取消

@end

@implementation CustomInputView

- (instancetype)init{
    if (self = [super init]) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.textView.delegate = self;
    
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.borderColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1.0].CGColor;
    self.bgView.layer.borderWidth = 1.0f;
    
    self.conalButton.layer.cornerRadius = 5;
    self.freshButton.layer.cornerRadius = 5;
    
    if (_maxLength <= 0) {
        _maxLength = 20;
    }
    
}

//取消
- (IBAction)clickCanCalButton:(UIButton *)sender {
    if (self.cancelHandler) {
        self.cancelHandler();
    }
}

//完成
- (IBAction)clickFreshButton:(UIButton *)sender {
    if (self.confirmHandler) {
        self.confirmHandler(self.textView.text);
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView;{
    self.numLabel.text = [NSString stringWithFormat:@"%ld/%ld",textView.text.length,(long)_maxLength];
}

- (void)textViewDidChange:(UITextView *)textView;{
    
    NSString *lang = textView.textInputMode.primaryLanguage;//键盘输入模式
    static NSInteger length = 0;
    if ([lang isEqualToString:@"zh-Hans"]){
        UITextRange *selectedRange = [textView markedTextRange];
        if (!selectedRange) {//没有有高亮
            length = textView.text.length;
        }else{
            
        }
    }else{
        length = textView.text.length;
    }
    
    if (length > 0) {
        
        if (length > _maxLength) {
            textView.text = [textView.text substringToIndex:_maxLength];
            self.numLabel.text = [NSString stringWithFormat:@"%ld/%ld",_maxLength,(long)_maxLength];
            return;
        }
        
        self.numLabel.text = [NSString stringWithFormat:@"%ld/%ld",length,(long)_maxLength];
    }
    
}

//
-(void)setMaxLength:(NSInteger)maxLength{
    _maxLength = maxLength;
    if (_maxLength) {
        self.numLabel.text = [NSString stringWithFormat:@"00/%ld",(long)_maxLength];
    }
}
-(void)setTitleName:(NSString *)titleName{
    _titleName = titleName;
    self.titleLabel.text = titleName;
}

@end
