//
//  PlayMusic.m
//  PlayMusic

//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "PlayMusic.h"

@interface PlayMusic ()


@end

@implementation PlayMusic


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //歌曲名字
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 40, 200, 30)];
        _nameLabel.text = @"歌曲名";
//        _nameLabel.backgroundColor = [UIColor redColor];
        
        [self addSubview:_nameLabel];
        [_nameLabel release];
        
        
        
//       self.imageView = [[UIView alloc] initWithFrame:CGRectMake(90, 80, 200, 200)];
//        _imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"7ead4679afb23b350df7c8db6dce03e5.jpg"]];
//        _imageView.layer.cornerRadius = 100;
//        [self addSubview:_imageView];
//        [_imageView release];
         
        
        self.roundView = [[RoundView alloc] initWithFrame:CGRectMake(90, 80, 200, 200)];
        _roundView.roundImage = [UIImage imageNamed:@"7ead4679afb23b350df7c8db6dce03e5.jpg"];
        _roundView.rotationDuration = 8.0;
        _roundView.isPlay =NO;
        _roundView.delegate = self;
       
        [self addSubview:_roundView];
        [_roundView release];
        
        
        
        
        //音量
        UILabel *volumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 60, 20)];
        volumLabel.text = @"音量";
        volumLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:volumLabel];
        [volumLabel release];
        
        self.volumSlide = [[UISlider alloc] initWithFrame:CGRectMake(70, 300, 180, 20)];
//        _volumSlide.maximumValue = 1.0;
//        _volumSlide.minimumValue = 0;
        [self addSubview:_volumSlide];
        [_volumSlide release];
        
        //进度
        

        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 340, 60, 20)];
        timeLabel.text = @"进度条";
        timeLabel.textColor = [UIColor whiteColor];
        [self addSubview:timeLabel];
        [timeLabel release];
        
        self.timeSlide = [[UISlider alloc] initWithFrame:CGRectMake(70, 340, 180, 10)];
        [self addSubview:_timeSlide];
        
        [_timeSlide release];
        
        //显示歌曲时间
        self.showTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 340, 110, 20)];
//        _showTimeLabel.text = @"显示时间";
        _showTimeLabel.textColor = [UIColor whiteColor];
        [self addSubview:_showTimeLabel];
        [_showTimeLabel release];
        

        
        
        // 上一曲
        self.leftButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _leftButton.frame = CGRectMake(70, 420, 50, 30);
    
        [_leftButton setTitle:@"上一曲" forState:(UIControlStateNormal)];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self addSubview:_leftButton];
        
        // 播放
        self.playButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_playButton setTitle:@"播放" forState:(UIControlStateNormal)];
         [_playButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _playButton.frame = CGRectMake(150, 420, 80, 30);
        
        [self addSubview:_playButton];
        
        // 下一曲
        self.rightButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_rightButton setTitle:@"下一曲" forState:(UIControlStateNormal)];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];

        _rightButton.frame = CGRectMake(260, 420, 50, 30);
        [self addSubview:_rightButton];
        
        
        
        
    }
    return self;
}


- (void)playStatuUpdate:(BOOL)playState{
    
    NSLog(@"旋转图片%@...", playState ? @"播放" : @"暂停");
}




- (void)dealloc
{
    [_imageView release];
    [_nameLabel release];
    [_timeSlide release];
    [_leftButton release];
    [_playButton release];
//    [_curentLabel release];
    [_rightButton release];
    [_volumSlide release];
//    [_durationLabel release];
    [super dealloc];
}
@end
