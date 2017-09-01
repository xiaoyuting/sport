//
//  JCButton.m
//  JCCountDownBtn
//
//  Created by QB on 16/4/27.
//  Copyright © 2016年 JC. All rights reserved.
//

#import "JCButton.h"

@interface JCButton ()
{
    int _second;
    int _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
}

@end

@implementation JCButton

#pragma mark===== addToucheHandler： 方法的实现

- (void)addToucheHandler:(TouchDownBlock)touchHandler {
    
    self.touchDownBlock = [touchHandler copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touched:(JCButton *)sender {
    
    if (self.touchDownBlock) {
        self.touchDownBlock(sender,sender.tag);
    }
}

#pragma mark==== didChangBlock:方法的实现
- (void)didChangBlock:(DidChangBlock)changBlock {
    
    self.didChangBlock = [changBlock copy];
}

#pragma mark======  didFinshBlock:方法的实现
- (void)didFinshBlock:(DidFinshBlock)finshBlock {
    
    self.didFinshBlock = [finshBlock copy];
    
}

/**
 *  开始
 */

-(void)startWithSecond:(int)totalSecond {
    _totalSecond = totalSecond;
    _second = totalSecond;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeStart:) userInfo:nil repeats:YES];
    _startDate = [NSDate date];
    //让线程一直执行下去
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}


- (void)timeStart:(NSTimer *)timer {
    
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    _second = _totalSecond - (int)(deltaTime + 0.5);
    DLog(@"###_second = %.d",_second);
    DLog(@"--deltaTime = %.f",deltaTime);
    DLog(@"----int deltaTime = %.d",(int)deltaTime);
    DLog(@"-------%d",(int)(deltaTime+0.5));
    
    if (_second < 0) {
        
        [self stop];
    } else {
        
        if (self.didChangBlock) {
            [self setTitle:self.didChangBlock(self,_second) forState:UIControlStateNormal];
            [self setTitle:self.didChangBlock(self,_second) forState:UIControlStateDisabled];
        } else {
            NSString *title = [NSString stringWithFormat:@"%d秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];
        }
    }
    
}





/**
 *  停止
 */

- (void)stop {
    
    if (_timer) {
        if ([_timer respondsToSelector:@selector(isValid)]) {
            if ([_timer isValid]) {
                [_timer invalidate];
                _second = _totalSecond;
                if (self.didFinshBlock) {
                    [self setTitle:self.didFinshBlock(self,_totalSecond) forState:UIControlStateNormal];
                    [self setTitle:self.didFinshBlock(self,_totalSecond) forState:UIControlStateDisabled];
                } else {
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"重新获取" forState:UIControlStateDisabled];
                }
            }
        }
    }
    
}




@end
