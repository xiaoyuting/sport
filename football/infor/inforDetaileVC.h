//
//  inforDetaileVC.h
//  football
//
//  Created by 雨停 on 2017/8/10.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "XYBaseVC.h"

@interface inforDetaileVC : XYBaseVC
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UIScrollView *Scroller;
 
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *readLab;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webHeight;
@property (weak, nonatomic) IBOutlet UITableView *infoTab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoTabHeight;
@property (weak, nonatomic) IBOutlet UITableView *commentTab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentHeight;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (nonatomic,copy)  NSString  * infoID;
@end
