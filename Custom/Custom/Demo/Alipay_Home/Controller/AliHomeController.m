//
//  AliHomeController.m
//  Custom
//
//  Created by admin on 17/4/10.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "AliHomeController.h"
#import "MyTableView.h"
#import "HeadCycleView.h"
#import "FunctionView.h"

#define offsetNor  310     //偏移

@interface AliHomeController ()<UIScrollViewDelegate, HeadCycleViewDelegate, FunctionViewDelegate>

@property (nonatomic, strong) UIScrollView *myScrollView;   //scrollview
@property (nonatomic, strong) UIView *topHeadView;             //头部
@property (nonatomic, strong) HeadCycleView *headCycleView;
@property (nonatomic, strong) FunctionView *functionView;         //功能
@property (nonatomic, strong) MyTableView *myTableView;     //tableView

@end

@implementation AliHomeController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBagroundColor;
    
    [self setupUI];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //tableView的contendtSize
    CGSize size = self.myTableView.contentSize;
    //加上偏移
    size.height += offsetNor;
    //scrolleView的contentSize
    self.myScrollView.contentSize = size;
    //tableview的高 = contentSize.height + 偏移
    self.myTableView.height = size.height;
}

-(void)setupUI{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;   //避免tabBar遮挡
    //总
    if (nil == _myScrollView) {
        _myScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _myScrollView.scrollIndicatorInsets = UIEdgeInsetsMake(offsetNor, 0, 0, 0);
        //跟着view同时调整尺寸
        _myScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _myScrollView.delegate = self;
        [self.view addSubview:_myScrollView];
    }
    //头部
    if (nil == _topHeadView) {
        _topHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreen_Width, offsetNor)];
        [_myScrollView addSubview:_topHeadView];
    }
    if (nil == _headCycleView) {
        _headCycleView = [[HeadCycleView alloc]initWithFrame:CGRectMake(0, 0, KScreen_Width, 160)];
        _headCycleView.delegate = self;
        [_topHeadView addSubview:_headCycleView];
    }
    //功能
    if (nil == _functionView) {
        _functionView = [[FunctionView alloc]initWithFrame:CGRectMake(0, _headCycleView.bottom, KScreen_Width, 140)];
        _functionView.backgroundColor = [UIColor blueColor];
        _functionView.delegate = self;
        [_topHeadView addSubview:_functionView];
    }
    //tableView
    if (nil == _myTableView) {
        _myTableView = [[MyTableView alloc]initWithFrame:CGRectMake(0, offsetNor, KScreen_Width, _myScrollView.height - offsetNor) style:UITableViewStyleGrouped];
        
        [_myScrollView addSubview:_myTableView];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        //整体不动
        self.headCycleView.y = offsetY;   //轮播
        self.functionView.y = offsetY + self.headCycleView.height;    //功能
        self.myTableView.y = offsetY + offsetNor;   //表格
        
        //偏移量给到tableview，tableview自己来滑动
        self.myTableView.contentOffsetY = offsetY;
        
        //滑动太快有时候不正确，这里是保护topHeadView 的frame为正确的。
        self.topHeadView.y = 0;
    } else {
        //视差处理
        self.topHeadView.y = offsetY/2;
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 松手时判断是否刷新
    CGFloat y = scrollView.contentOffset.y;
    if (y < - 65) {
        [self.myTableView startRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.myTableView endRefreshing];
        });
    }
}


#pragma mark - FunctionViewDelegate
-(void)didSelectIitem{
    NSLog(@"1");
}
#pragma mark - HeadCycleViewDelegate
-(void)HeadCycleView:(HeadCycleView *)headCycleView index:(NSInteger)index{
    NSLog(@"%zd", index);
}

@end
