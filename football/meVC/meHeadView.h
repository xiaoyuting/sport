//
//  meHeadView.h
//  football
//
//  Created by 雨停 on 2017/6/29.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef   void (^personInfo)(NSInteger  tag);
@interface meHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *myPhoto;


@property (weak, nonatomic) IBOutlet UILabel *myclass;
@property (nonatomic, copy) personInfo  personInfo;
@property (weak, nonatomic) IBOutlet UILabel *mycoll;

@property (weak, nonatomic) IBOutlet UILabel *myvideo;
@property (weak, nonatomic) IBOutlet UILabel *myteam;
@property (weak, nonatomic) IBOutlet UILabel *myplay;
@property (weak, nonatomic) IBOutlet UILabel *mymember;
@property (weak, nonatomic) IBOutlet UILabel *myorder;
@property (weak, nonatomic) IBOutlet UILabel *myfoot;
@property (weak, nonatomic) IBOutlet UILabel *myname;
@property (weak, nonatomic) IBOutlet UILabel *myvip;
@property (weak, nonatomic) IBOutlet UILabel *myweight;
@property (weak, nonatomic) IBOutlet UILabel *myheight;

@end
