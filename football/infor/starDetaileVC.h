//
//  starDetaileVC.h
//  football
//
//  Created by 雨停 on 2017/8/10.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "XYBaseVC.h"

@interface starDetaileVC : XYBaseVC
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webHeight;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *starTeam;
@property (weak, nonatomic) IBOutlet UIImageView *startPhoto;
@property (weak, nonatomic) IBOutlet UILabel *starName;
@property (nonatomic,copy)  NSString  * playerID;
@end
