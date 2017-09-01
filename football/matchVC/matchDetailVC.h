//
//  matchDetailVC.h
//  football
//
//  Created by 雨停 on 2017/7/26.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "XYBaseVC.h"

@interface matchDetailVC : XYBaseVC
@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headTabHeight;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomTabHeight;

@property (weak, nonatomic) IBOutlet UICollectionView *myColl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomButHeight;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mycollHeight;

@property (nonatomic,copy)  NSString  * idTag;
@end
