//
//  coachDetaileVC.h
//  football
//
//  Created by 雨停 on 2017/8/10.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "XYBaseVC.h"

@interface coachDetaileVC : XYBaseVC
@property (weak, nonatomic) IBOutlet UIImageView *cocahPhoto;
@property (weak, nonatomic) IBOutlet UIButton *showBtn;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *collView;
@property (weak, nonatomic) IBOutlet UILabel *coachTeam;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collHeight;
@property (weak, nonatomic) IBOutlet UILabel *coachName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewwebBottomHeight;
@property (weak, nonatomic) IBOutlet UIView *viewwebBottom;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (nonatomic ,strong)NSString        * coachID;
@end
