//
//  WebImageViewController.m
//  Custom
//
//  Created by admin on 17/3/24.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "WebImageViewController.h"
#import "UIButton+WebCache.h"

@interface WebImageViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *wekwebView;
@property (nonatomic, strong) UIButton *imagePreviewButton;

@end

@implementation WebImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置UI
    [self setupUI];
    
    //
    NSString *url = @"http://www.jianshu.com/p/1142e5dafd4d";
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL];
    [self.wekwebView loadRequest:request];
}
-(void)setupUI{
    
    if (nil == _wekwebView) {
        _wekwebView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _wekwebView.delegate = self;
        _wekwebView.scrollView.bounces = NO;
        _wekwebView.scalesPageToFit = YES;
        _wekwebView.opaque = NO;
        [self.view addSubview:_wekwebView];
    }
    if (nil == _imagePreviewButton) {
        _imagePreviewButton = [[UIButton alloc]initWithFrame:self.view.bounds];
        _imagePreviewButton.alpha = 0;
        [_imagePreviewButton addTarget:self action:@selector(onImagePreviewButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        _imagePreviewButton.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_imagePreviewButton];
    }
    
}
//图片按钮点击事件
- (void)onImagePreviewButtonPressed:(id)sender {
    [UIView animateWithDuration:0.2f animations:^{
        self.imagePreviewButton.alpha = 0.0f;
    }];
}


#pragma mark - UIWebDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //预览图片
    if ([request.URL.scheme isEqualToString:@"image-preview"]) {
        NSString* path = [request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
        path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [self.imagePreviewButton sd_setImageWithURL:[NSURL URLWithString:path] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default"]];
        
        [UIView animateWithDuration:0.2f animations:^{
            self.imagePreviewButton.alpha = 1.0f;
        }];
        
        return NO;
    }
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.wekwebView stringByEvaluatingJavaScriptFromString:@"function assignImageClickAction(){var imgs=document.getElementsByTagName('img');var length=imgs.length;for(var i=0;i<length;i++){img=imgs[i];img.onclick=function(){window.location.href='image-preview:'+this.src}}}"];
    
    [self.wekwebView stringByEvaluatingJavaScriptFromString:@"assignImageClickAction();"];
}


@end
