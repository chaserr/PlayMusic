//
//  RootViewController.m
//  PlayMusic

//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "RootViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayMusic.h"
@interface RootViewController ()<AVAudioPlayerDelegate>
@property (nonatomic ,retain) AVAudioPlayer *audioPlayer;
@property (nonatomic, retain) PlayMusic *playMusicView;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSTimer *rotationTimer;
@property (nonatomic, retain) NSMutableArray *musicNameArray; // 存放音乐名列表
@property (nonatomic, retain) NSMutableArray *musicArray; // 存放音乐的列表
@property (nonatomic, assign) NSUInteger index;// 记录当前播放歌曲
@property (nonatomic, retain) UIRotationGestureRecognizer *rotationGR;
@property (nonatomic, retain) UILabel *allTimeLabel;
//@property (nonatomic, retain) NSString *currentTime;
//@property (nonatomic, retain) NSString *allTime;
@end

@implementation RootViewController

- (void)loadView{
    
    self.playMusicView = [[PlayMusic alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _playMusicView;
    [_playMusicView release];
    

}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
  
    //设置歌曲
    [self play_song];
    
    //音量设置
    [self play_volum];
    
    //进度条
    [self play_time];
    
    //上下曲
    [self play_play];
    
    // 音乐播放器初始化
    [self doPlayMusic];
    

    //设置后台运行
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
    //设置图片上的停止播放和按钮停止播放同步
    [self.playMusicView.roundView  initWithTarget:self Action:@selector(playRotation:)];
    
    
    
    
    
}


- (void)doPlayMusic{
    
   
    
    //初始化歌曲数组
    self.musicArray = [NSMutableArray array];
   // [self.musicArray addObject:@"123"];
    [self.musicArray addObject:@"nashinianshao"];
    [self.musicArray addObject:@"wangshisuifeng"];
    [self.musicArray addObject:@"shengxiadeguoshi"];
    
    self.musicNameArray = [NSMutableArray array];
  //  [self.musicNameArray addObject:@"你说我容易吗.mp3"];
    [self.musicNameArray addObject:@"那时年少.mp3"];
    [self.musicNameArray addObject:@"往事随风.mp3"];
    [self.musicNameArray addObject:@"盛夏的果实.mp3"];
    
    
    
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:self.musicArray[0] ofType:@"mp3"];
    
//    NSString *filePath1 = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSLog(@"%@", filePath);
//    NSLog(@"%@", filePath1);
    
//    NSURL *musicURL  = [[NSBundle mainBundle] URLForResource:self.musicNameArray[0] withExtension:@"mp3" subdirectory:@"Resource/Music"];

    NSURL *musicUrl = [NSURL URLWithString:filePath];
    // 使用一个NSError对象来接受错误信息
    NSError *error= nil;
    
    // 创建AVAudioPlayer对象
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:&error];
    
    //设置音量初始值
    self.audioPlayer.volume = self.playMusicView.volumSlide.value;
    
    //记录当前默认播放第0首
    _index = 0;
    
    //获取歌曲总时长
    self.playMusicView.timeSlide.maximumValue = self.audioPlayer.duration;
    
    //修改声音
    self.audioPlayer.volume = self.playMusicView.volumSlide.value;
    
    //修改时间进度
    self.playMusicView.timeSlide.maximumValue = self.audioPlayer.duration;
    
    //准备播放

    [self.audioPlayer prepareToPlay];
       
    //显示正在播放的歌曲名

    
//        self.playMusicView.nameLabel.text = @"第一首歌";
//    self.audioPlayer.volume = 1;
    
     NSLog(@"time:%f",_audioPlayer.duration);
    //显示歌曲时长
    
    
}




- (void)play_song{
    
    self.playMusicView.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.playMusicView.nameLabel.textColor = [UIColor whiteColor];
    self.playMusicView.nameLabel.text = @"请点击播放";
//    self.playMusicView.nameLabel.textColor = [UIColor whiteColor];
    
}

- (void)play_volum{
    
    self.playMusicView.volumSlide.value = 0.3;
    [self.playMusicView.volumSlide addTarget:self action:@selector(changeVolue:) forControlEvents:(UIControlEventValueChanged)];
    
    
}


- (void)play_time{
    [self.playMusicView.timeSlide addTarget:self action:@selector(changeTime:) forControlEvents:(UIControlEventValueChanged)];
    
   
    
}

