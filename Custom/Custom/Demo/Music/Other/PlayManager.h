//
//  PlayManager.h
//  02
//
//  Created by admin on 17/4/6.
//  Copyright © 2017年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol PlayManagerDelegate <NSObject>

//当前时间, 总时间, 进度
-(void)getCurTiem:(NSString *)curTime Totle:(NSString *)totleTime Progress:(CGFloat)progress netValue:(NSTimeInterval)netValue;
// 播放结束之后, 如何操作由外部决定.
-(void)endOfPlayAction;

@end

@interface PlayManager : NSObject

@property (nonatomic, strong) AVPlayer *player;
@property (weak, nonatomic) id<PlayManagerDelegate> delegate;


+(instancetype)sharedPlayManager;
-(void)musicPlay;       // 播放音乐
-(void)musicPause;      // 暂停音乐
-(void)musicPrePlay:(NSString*)url;    // 准备播放
-(void)seekToTimeWithValue:(CGFloat)value;  // 前进或者后退


@end
