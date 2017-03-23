//
//  RGHomeController.m
//  RGApp
//
//  Created by admin on 17/3/22.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "RGHomeController.h"
#import "RGWebProgressLayer.h"
#import "RGWebView.h"
#import "JYCustomWebViewProtocol.h"

@interface RGHomeController ()<UIWebViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) RGWebView *wekwebView;
@property (nonatomic, strong) RGWebProgressLayer *progressLayer;

@end

@implementation RGHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [JYCustomWebViewProtocol startListeningNetWorking];
    
    //设置UI
    [self setupUI];
    
    //
    NSString *url = @"http://www.rgpsy.com:8080/rzxl/login.do";
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL];
    [self.wekwebView loadRequest:request];
}
-(void)setupUI{
    
    if (nil == _wekwebView) {
        _wekwebView = [[RGWebView alloc]initWithFrame:self.view.bounds];
        _wekwebView.delegate = self;
        _wekwebView.scrollView.bounces = NO;
        _wekwebView.scalesPageToFit = YES;
        _wekwebView.opaque = NO;
        [self.view addSubview:_wekwebView];
    }
    if (nil == _progressLayer) {
        _progressLayer = [[RGWebProgressLayer alloc]init];
        _progressLayer.frame = CGRectMake(0, 42, KScreen_Width, 2);
        
        [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
        [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
    }

}

#pragma mark - UIWebViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{


    //获取此时的URL
//    NSURL *url = [request URL];
//    NSString *completeString = [url absoluteString];
//
//    //第一步:检测链接中的特殊字段
//    NSString *needCheckStr = @"gameFrontGame.do?id";
//    NSRange jumpRange = [completeString rangeOfString:needCheckStr];
//    if (jumpRange.location != NSNotFound) {

//        return NO;
//    } 
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_progressLayer startLoad];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [_progressLayer finishedLoad];
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];


    //
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressLayer finishedLoad];
}

//
- (void)dealloc {
    [_progressLayer closeTimer];
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
}

//
-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.wekwebView.frame = self.view.bounds;
}

@end
