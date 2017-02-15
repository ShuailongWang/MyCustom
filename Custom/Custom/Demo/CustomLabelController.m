//
//  CustomLabelController.m
//  Custom
//
//  Created by admin on 17/2/15.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "CustomLabelController.h"
#import "CustomView.h"

#define KScreen_Width  [UIScreen mainScreen].bounds.size.width
#define KScreen_Height  [UIScreen mainScreen].bounds.size.height
#define KScreen_Bounds  [UIScreen mainScreen].bounds

@interface CustomLabelController ()<CustomViewDelegate>

@property (nonatomic, strong) NSArray *labelArr;

@end

@implementation CustomLabelController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self setupUI];
}

-(void)setupUI{
    CustomView *cusView = [[CustomView alloc] initWithFrame:CGRectMake(0, 200, KScreen_Width, 0)];
    cusView.customDelegate = self;
    //    Block
    //    cusView.myBlock = ^(CGFloat viewHeight){
    //        NSLog(@"block -- %f", viewHeight);
    //    };
    cusView.labelArr = self.labelArr;
    
    
    [self.view addSubview:cusView];
}
-(void)CustomView:(CustomView *)customView viewHeight:(CGFloat)viewHeight{
    NSLog(@"%f", viewHeight);
}

-(NSArray *)labelArr{
    if (nil == _labelArr) {
        _labelArr = @[@"大家",@"你是什么",@"是不是呢",@"想要什么呢",@"吃大餐了哦哦哦",@"技术部的大牛",@"商场部的技术",@"全体人员注意了。开始了",@"大家",@"你是什么",@"是不是呢",@"想要什么呢",@"吃大餐了哦哦哦",@"技术部的大牛",@"商场部的技术",@"全体人员注意了。开始了",@"大家",@"你是什么",@"是不是呢",@"想要什么呢",@"吃大餐了哦哦哦",@"技术部的大牛",@"商场部的技术",@"全体人员注意了。开始了",@"大家",@"你是什么",@"是不是呢",@"想要什么呢",@"吃大餐了哦哦哦",@"技术部的大牛",@"商场部的技术",@"全体人员注意了。开始了"];
    }
    return _labelArr;
}

@end

