//
//  RGAdManager.m
//  RGFZZD
//
//  Created by admin on 17/3/2.
//  Copyright © 2017年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import "RGAdManager.h"
#import "RGAdView.h"

#define DURATION 5

@interface RGAdManager()

@property (nonatomic, weak) RGAdView *launchView;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation RGAdManager

+(instancetype)launchViewManger{
    return [[[self class] alloc] init];
}

-(void)showView:(UIView *)view{
    self.frame = view.bounds;
    [view addSubview:self];
    
    //wind在最上面
    [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelAlert;
    
    [self addADLaunchView];
    [self loadData];
}

//初始化
- (void)addADLaunchView{
    RGAdView *adLaunchView = [[RGAdView alloc]initWithFrame:self.bounds];
    adLaunchView.skipBtn.hidden = YES;
    
    [adLaunchView.skipBtn addTarget:self action:@selector(skipADAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:adLaunchView];
    _launchView = adLaunchView;
}



- (void)loadData{
    // 启动倒计时
    [self scheduledGCDTimer];
}

//倒计时
- (void)scheduledGCDTimer{
    //结束倒计时
    [self cancleGCDTimer];
    
    //开始倒计时
    __block int timeLeave = DURATION; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    __typeof (self) __weak weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        if(timeLeave <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(weakSelf.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //关闭界面
                [self dismissController];
            });
        }else{
            int curTimeLeave = timeLeave;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面
                [weakSelf showSkipBtnTitleTime:curTimeLeave];
                
            });
            --timeLeave;
        }
    });
    dispatch_resume(_timer);
}

//显示倒计时秒数
- (void)showSkipBtnTitleTime:(int)timeLeave{
    NSString *timeLeaveStr = nil;
    if (timeLeave == 1) {
        timeLeaveStr = @"跳过";
    }else{
        timeLeaveStr = [NSString stringWithFormat:@"%ds",timeLeave];
    }
    
    
    [_launchView.skipBtn setTitle:timeLeaveStr forState:UIControlStateNormal];
    _launchView.skipBtn.hidden = NO;
}

//倒计时结束
- (void)cancleGCDTimer{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
//点击跳过按钮
- (void)skipADAction{
    [self dismissController];
}

//消失动画
- (void)dismissController{
    //定制倒计时
    [self cancleGCDTimer];
    //消失动画
    [UIView animateWithDuration:0.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //缩放修改处
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc{
    [self cancleGCDTimer];
    //wind在默认
    [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelNormal;
}

@end
