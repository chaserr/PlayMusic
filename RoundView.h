//
//  RoundView.h
//  PlayMusic

//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RoundViewDelete <NSObject>

- (void)playStatuUpdate:(BOOL)playState;

@end
@interface RoundView : UIView

@property (nonatomic, assign) id<RoundViewDelete> delegate;
@property (nonatomic, retain) UIImage *roundImage;
@property (nonatomic, assign) BOOL isPlay;
@property (nonatomic, assign) float rotationDuration;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

//- (void)play;
//- (void)pause;

- (id)initWithTarget:(id)target Action:(SEL)action;

@end
