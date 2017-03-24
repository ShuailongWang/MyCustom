//
//  RGAdView.m
//  RGFZZD
//
//  Created by admin on 17/3/2.
//  Copyright © 2017年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import "RGAdView.h"

@interface RGAdView()

@property (strong, nonatomic) CALayer *smallSayLayer;//小云
@property (strong, nonatomic) CALayer *bigSayLayer;//大云
@property (strong, nonatomic) CALayer *reportLayer;//报告
@property (strong, nonatomic) CALayer *testLayer;//测评
@property (strong, nonatomic) CALayer *classLayer;//课程
@property (strong, nonatomic) CALayer *applyLayer;//申请
@property (nonatomic, strong) CALayer *personLayer;//人物

@end

@implementation RGAdView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //背景
        [self addlaunchImageView];
        
        //动画
        [self addAdImageView];
        
        //按钮
        [self addSkipBtn];
    }
    return self;
}

//背景
- (void)addlaunchImageView{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    imageView.image = [UIImage imageNamed:@"发展指导-伴我成长"];
    [self addSubview:imageView];
    _launchImageView = imageView;
}

//动画
- (void)addAdImageView{
    //时
    CGFloat duration = 4;
    
    CAAnimationGroup *bigAnim = [CAAnimationGroup animation];
    bigAnim.removedOnCompletion = NO;
    bigAnim.fillMode = kCAFillModeForwards;
    bigAnim.animations = @[[self creatLinehPath:CGPointMake(-150, 66) endPoint:CGPointMake(127, 66)]];
    //    zeroAnim.beginTime = CACurrentMediaTime() + 2;
    bigAnim.duration = duration;
    [self.bigSayLayer addAnimation:bigAnim forKey:nil];
    
    
    CAAnimationGroup *smallAnim = [CAAnimationGroup animation];
    smallAnim.removedOnCompletion = NO;
    smallAnim.fillMode = kCAFillModeForwards;
    smallAnim.animations = @[[self creatLinehPath:CGPointMake(-100, 96) endPoint:CGPointMake(self.size.width - 135, 120)]];
    smallAnim.duration = duration;
    [self.smallSayLayer addAnimation:smallAnim forKey:nil];
    
    
    CAAnimationGroup *applyAnim = [CAAnimationGroup animation];
    applyAnim.removedOnCompletion = NO;
    applyAnim.fillMode = kCAFillModeForwards;
    applyAnim.animations = @[[self creatAnimationWithPath:-M_PI_4 endAngle: M_PI*2 - M_PI_4]];
    applyAnim.duration = duration;
    [self.applyLayer addAnimation:applyAnim forKey:nil];
    
    
    CAAnimationGroup *classAnim = [CAAnimationGroup animation];
    classAnim.removedOnCompletion = NO;
    classAnim.fillMode = kCAFillModeForwards;
    classAnim.animations = @[[self creatAnimationWithPath:M_PI_4 endAngle: M_PI*2 + M_PI_4]];
    classAnim.duration = duration;
    [self.classLayer addAnimation:classAnim forKey:nil];
    
    
    CAAnimationGroup *testAnim = [CAAnimationGroup animation];
    testAnim.removedOnCompletion = NO;
    testAnim.fillMode = kCAFillModeForwards;
    testAnim.animations = @[[self creatAnimationWithPath:M_PI_2 + M_PI_4 endAngle: M_PI*2 + M_PI_2 + M_PI_4]];
    testAnim.duration = duration;
    [self.testLayer addAnimation:testAnim forKey:nil];
    
    CAAnimationGroup *reportAnim = [CAAnimationGroup animation];
    reportAnim.removedOnCompletion = NO;
    reportAnim.fillMode = kCAFillModeForwards;
    reportAnim.animations = @[[self creatAnimationWithPath:M_PI + M_PI_4/3 endAngle: M_PI*2 + M_PI + M_PI_4/3]];
    reportAnim.duration = duration;
    [self.reportLayer addAnimation:reportAnim forKey:nil];
    
    //人物
    if (nil == _personLayer) {
        UIImage *image = [UIImage imageNamed:@"人物"];
        _personLayer = [CALayer layer];
        _personLayer.bounds = CGRectMake(0, 0, image.size.width, image.size.height + 30);
        _personLayer.position = CGPointMake(self.center.x - 20, self.center.y);
        _personLayer.contents = (__bridge id)image.CGImage;
        [self.layer addSublayer:_personLayer];
    }
}

//按钮
- (void)addSkipBtn{
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    skipBtn.backgroundColor = RGB(41, 157, 200);
    skipBtn.frame = CGRectMake(KScreen_Width - 60, 15, 50, 30);
    skipBtn.titleLabel.textColor = [UIColor whiteColor];
    skipBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    skipBtn.alpha = 0.92;
    skipBtn.layer.cornerRadius = 12.0;
    skipBtn.clipsToBounds = YES;
    [self addSubview:skipBtn];
    _skipBtn = skipBtn;
}

//MARK: - 创建路径
//圆
-(CAAnimation*)creatAnimationWithPath:(CGFloat)startAngle endAngle:(CGFloat)endAngle{
    //动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.center radius:150 startAngle:startAngle endAngle:endAngle clockwise:1];
    anim.path = path.CGPath;
    
    return anim;
}
//直线
-(CAAnimation*)creatLinehPath:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    //动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    anim.path = path.CGPath;
    
    return anim;
}

//MARK: -
-(CALayer *)smallSayLayer{
    if (nil == _smallSayLayer) {
        _smallSayLayer = [self creatCalayerWithImageName:@"小白云"];
        [self.layer addSublayer:_smallSayLayer];
    }
    return _smallSayLayer;
}
-(CALayer *)bigSayLayer{
    if (nil == _bigSayLayer) {
        _bigSayLayer = [self creatCalayerWithImageName:@"大白云"];
        [self.layer addSublayer:_bigSayLayer];
    }
    return _bigSayLayer;
}
-(CALayer *)reportLayer{
    if (nil == _reportLayer) {
        _reportLayer = [self creatCalayerWithImageName:@"报告"];
        [self.layer addSublayer:_reportLayer];
    }
    return _reportLayer;
}
-(CALayer *)testLayer{
    if (nil == _testLayer) {
        _testLayer = [self creatCalayerWithImageName:@"测评"];
        [self.layer addSublayer:_testLayer];
    }
    return _testLayer;
}
-(CALayer *)classLayer{
    if (nil == _classLayer) {
        _classLayer = [self creatCalayerWithImageName:@"课程表"];
        [self.layer addSublayer:_classLayer];
    }
    return _classLayer;
}
-(CALayer *)applyLayer{
    if (nil == _applyLayer) {
        _applyLayer = [self creatCalayerWithImageName:@"申请"];
        [self.layer addSublayer:_applyLayer];
    }
    return _applyLayer;
}


-(CALayer*)creatCalayerWithImageName:(NSString*)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(-100, -100, image.size.width, image.size.height);
    layer.contents = (__bridge id)image.CGImage;
    
    return layer;
}



@end
