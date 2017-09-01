//
//  TimerButton.m
//  KidApp
//
//  Created by Lance Wu on 16/1/18.
//  Copyright © 2016年 Lance. All rights reserved.
//

#import "TimerButton.h"
//页面销毁 定时器仍继续
#import "WLButtonCountdownManager.h"

@interface TimerButton ()
@property (nonatomic, assign) NSInteger seconds;
@property (nonatomic, strong) NSString *durationTitle;
@end

@implementation TimerButton

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title durationTitle:(NSString *)durationTitle seconds:(NSInteger)seconds progressBlock:(progressBlock)progressBlock{
    if (self = [super initWithFrame:frame]) {
        _durationTitle = durationTitle;
        [self setTitle:title forState:UIControlStateNormal];
        [self addTargetActionWithSeconds:seconds delegate:nil progressBlock:progressBlock];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title durationTitle:(NSString *)durationTitle seconds:(NSInteger)seconds delegate:(id<TimingDelegate>)delegate{
    if (self = [super initWithFrame:frame]) {
        _durationTitle = durationTitle;
        [self setTitle:title forState:UIControlStateNormal];
        [self addTargetActionWithSeconds:seconds delegate:delegate progressBlock:nil];
   }
    return self;
}

- (void)startWithSeconds:(NSInteger)seconds delegate:(id<TimingDelegate>)delegate{
    [self addTargetActionWithSeconds:seconds delegate:delegate progressBlock:nil];
}

- (void)startWithSeconds:(NSInteger)seconds progressBlock:(progressBlock)progressBlock{
    [self addTargetActionWithSeconds:seconds delegate:nil progressBlock:progressBlock];
}

- (void)addTargetActionWithSeconds:(NSInteger)seconds delegate:(id<TimingDelegate>)delegate progressBlock:(progressBlock)progressBlock{
    _seconds = seconds;
    _delegate = delegate;
    _progressBlock = progressBlock;
    [self addTarget:self action:@selector(startCountDown) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - CountDown
- (void)startCountDown{
    if (!_progressBlock && !_delegate) {
        return;
    }
    //timeStart
    if (_delegate && [_delegate respondsToSelector:@selector(startRunningByButton:state:restTime:)]) {
        [_delegate startRunningByButton:self state:TimeStart restTime:nil];
    }
    if (_progressBlock) {
        _progressBlock(self,TimeStart,nil);
    }

    __weak typeof(self) _self = self;
    [[WLButtonCountdownManager defaultManager] scheduledCountDownWithKey:@"PinCodeTimer" timeInterval:_seconds countingDown:^(NSTimeInterval leftTimeInterval) {
        
        _self.enabled = NO;
        if (_durationTitle) {
            [_self setTitle:[NSString stringWithFormat:@"%@秒后%@", @(leftTimeInterval).stringValue, _durationTitle] forState:UIControlStateNormal];
        }
        //timeDuration
        if (_delegate && [_delegate respondsToSelector:@selector(startRunningByButton:state:restTime:)]) {
            [_delegate startRunningByButton:self state:TimeDuration restTime:@(leftTimeInterval).stringValue];
        }
        if (_progressBlock) {
            _progressBlock(_self,TimeDuration,@(leftTimeInterval).stringValue);
        }

        
    } finished:^(NSTimeInterval finalTimeInterval) {
        _self.enabled             = YES;
        if (_durationTitle) {
            [_self setTitle:_durationTitle forState:UIControlStateNormal];
        }
        //timeFinish
        if (_delegate && [_delegate respondsToSelector:@selector(startRunningByButton:state:restTime:)]) {
            [_delegate startRunningByButton:_self state:TimeFinish restTime:nil];
        }
        if (_progressBlock) {
            _progressBlock(_self,TimeFinish,nil);
        }

    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if ([[WLButtonCountdownManager defaultManager] countdownTaskExistWithKey:@"PinCodeTimer" task:nil]) {
        [self startCountDown];
    }
}

@end
