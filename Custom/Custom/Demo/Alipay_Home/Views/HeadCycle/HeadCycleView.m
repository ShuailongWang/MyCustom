//
//  HeadCycleView.m
//  支付宝首页
//
//  Created by admin on 17/4/10.
//  Copyright © 2017年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import "HeadCycleView.h"

@interface HeadCycleView()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *scrollView;
@property (nonatomic, strong) NSArray *iconUrlArr;

@end

@implementation HeadCycleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    if (nil == _scrollView) {
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:[UIImage imageNamed:@"404"]];
        _scrollView.currentPageDotImage = [UIImage imageNamed:@"轮播图选中圆点"];
        _scrollView.pageDotImage = [UIImage imageNamed:@"轮播图未选中圆点"];
        _scrollView.imageURLStringsGroup = self.iconUrlArr;
        [self addSubview:_scrollView];
    }
}


#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    if ([self.delegate respondsToSelector:@selector(HeadCycleView:index:)]) {
        [self.delegate HeadCycleView:self index:index];
    }
}


-(NSArray *)iconUrlArr{
    if (nil == _iconUrlArr) {
        _iconUrlArr = @[
                        @"http://i4.piimg.com/11340/7f638e192b9079e6.jpg",
                        @"http://pic.58pic.com/58pic/13/75/13/01e58PICgPY_1024.jpg",
                        @"http://img.taopic.com/uploads/allimg/120828/214833-120RQ5521568.jpg"
                        ];
    }
    return _iconUrlArr;
}

@end
