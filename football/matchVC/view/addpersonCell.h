//
//  addpersonCell.h
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addpersonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *posizition;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (nonatomic,strong)NSDictionary *  dic;
@end
