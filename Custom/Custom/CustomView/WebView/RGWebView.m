//
//  RGWebView.m
//  RGApp
//
//  Created by admin on 17/3/23.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "RGWebView.h"

#define KWidth 50
#define kHeight 30
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
        _redView.backgroundColor = [UIColor grayColor];
        [self addSubview:_redView];
    }
    if (nil == _blueView) {
        _blueView = [[UIView alloc]init];
        _blueView.backgroundColor = [UIColor grayColor];
        [self addSubview:_blueView];
    }
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:gesture];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.redView.frame = CGRectMake(-KWidth, KWidth, KWidth, kHeight);
    self.blueView.frame = CGRectMake(KScreen_Width, KWidth, KWidth, kHeight);
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
            
            self.redView.x = MIN(location.x - self.start, KWidth) - KWidth;
            if (location.x - self.start > KWidth) {
                self.backBool = YES;
            }
            
        }else if (location.x - self.start < 0 && [self canGoBack]) {
            if ([self canGoForward]) {
                self.blueView.x = KScreen_Width - MIN(-(location.x - self.start), KWidth);
                if (ABS(location.x - self.start) > KWidth) {
                    self.forwardBool = YES;
                }
            }
        }
    }else if (sender.state == UIGestureRecognizerStateEnded) {
        self.redView.x = -KWidth;
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
