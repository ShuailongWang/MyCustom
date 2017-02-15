//
//  CusPickerView.m
//  UIPickerView
//
//  Created by admin on 17/2/10.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "CusPickerView.h"

#define KScreen_Width   [UIScreen mainScreen].bounds.size.width
#define KScreen_Height  [UIScreen mainScreen].bounds.size.height
#define KScreen_Bounds  [UIScreen mainScreen].bounds

@interface CusPickerView()<UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;       //标题
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;  //pickerView

@property (nonatomic, strong) UIView *bgView;   //遮罩
@property (nonatomic, copy) NSString *selectName;

@end

@implementation CusPickerView

- (instancetype)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CusPickerView" owner:self options:nil] lastObject];
        // 初始化设置
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.frame = CGRectMake(0, KScreen_Height, KScreen_Width, 250);
        [window addSubview:self.bgView];
        [window addSubview:self];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.pickerView.delegate = self;
}

#pragma mark - UIPickerViewDelegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataList.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataList[row];
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectName = self.dataList[row];
}

//数据
-(void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    
    //刷新
    [self.pickerView reloadAllComponents];
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

//确定按钮
- (IBAction)clickOKButton:(UIButton *)sender {
    if (self.selectName) {
        if (self.myBlock) {
            self.myBlock(self.selectName);
        }
    }else{
        if (self.dataList.count > 0) {
            if (self.myBlock) {
                self.myBlock(self.dataList[0]);
            }
        }
    }
    //
    [self hide];
}

//取消按钮
- (IBAction)clickCanelButton:(UIButton *)sender {
    [self hide];
}

#pragma mark - 懒加载
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
@end
