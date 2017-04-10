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
#import "HomeViewController.h"
#import "HomeViewController.h"
#import "WebImageViewController.h"
#import "MyCollectionViewController.h"
#import "MusicViewController.h"
#import "AliHomeController.h"

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
    NSDictionary *dict = self.titleArr[indexPath.row];
    cell.textLabel.text = dict[@"Title"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = self.titleArr[indexPath.row];
    
    //yinyue
    if ([dict[@"VC"] isEqualToString:@"MusicViewController"]) {
        MusicViewController *musicVC = [MusicViewController sharedInstance];
        [self.navigationController pushViewController:musicVC animated:YES];
        return;
    }
    
    
    id vc =  [[NSClassFromString(dict[@"VC"]) alloc] init];;
    [self.navigationController pushViewController:vc animated:YES];
}


//
-(NSArray *)titleArr{
    if (nil == _titleArr) {
        _titleArr = @[
                      @{@"Title": @"标签,可以返回高度", @"VC":  @"CustomLabelController"},
                      @{@"Title": @"日期",            @"VC":  @"CusDatePickerController"},
                      @{@"Title": @"男女",            @"VC":  @"CusPickerController"},
                      @{@"Title": @"输入框",           @"VC":  @"FourViewController"},
                      @{@"Title": @"webView进度条, 左右滑前进后退", @"VC":@"RGHomeController"},
                      @{@"Title": @"引导页",               @"VC": @"WelcomeController"},
                      @{@"Title": @"webView的视频,自动横屏",@"VC":@"WebVideoVController"},
                      @{@"Title": @"滑动屏幕,导航栏消失",    @"VC":@"HomeViewController"},
                      @{@"Title": @"webView中的图片点击放大",@"VC":@"WebImageViewController"},
                      @{@"Title": @"collection拖动",      @"VC":@"MyCollectionViewController"},
                      @{@"Title": @"Music",             @"VC":@"MusicViewController"},
                      @{@"Title": @"类似于支付宝首页下拉",  @"VC":@"AliHomeController"},
                      ];
    }
    return _titleArr;
}

@end
