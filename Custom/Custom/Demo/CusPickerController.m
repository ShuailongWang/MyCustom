//
//  CusPickerController.m
//  Custom
//
//  Created by admin on 17/2/15.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "CusPickerController.h"
#import "CusPickerView.h"

@interface CusPickerController ()

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) CusPickerView *cusPickerView;

@end

@implementation CusPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.title = @"CusPickerViewckerView";
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
    [self showPickerView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_cusPickerView){
        _cusPickerView = [[CusPickerView alloc]init];
        _cusPickerView.dataList = @[@"yqiow11", @"yqiow22", @"yqiow33", @"yqiow44"];
    }
}

//显示
-(void)showPickerView{
    [self.cusPickerView show];
    
    //回调,赋值
    //weakSelf
    __weak typeof(self) weakSelf = self;
    self.cusPickerView.myBlock = ^(NSString *selectStr){
        weakSelf.dateLabel.text = selectStr;
    };
}


@end
