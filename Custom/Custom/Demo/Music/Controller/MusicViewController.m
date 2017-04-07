//
//  ViewController.m
//  02
//
//  Created by admin on 17/4/6.
//  Copyright © 2017年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import "MusicViewController.h"
#import "PlayManager.h"
#import "MusicSlider.h"

@interface MusicViewController ()<PlayManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic)   IBOutlet UISlider *volumSlider;
@property (weak, nonatomic)   IBOutlet UILabel *curTime;
@property (weak, nonatomic)   IBOutlet UILabel *totleTime;
@property (weak, nonatomic)   IBOutlet MusicSlider *mySilder;
@property (nonatomic, strong) NSArray *listArr;
@property (nonatomic, strong) PlayManager *playerManager;
@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) NSInteger oldIndex;

@property (assign, nonatomic) BOOL isPlay;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation MusicViewController

+ (instancetype)sharedInstance {
    static MusicViewController *_sharedMusicVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Music" bundle:nil];
        _sharedMusicVC = [storyboard instantiateInitialViewController];
    });
    
    return _sharedMusicVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.index = 0;
    self.oldIndex = -1;
    
    self.playerManager = [PlayManager sharedPlayManager];
    self.playerManager.delegate = self;
    self.playerManager.player.volume = self.volumSlider.value;
    self.valueLabel.text = [NSString stringWithFormat:@"%zd", (NSInteger)(self.volumSlider.value * 100)];
    

    // 为播放器添加观察者,观察播放速率"rate".
    // 因为AVPlayer没有一个内部属性来标识当前的播放状态.所以我们可以通过rate变相的得到播放状态.
    // 这里观察播放速率rate,是为了获得播放/暂停的触发事件,作出相应的响应事件(比如更改button的文字).
    [self.playerManager.player addObserver:self forKeyPath:@"rate" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    
}



// 观察播放速率的相应方法: 速率==0 表示暂停.
// 速率不为0 表示播放中.
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"rate"]) {
        if ([[change valueForKey:@"new"] integerValue] == 0) {
//            NSLog(@"已经暂停");
        } else {
//            NSLog(@"正在播放");
        }
    }
}

//音量
- (IBAction)changeVolume:(UISlider *)sender {
    self.playerManager.player.volume = sender.value * 10;
    self.valueLabel.text = [NSString stringWithFormat:@"%zd", (NSInteger)(sender.value * 100)];
}

- (IBAction)changeSlider:(UISlider *)sender {
    [self.playerManager seekToTimeWithValue:sender.value];
}
- (IBAction)playOrPause:(UIButton *)sender {
    if (!self.isPlay) {
        // 准备播放
        [self.playerManager musicPrePlay:self.listArr[self.index]];
        self.isPlay = YES;
    }
    if (sender.selected) {
        [self.playerManager musicPause];
        sender.selected = NO;
    }else{
        [self.playerManager musicPlay];
        sender.selected = YES;
    }
}


-(IBAction)lastSongAction{
    self.isPlay = NO;
    if (self.index > 0) {
        self.index --;
    }else{
        self.index = self.listArr.count - 1;
    }
    [self playOrPause:nil];
    self.oldIndex = self.index;
}
-(IBAction)nextSongAction{
    self.isPlay = NO;
    if (self.index == self.listArr.count - 1) {
        self.index = 0;
    }else{
        self.index++;
    }
    [self playOrPause:nil]; 
    self.oldIndex = self.index;
}


#define mark - PlayManagerDelegate
-(void)getCurTiem:(NSString *)curTime Totle:(NSString *)totleTime Progress:(CGFloat)progress netValue:(NSTimeInterval)netValue{
    
    self.curTime.text = curTime;
    self.totleTime.text = totleTime;
    self.mySilder.value = progress;
    self.progressView.progress = netValue;

}
-(void)endOfPlayAction{
    NSLog(@"结束了");
    
    //结束后,下一首
    [self nextSongAction];
    self.isPlay = NO;
}



-(NSArray *)listArr{
    if (nil == _listArr) {
        _listArr = @[@"http://audio.xmcdn.com/group10/M05/75/E5/wKgDaVYCF86BKs5HAFP_JIZN4kk772.mp3",
                     @"http://audio.xmcdn.com/group16/M05/76/A2/wKgDbFYCF8nD_HoqACn_t_2W46k185.mp3",
                     @"http://audio.xmcdn.com/group10/M03/60/93/wKgDZ1XVNI2zozDCAJ5LjJa2r8Y149.mp3",
                     @"http://audio.xmcdn.com/group8/M07/61/15/wKgDYFXVNJ_xo2v9AE8l66BthNo757.mp3",
                     @"http://audio.xmcdn.com/group9/M05/63/B7/wKgDZlXay6CRkpNHAJjGfcefhqQ475.mp3",
                     @"http://audio.xmcdn.com/group7/M01/64/1B/wKgDWlXay_nhyQJ6AExjY15V7BE080.mp3",
                     @"http://audio.xmcdn.com/group8/M07/6A/39/wKgDYVXn-vPSYIb0AI0Fgh4YKdM936.mp3",
                     @"http://audio.xmcdn.com/group11/M07/76/60/wKgDbVXn-rrB8s5SAEaC5iIvm1c430.mp3",
                     @"http://audio.xmcdn.com/group12/M05/6B/2E/wKgDW1Xr15_wL_uJANSgH2IZYAU817.mp3",
                     @"http://audio.xmcdn.com/group8/M0B/6C/19/wKgDYVXr11WhCLh1AGpQNNlJ3No158.mp3",
                     @"http://audio.xmcdn.com/group16/M05/6C/6B/wKgDalXtAlqi030AAJadBSqKvVQ307.mp3",
                     @"http://audio.xmcdn.com/group13/M03/6C/A3/wKgDXVXtAnHCnCG0AEtOpzs-KF8749.mp3",
                     @"http://audio.xmcdn.com/group7/M06/6D/FD/wKgDX1Xv0nPQlxsbAJ7efR2SoVU021.mp3",
                     @"http://audio.xmcdn.com/group7/M06/6D/FD/wKgDX1Xv0neg0cveAE9vY0IcOYI327.mp3"];
    }
    return _listArr;
}

@end
