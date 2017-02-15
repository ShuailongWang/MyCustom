//
//  CustomView.m
//  Custom
//
//  Created by admin on 17/2/15.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "CustomView.h"

#define Horizontal_Padding 7.0f
#define Vertical_Padding   3.0f
#define Label_Margin 10.0f
#define Bottom_Margin 10.0f

@interface CustomView()

@property (assign, nonatomic) CGRect previousFrame;
@property (assign, nonatomic) NSInteger totalHeight;
@property (nonatomic, strong) UIButton *button;
@property (assign, nonatomic) CGFloat viewHeight;

@end

@implementation CustomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.totalHeight = 0;
        self.viewHeight = 0;
        self.frame = frame;
    }
    return self;
}

//数组
-(void)setLabelArr:(NSArray *)labelArr{
    _labelArr = labelArr;
    
    self.previousFrame = CGRectZero;
    //遍历赋值
    [labelArr enumerateObjectsUsingBlock:^(NSString *strName, NSUInteger idx, BOOL * _Nonnull stop) {
        [self setupBtnWithString:strName];
    }];
    //设置背景颜色
    if (_CustomBackgroundColor) {
        self.backgroundColor = _CustomBackgroundColor;
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }

    //返回高度
    if ([self.customDelegate respondsToSelector:@selector(CustomView:viewHeight:)]) {
        [self.customDelegate CustomView:self viewHeight:self.viewHeight];
    }
    //返回高度
    if (self.myBlock) {
        self.myBlock(self.viewHeight);
    }
}



//
-(void)setupBtnWithString:(NSString *)strName{
    //
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectZero;
    
    //设置背景颜色
    if (_LabelBackgroundColor) {
        _button.backgroundColor = _LabelBackgroundColor;
    }else {
        _button.backgroundColor = [UIColor redColor];
    }
    
    //设置文字
    [_button setTitle:strName forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    _button.layer.cornerRadius = 5.0;
    _button.layer.masksToBounds = YES;
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //设置方法
    [_button addTarget:self action:@selector(clickHandle:) forControlEvents:UIControlEventTouchUpInside];
    //
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]};
    CGSize StrSize = [strName sizeWithAttributes:attribute];
    StrSize.width += Horizontal_Padding * 2;    //间距
    StrSize.height += Vertical_Padding * 2;     //间距
    
    //新的frame
    CGRect nextRect = CGRectZero;
    
    if (_previousFrame.origin.x + _previousFrame.size.width + StrSize.width + Label_Margin > self.bounds.size.width) {
        
        nextRect.origin = CGPointMake(10, _previousFrame.origin.y + StrSize.height + Bottom_Margin);
        _totalHeight += StrSize.height + Bottom_Margin;
    }else {
        nextRect.origin = CGPointMake(_previousFrame.origin.x + _previousFrame.size.width + Label_Margin, _previousFrame.origin.y);
    }
    
    nextRect.size = StrSize;
    [_button setFrame:nextRect];
    _previousFrame = _button.frame;
    [self setHight:self andHight:_totalHeight + StrSize.height + Bottom_Margin];
    [self addSubview:_button];
}

#pragma mark-改变控件高度
- (void)setHight:(UIView *)view andHight:(CGFloat)hight{
    CGRect tempFrame = view.frame;
    tempFrame.size.height = hight;
    view.frame = tempFrame;
    
    self.viewHeight = tempFrame.size.height;
}

#pragma mark==========按钮的处理方法
///按钮的处理方法
- (void)clickHandle:(UIButton *)sender{
    NSLog(@"点击了，点解了");
}



@end
