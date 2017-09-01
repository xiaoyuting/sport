//
//  integralCell.h
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface integralCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *teamname;
@property (weak, nonatomic) IBOutlet UILabel *ZJ;
@property (weak, nonatomic) IBOutlet UILabel *DF;
@property (weak, nonatomic) IBOutlet UILabel *HH;
@property (weak, nonatomic) IBOutlet UILabel *FS;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *soccer;
@property (nonatomic,strong)NSDictionary     *dic;
@end
