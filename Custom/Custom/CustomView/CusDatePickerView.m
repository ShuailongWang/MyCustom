//
//  CusDatePickerView.m
//  UIPickerView
//
//  Created by admin on 17/2/10.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "CusDatePickerView.h"

#define KScreen_Width   [UIScreen mainScreen].bounds.size.width
#define KScreen_Height  [UIScreen mainScreen].bounds.size.height
#define KScreen_Bounds  [UIScreen mainScreen].bounds

@interface CusDatePickerView()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *bgView;   //遮罩
/** 时间格式转换器 */
@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation CusDatePickerView

#pragma mark 配置视图

- (instancetype)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CusDatePickerView" owner:self options:nil] lastObject];
        // 初始化设置
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.frame = CGRectMake(0, KScreen_Height, KScreen_Width, 350);
        [window addSubview:self.bgView];
        [window addSubview:self];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 设置时间格式转换器
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateFormat = @"yyyy-MM-dd";
}
- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _bgView.hidden = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}


#pragma mark - 方法
//显示
-(void)show{
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.hidden = NO;
        
        CGRect newFrame = self.frame;
        newFrame.origin.y = KScreen_Height - self.frame.size.height;
        self.frame = newFrame;
    } completion:nil];
}
//消失
-(void)hide{
    [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:0 animations:^{
        self.bgView.hidden = YES;
        
        CGRect newFrame = self.frame;
        newFrame.origin.y = KScreen_Height;
        self.frame = newFrame;
    } completion:nil];
}
- (IBAction)clickCalelButton:(UIButton *)sender {
    [self hide];
}
- (IBAction)clickOKButton:(UIButton *)sender {
    NSString *selectName = [self.formatter stringFromDate:self.datePicker.date];
    if (selectName) {
        if (self.myBlock) {
            self.myBlock(selectName);
        }
    }
    [self hide];
}

@end
