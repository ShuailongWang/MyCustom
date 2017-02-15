//
//  CusDatePickerController.m
//  Custom
//
//  Created by admin on 17/2/15.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "CusDatePickerController.h"
#import "CusDatePickerView.h"

@interface CusDatePickerController ()

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) CusDatePickerView *cusDateView;

@end

@implementation CusDatePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"CusDatePickerView";
    [self setupUI];
}

-(void)setupUI{
    if (nil == _dateLabel) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 200, 30)];
        _dateLabel.text = @"点击我";
        [self.view addSubview:_dateLabel];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self showDateView];
}

/*
 之前是用懒加载的方式初始化inputView和datePicker，
 发现会有一定时间的延迟，约60ms，故将初始化方法在这里调用，
 这样则一点击按钮控件就能弹出来。
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (!_cusDateView){
        _cusDateView = [[CusDatePickerView alloc]init];
    }
}


-(void)showDateView{
    [self.cusDateView show];
    //回调,赋值
    //weakSelf
    __weak typeof(self) weakSelf = self;
    self.cusDateView.myBlock = ^(NSString *selectStr){
        weakSelf.dateLabel.text = selectStr;
    };
}

@end
