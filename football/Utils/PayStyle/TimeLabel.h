//
//  TimeLabel.h
//  football
//
//  Created by 雨停 on 2017/8/31.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeLabel : UILabel
@property (nonatomic,assign)NSInteger second;
@property (nonatomic,assign)NSInteger minute;
@property (nonatomic,assign)NSInteger hour;
@property (nonatomic, strong)NSTimer *timer; 
@end
