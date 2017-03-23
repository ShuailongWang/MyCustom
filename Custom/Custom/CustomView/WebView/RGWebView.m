//
//  RGWebView.m
//  RGApp
//
//  Created by admin on 17/3/23.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "RGWebView.h"

@interface RGWebView()

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *blueView;
@property (assign, nonatomic) NSInteger start;
@property (assign, nonatomic) BOOL backBool;
@property (assign, nonatomic) BOOL forwardBool;

@end

@implementation RGWebView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.start = 0;
        self.backBool = NO;
        self.forwardBool = NO;
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    if (nil == _redView) {
        _redView = [[UIView alloc]init];
        _redView.backgroundColor = [UIColor redColor];
        _redView.hidden = YES;
        [self addSubview:_redView];
    }
    if (nil == _blueView) {
        _blueView = [[UIView alloc]init];
        _blueView.backgroundColor = [UIColor blueColor];
        [self addSubview:_blueView];
    }
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:gesture];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.redView.frame = CGRectMake(-100, 100, 100, 50);
    self.redView.hidden = NO;
    self.blueView.frame = CGRectMake(KScreen_Width, 100, 100, 50);
}


#pragma mark === gesture===
- (void)panGesture:(UIPanGestureRecognizer *)sender{
    if (![self canGoBack] && ![self canGoForward]) {
        return;
    }

    //状态
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        CGPoint location = [sender locationInView:self];
        self.start = location.x;
        
    }else if (sender.state == UIGestureRecognizerStateChanged) {
        
        CGPoint location = [sender locationInView:self];
        if (location.x - self.start > 0 && [self canGoBack]) {
         
            self.redView.x = MIN(location.x - self.start, 100) - 100;
            self.backBool = YES;
            
        }else{
            if ([self canGoForward]) {
                self.blueView.x = KScreen_Width - MIN(-(location.x - self.start), 100);
                self.forwardBool = YES;
            }
        }
    }else if (sender.state == UIGestureRecognizerStateEnded) {
        self.redView.x = -100;
        self.blueView.x = KScreen_Width;
        self.start = 0;
        if (self.backBool) {
            [self goBack];
        }else if (self.forwardBool) {
            [self goForward];
        }
        self.backBool = NO;
        self.forwardBool = NO;
    }
}


@end
