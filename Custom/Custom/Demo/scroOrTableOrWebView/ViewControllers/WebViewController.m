//
//  WebViewController.m
//  Custom
//
//  Created by admin on 17/3/24.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (strong, nonatomic) UIWebView *webView;


@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"Web View"];
    
    [self setupUI];
}

-(void)setupUI{
    if (nil == _webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.scrollView.bounces = NO;
        _webView.scalesPageToFit = YES;
        _webView.opaque = NO;
        [self.view addSubview:_webView];
    }
    
    NSMutableString* html = [@"<html><head></head><body>" mutableCopy];
    
    [html appendString:@"<h1>The content</h1><p>Long content here</p><p>Some other content here</p>"];
    [html appendString:@"<h1>Other content</h1><p>Long content here</p><p>Some other content here</p>"];
    [html appendString:@"<h1>My content</h1><p>Long content here</p><p>Some other content here</p>"];
    [html appendString:@"</body></html>"];
    [self.webView loadHTMLString:html baseURL:nil];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:66.0/255.0 green:155.0/255.0 blue:255.0/255.0 alpha:1]];
    
    [self followScrollView:self.webView];
}


@end
