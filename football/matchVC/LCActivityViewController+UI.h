//
//  LCActivityViewController+UI.h
//  LCPlayerSDKConsumerDemo
//
//  Created by CC on 15/12/4.
//  Copyright © 2015年 CC. All rights reserved.
//

#import "LCBaseViewController.h"


/*
 皮肤活动播放器页面
 */
@interface LCActivityViewController_UI : LCBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *leftteam;
@property (weak, nonatomic) IBOutlet UIImageView *leftImg;
@property (weak, nonatomic) IBOutlet UIImageView *rightImg;
@property (weak, nonatomic) IBOutlet UILabel *rightname;


@end
