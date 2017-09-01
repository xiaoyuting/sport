//
//  myClassCell.h
//  football
//
//  Created by 雨停 on 2017/8/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHStarRateView.h"
@interface myClassCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picClass;
@property (weak, nonatomic) IBOutlet UILabel *titleClass;
@property (weak, nonatomic) IBOutlet UILabel *timeClass;
@property (weak, nonatomic) IBOutlet UILabel *typeClass;
@property (weak, nonatomic) IBOutlet UILabel *priceClass;
@property (weak, nonatomic) IBOutlet UIImageView *photoClass;
@property (weak, nonatomic) IBOutlet XHStarRateView *endurance;
@property (weak, nonatomic) IBOutlet XHStarRateView *explosive;
@property (weak, nonatomic) IBOutlet UILabel *nameClass;
@property (weak, nonatomic) IBOutlet XHStarRateView *technology;
@property (weak, nonatomic) IBOutlet XHStarRateView *cooperation;
@property (weak, nonatomic) IBOutlet UILabel *commentLab;
@property (weak, nonatomic) IBOutlet XHStarRateView *speed;
@property (weak, nonatomic) IBOutlet UIImageView *coachPhoto;
@property (weak, nonatomic) IBOutlet UILabel *coachName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomH;
@property (nonatomic ,copy)NSString  * model;
@end
