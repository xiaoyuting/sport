//
//  signUpinfoVC.h
//  football
//
//  Created by 雨停 on 2017/8/15.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "XYBaseVC.h"

@interface signUpinfoVC : XYBaseVC
@property (weak, nonatomic) IBOutlet UIImageView *matchPic;
@property (weak, nonatomic) IBOutlet UILabel *matchTitle;
@property (weak, nonatomic) IBOutlet UILabel *matchTime;
@property (weak, nonatomic) IBOutlet UILabel *matchPrice;
@property (weak, nonatomic) IBOutlet UILabel *matchPriceOri;
@property (weak, nonatomic) IBOutlet UILabel *videoPrice;
@property (weak, nonatomic) IBOutlet UILabel *videoName;
@property (weak, nonatomic) IBOutlet UILabel *videoCountPrice;
@property (weak, nonatomic) IBOutlet UILabel *teamName;
@property (weak, nonatomic) IBOutlet UILabel *teamNum;
@property (weak, nonatomic) IBOutlet UITextField *connectName;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (nonatomic,strong)NSString  * tagID;
@end
