//
//  shooterCell.h
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shooterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *playname;
@property (weak, nonatomic) IBOutlet UIImageView *playerImg;
@property (weak, nonatomic) IBOutlet UILabel *soccerNum;
@property (weak, nonatomic) IBOutlet UILabel *teamName;
@property (nonatomic,strong) NSDictionary * dicC;
@property (nonatomic,strong) NSDictionary * dicR;
@end
