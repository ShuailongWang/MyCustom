//
//  WebVideoVController.m
//  Custom
//
//  Created by admin on 17/3/24.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "WebVideoVController.h"
#import "AppDelegate.h"

@interface WebVideoVController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) AppDelegate *app;

@end

@implementation WebVideoVController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

-(void)setupUI{
    if (nil == _app) {
        _app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    }
    if (nil == _webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate=self;
        _webView.scrollView.bounces = NO;
        _webView.scalesPageToFit = YES;
        _webView.opaque = NO;
        [self.view addSubview:_webView];
    }
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.tudou.com/albumplay/KwvzbxLDWls/IaAVez1vTIw.html"]]];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.webView.frame = self.view.bounds;
}


#pragma mark - UIWebDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //通知写在这里是因为网页加载完成但是没有播放视频,也会调用playerWillExitFullscreen方法
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeHiddenNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeVisibleNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerWillExitFullscreen:) name:UIWindowDidBecomeHiddenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerWillShowFullScreen:) name:UIWindowDidBecomeVisibleNotification object:nil];
}
//播放视频
-(void)playerWillShowFullScreen:(id)sender{
    NSLog(@"播放视频了");
    self.app.isFull = YES;
}
//退出播放视频
-(void)playerWillExitFullscreen:(id)sender{
    NSLog(@"退出播放视频了");
    self.app.isFull = NO;
    
    //如果点击视频,自动旋转为横屏播放状态,点击完成按钮,需要是程序变为竖屏状态,需要下边的代码
    UIViewController *vc = [[UIViewController alloc]init];
    [self presentViewController:vc animated:NO completion:nil];
    [vc dismissViewControllerAnimated:NO completion:nil];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeHiddenNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeVisibleNotification object:nil];
}

@end
