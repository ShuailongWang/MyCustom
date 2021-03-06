//
//  PlayManager.m
//  02
//
//  Created by admin on 17/4/6.
//  Copyright © 2017年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import "PlayManager.h"

@interface PlayManager()

@property (nonatomic, strong) AVPlayerItem *currentItem;
@property (nonatomic, strong) NSTimer *timer;
@property (assign, nonatomic) NSTimeInterval scale;

@end

@implementation PlayManager

+ (instancetype)sharedPlayManager {
    static PlayManager *_playManger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _playManger = [[self alloc] init];
    });
    return _playManger;
}


- (instancetype)init{

    if (self = [super init]) {
        _player = [[AVPlayer alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endOfPlay:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

-(void) endOfPlay:(NSNotification *)sender{

    [self musicPause];
    [self.delegate endOfPlayAction];
}

//准备播放
-(void)musicPrePlay:(NSString*)url{

    //先移除item的status添加观察者.
    if (self.player.currentItem) {
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
        [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    }
    
    // 根据传入的URL(MP3歌曲地址),创建一个item对象
    // initWithURL的初始化方法建立异步链接. 什么时候连接建立完成我们不知道.但是它完成连接之后,会修改自身内部的属性status. 所以,我们要观察这个属性,当它的状态变为AVPlayerItemStatusReadyToPlay时,我们便能得知,播放器已经准备好,可以播放了.
    AVPlayerItem * item = [[ AVPlayerItem alloc] initWithURL:[NSURL URLWithString:url]];
    
    
    // 为item的status添加观察者.
    [item addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    //KVO监听音乐缓冲状态
    [item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    // 用新创建的item,替换AVPlayer之前的item.新的item是带着观察者的哦.
    [self.player replaceCurrentItemWithPlayerItem:item];
}


//观察的是Item的status状态.
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"status"]) {
        switch ([[change valueForKey:@"new"] integerValue]) {
            case AVPlayerItemStatusUnknown:
//                NSLog(@"不知道什么错误");
                break;
            case AVPlayerItemStatusReadyToPlay:
                // 只有观察到status变为这种状态,才会真正的播放.
                [self musicPlay];
                break;
            case AVPlayerItemStatusFailed:
                
//                NSLog(@"准备失败");
                break;
            default:
                break;
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
        NSArray * timeRanges = self.player.currentItem.loadedTimeRanges;
        //本次缓冲的时间范围
        CMTimeRange timeRange = [timeRanges.firstObject CMTimeRangeValue];
        //缓冲总长度
        NSTimeInterval totalLoadTime = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration);
        //音乐的总时间
        NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
        //计算缓冲百分比例
        NSTimeInterval scale = totalLoadTime/duration;
        self.scale = scale;
    }
}

// 播放
-(void)musicPlay{
    // 如果计时器已经存在了,说明已经在播放中,直接返回.
    // 对于已经存在的计时器,只有musicPause方法才会使之停止和注销.
    if (self.timer != nil) {
        return;
    }
    
    // 播放后,我们开启一个计时器.
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
    [self.player play];
}

-(void)timerAction:(NSTimer * )sender{
    // !! 计时器的处理方法中,不断的调用代理方法,将播放进度返回出去.
    // 一定要掌握这种形式.
    [self.delegate getCurTiem:[self valueToString:[self getCurTime]] Totle:[self valueToString:[self getTotleTime]] Progress:[self getProgress] netValue: self.scale];
}

// 暂停方法
-(void)musicPause{
    [self.timer invalidate];
    self.timer = nil;
    [self.player pause];
}

// 跳转方法
-(void)seekToTimeWithValue:(CGFloat)value{
    // 先暂停
    [self musicPause];
    
    // 跳转
    [self.player seekToTime:CMTimeMake(value * [self getTotleTime], 1) completionHandler:^(BOOL finished) {
        if (finished == YES) {
            [self musicPlay];
        }
    }];
}

// 获取当前的播放时间
-(NSInteger)getCurTime{
    
    if (self.player.currentItem) {
        // 用value/scale,就是AVPlayer计算时间的算法. 它就是这么规定的.
        // 下同.
        return self.player.currentTime.value / self.player.currentTime.timescale;
    }
    return 0;
}

// 获取总时长
-(NSInteger)getTotleTime{
    CMTime totleTime = [self.player.currentItem duration];
    if (totleTime.timescale == 0) {
        return 1;
    } else {
        return totleTime.value /totleTime.timescale;
    }
}
// 获取当前播放进度
-(CGFloat)getProgress{
    return (CGFloat)[self getCurTime]/ (CGFloat)[self getTotleTime];
}

// 将整数秒转换为 00:00 格式的字符串
-(NSString *)valueToString:(NSInteger)value{
    return [NSString stringWithFormat:@"%.2ld:%.2ld",value/60,value%60];
}

@end
