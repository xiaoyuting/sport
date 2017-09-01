//
//  TimeLabel.m
//  football
//
//  Created by 雨停 on 2017/8/31.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "TimeLabel.h"

@implementation TimeLabel
- (id)initWithCoder:(NSCoder *)aDecoder{
    if(self ==[super initWithCoder:aDecoder]){
       self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeHeadle) userInfo:nil repeats:YES]; 
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       // self.textAlignment = NSTextAlignmentCenter;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeHeadle) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)timeHeadle{
    
    self.second--;
    if (self.second==-1) {
        self.second=59;
        self.minute--;
        if (self.minute==-1) {
            self.minute=59;
            self.hour--;
        }
    }
    if (self.hour>0) {
        self.text = [NSString stringWithFormat:@"%.2ld:%.2ld:%.2ld",(long)self.hour,(long)self.minute,(long)self.second];
    }else if (self.hour==0) {
        self.text = [NSString stringWithFormat:@"%.2ld:%.2ld",(long)self.minute,(long)self.second];
    }else if (self.minute==0)
    {
        self.text = [NSString stringWithFormat:@"%.2ld",(long)self.second];
    }
    
    if (self.second==0 && self.minute==0 && self.hour==0) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
@end
