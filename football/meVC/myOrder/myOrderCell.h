//
//  myOrderCell.h
//  football
//
//  Created by 雨停 on 2017/8/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *orderpic;
@property (weak, nonatomic) IBOutlet UILabel *ordertitle;
@property (weak, nonatomic) IBOutlet UILabel *ordertime;
@property (weak, nonatomic) IBOutlet UILabel *orderprice;
@property (weak, nonatomic) IBOutlet UILabel *orderpaystyle;

@end
