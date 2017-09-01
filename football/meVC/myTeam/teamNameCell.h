//
//  teamNameCell.h
//  football
//
//  Created by 雨停 on 2017/8/1.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface teamNameCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *teamName;
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UIImageView *rightPic;
@property (nonatomic,strong)NSDictionary      * dic;
@end
