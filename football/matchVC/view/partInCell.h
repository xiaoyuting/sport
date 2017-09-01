//
//  partInCell.h
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface partInCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *teamPic;
@property (weak, nonatomic) IBOutlet UILabel *teamName;
@property (weak, nonatomic) IBOutlet UILabel *teamDetaile;
@property (weak, nonatomic) IBOutlet UILabel *teamNum;

@property (weak, nonatomic) IBOutlet UILabel *teamScore;
@property(nonatomic,strong)NSDictionary  *dic;
@end
