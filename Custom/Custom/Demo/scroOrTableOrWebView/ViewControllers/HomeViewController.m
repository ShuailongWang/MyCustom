//
//  HomeViewController.m
//  Custom
//
//  Created by admin on 17/3/24.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "HomeViewController.h"
#import "ScrollViewController.h"
#import "TableViewController.h"
#import "WebViewController.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *titleArr;

@end

static NSString *UITableViewCellID = @"HomeViewControllerID";



@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
            ScrollViewController *CustomVC = [[ScrollViewController alloc]init];
            [self.navigationController pushViewController:CustomVC animated:YES];
        }
            break;
        case 1:{
            TableViewController *CustomVC = [[TableViewController alloc]init];
            [self.navigationController pushViewController:CustomVC animated:YES];
        }
            break;
        case 2:{
            WebViewController *CustomVC = [[WebViewController alloc]init];
            [self.navigationController pushViewController:CustomVC animated:YES];
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
                      @"ScrollViewController",
                      @"tableViewController",
                      @"webViewController"
                      ];
    }
    return _titleArr;
}


@end
