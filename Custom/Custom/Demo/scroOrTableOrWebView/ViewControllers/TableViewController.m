//
//  TableViewController.m
//  Custom
//
//  Created by admin on 17/3/24.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;


@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setTitle:@"Table View"];
    [self setupUI];
}

-(void)setupUI{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [self.view addSubview:_tableView];
    }
    // Set the barTintColor. This will determine the overlay that fades in and out upon scrolling.
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:60.0/255.0 green:1 blue:150.0/255.0 alpha:1]];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    // Just call this line to enable the scrolling navbar
    [self followScrollView:self.tableView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Identifier"];
    }
    
    cell.textLabel.text = @[@"Awesome content", @"Great content", @"Amazing content", @"Ludicrous content"][arc4random()%4];
    
    return cell;
}

@end
