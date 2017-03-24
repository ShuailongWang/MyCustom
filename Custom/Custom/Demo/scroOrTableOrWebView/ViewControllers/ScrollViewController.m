//
//  ScrollViewController.m
//  Custom
//
//  Created by admin on 17/3/24.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"Scroll View"];
    [self setupUI];
}
-(void)setupUI{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_scrollView];
    }
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 320, 40)];
    [label setText:@"My content"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [self.scrollView addSubview:label];
    [self.view setBackgroundColor:[UIColor colorWithRed:80.0/255.0 green:110.0/255.0 blue:130.0/255.0 alpha:1]];
    [self.scrollView setBackgroundColor:[UIColor colorWithRed:80.0/255.0 green:110.0/255.0 blue:130.0/255.0 alpha:1]];
    
    // Let's fake some content
    [self.scrollView setContentSize:CGSizeMake(320, 840)];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [self followScrollView:self.scrollView];
}


@end
