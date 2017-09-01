//
//  sampleMatchCell.h
//  football
//
//  Created by 雨停 on 2017/7/26.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class schdeuleModel;
@interface sampleMatchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *homelogo;
@property (weak, nonatomic) IBOutlet UILabel *homename;
@property (weak, nonatomic) IBOutlet UILabel *round;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *awaylogo;
@property (weak, nonatomic) IBOutlet UILabel *awayname;
@property  (nonatomic,strong)NSDictionary  * dic;
@property  (nonatomic,strong)schdeuleModel * model;
@end
