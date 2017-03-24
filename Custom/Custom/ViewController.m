//
//  ViewController.m
//  Custom
//
//  Created by admin on 17/2/15.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "ViewController.h"
#import "CustomLabelController.h"
#import "CusDatePickerController.h"
#import "CusPickerController.h"
#import "FourViewController.h"
#import "RGHomeController.h"
#import "WelcomeController.h"
#import "WebVideoVController.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *titleArr;

@end

static NSString *UITableViewCellID = @"UITableViewCellID";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setupUI];
}

-(void)setupUI{
    if (nil == _myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UITableViewCellID];
        [self.view addSubview:_myTableView];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellID forIndexPath:indexPath];
    cell.textLabel.text = self.titleArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            CustomLabelController *CustomVC = [[CustomLabelController alloc]init];
            [self.navigationController pushViewController:CustomVC animated:YES];
        }
            break;
        case 1:{
            CusDatePickerController *CustomVC = [[CusDatePickerController alloc]init];
            [self.navigationController pushViewController:CustomVC animated:YES];
        }
            break;
        case 2:{
            CusPickerController *CustomVC = [[CusPickerController alloc]init];
            [self.navigationController pushViewController:CustomVC animated:YES];
        }
            break;
        case 3:{
            FourViewController *CustomVC = [[FourViewController alloc]init];
            [self.navigationController pushViewController:CustomVC animated:YES];
        }
            break;
        case 4:{
            RGHomeController *CustomVC = [[RGHomeController alloc]init];
            [self.navigationController pushViewController:CustomVC animated:YES];
        }
            break;
        case 5:{
            WelcomeController *welcomeVC = [[WelcomeController alloc]init];
            [self.navigationController pushViewController:welcomeVC animated:YES];
        }
            break;
        case 6:{
            WebVideoVController *videoVC = [[WebVideoVController alloc]init];
            [self.navigationController pushViewController:videoVC animated:YES];
        }
            break;
        default:
            break;
    }
}


//
-(NSArray *)titleArr{
    if (nil == _titleArr) {
        _titleArr = @[
                      @"CustomLabel",
                      @"CustomDatePicker",
                      @"CustomPickerView",
                      @"inputView",
                      @"webView进度条, 左右滑前进后退",
                      @"引导页",
                      @"webView的视频,自动横屏"
                      ];
    }
    return _titleArr;
}

@end