- (void)play_play{
    
    [self.playMusicView.leftButton addTarget:self action:@selector(preSong:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.playMusicView.playButton addTarget:self action:@selector(playMusic) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.playMusicView.rightButton addTarget:self action:@selector(nextSong:) forControlEvents:(UIControlEventTouchUpInside)];
    
}


- (void)changeVolue:(UISlider *)slider{
    self.audioPlayer.volume = slider.value;
    
}

- (void)changeTime:(UISlider *)slider{
    self.audioPlayer.currentTime =slider.value;
    
    //显示时长
//    self.playMusicView.durationLabel.text = [NSString stringWithFormat:@"%f",_audioPlayer.currentTime];
    
}

- (void)playSong:(UIButton *)button{
    

    if ([[button titleForState:(UIControlStateNormal)] isEqualToString:@"播放"]) {
        NSLog(@"播放");
        [self.audioPlayer play];
        
        self.audioPlayer.numberOfLoops = -1;
       
        self.playMusicView.nameLabel.text = self.musicNameArray[_index];
        [button setTitle:@"暂停" forState:(UIControlStateNormal)];
        
        
//        self.rotationGR = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGR:)];
        self.playMusicView.imageView.userInteractionEnabled = YES;
//        [self.playMusicView.imageView addGestureRecognizer:_rotationGR];
//        [_rotationGR release];
        
        //使用旋转手势加定时器对图片进行旋转不流畅
//        self.rotationTimer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(rotationGRAction:) userInfo:nil repeats:YES];

        
        
        
        //添加定时器
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tiamchange:) userInfo:nil repeats:YES];
        
    }else{
        NSLog(@"暂停");
        [self.audioPlayer pause];
//
        [button setTitle:@"播放" forState:(UIControlStateNormal)];
        //计时器停止
        [self.timer invalidate];
        [self.rotationTimer invalidate];
    }
}

//播放音乐
- (void)playMusic{
    [self buttonToRotation];
    [self playSong:_playMusicView.playButton];
   
}

// 实现按下按钮同步图片旋转
- (void)buttonToRotation{
    
    _playMusicView.roundView.isPlay = !_playMusicView.roundView.isPlay;
    
}

//- (void)rotationGR:(UIRotationGestureRecognizer *)rotationGR{
////
//    
////    
////}


//定时器执行方法
- (void)tiamchange:(NSTimer *)timer{
    
    self.playMusicView.timeSlide.value = self.audioPlayer.currentTime;
    NSString *allTime = [NSString stringWithFormat:@"%.2f", self.audioPlayer.duration/60.0];
    NSString *timeStr = [NSString stringWithFormat:@"%.2f", self.audioPlayer.currentTime/60.0];
//    CMTime *cmTime = self.audioPlayer.duration;
//    NSString *allTimeM = [NSString stringWithFormat:@"%d", (CMTime *)self.audioPlayer.duration%60.0];
//    NSString *timeStrM = [NSString stringWithFormat:@"%d", self.audioPlayer.currentTime%60.0];
    NSString *show = [NSString stringWithFormat:@"0%@/0%@", timeStr,allTime];
    self.playMusicView.showTimeLabel.text = show;
}

//double angle;
//- (void)rotationGRAction:(NSTimer *)timer{
//    
//    [UIView beginAnimations:nil context:nil];
//    self.playMusicView.imageView.transform = CGAffineTransformMakeRotation(angle);
//    angle = angle+0.1;
//    [UIView setAnimationDuration:0.1];
//    [UIView setAnimationRepeatCount:0];
//    [UIView commitAnimations];
//}

//上一首
- (void)preSong:(UIButton *)butto{

    NSLog(@"上一曲");
    [self.audioPlayer stop],self.audioPlayer = nil;// 置为nil是为了释放掉原来播放的那首歌曲
    
    [self.timer invalidate];
    
    if (_index == self.musicArray.count-1) {
        _index = 0;
    }else{
        
        _index++;
    }
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.musicArray[_index] ofType:@"mp3" ]] error:nil];
    self.audioPlayer.enableRate = YES;
    self.audioPlayer.delegate = self;
    // 修改声音
    self.audioPlayer.volume = self.playMusicView.volumSlide.value;
    //修改总时长
    self.playMusicView.timeSlide.maximumValue = self.audioPlayer.duration;
    [self.audioPlayer prepareToPlay];
    self.playMusicView.nameLabel.text = self.musicNameArray[_index];
    [self.audioPlayer play];
    self.audioPlayer.numberOfLoops = -1;
    
}
//下一首
- (void)nextSong:(UIButton *)button{

    NSLog(@"下一曲");
    [self.audioPlayer stop],self.audioPlayer = nil;// 置为nil是为了释放掉原来播放的那首歌曲
    
    [self.timer invalidate];
    
    if (_index == self.musicArray.count-1) {
        _index = 0;
    }else{
        
        _index++;
    }
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.musicArray[_index] ofType:@"mp3" ]] error:nil];
    self.audioPlayer.enableRate = YES;
    self.audioPlayer.delegate = self;
    // 修改声音
    self.audioPlayer.volume = self.playMusicView.volumSlide.value;
    //修改总时长
    self.playMusicView.timeSlide.maximumValue = self.audioPlayer.duration;
    [self.audioPlayer prepareToPlay];
    [self.playMusicView.playButton setTitle:@"暂停" forState:(UIControlStateNormal)];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tiamchange:) userInfo:nil repeats:YES];
    self.playMusicView.nameLabel.text = self.musicNameArray[_index];
    [self.audioPlayer play];
    self.audioPlayer.numberOfLoops = -1;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    NSLog(@"播放完");
    [self.playMusicView.playButton setTitle:@"播放" forState:(UIControlStateNormal)];
    [self.timer invalidate];
}


- (void)playRotation:(RoundView *)roundView{
    
    roundView.isPlay = !roundView.isPlay;
    [self playSong:self.playMusicView.playButton];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (void)dealloc
{
    [_timer release];
    [_playMusicView release];
    [_musicArray release];
    [_audioPlayer release];
    [_musicNameArray release];
    [_rotationTimer release];
    [super dealloc];
}

@end
