//
//  PlayMusic.h
//  PlayMusic

//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundView.h"

@interface PlayMusic : UIView<RoundViewDelete>

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIButton *playButton;
@property (nonatomic, retain) UIButton *leftButton;
@property (nonatomic, retain) UIButton *rightButton;
//@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UISlider *timeSlide;
@property (nonatomic, retain) UISlider *volumSlide;
//@property (nonatomic, retain) UILabel *curentLabel;
@property (nonatomic, retain) UILabel *showTimeLabel;
@property (nonatomic, retain) UIView *imageView;


@property (nonatomic, retain) RoundView *roundView;
@end
