//
//  meCell.h
//  football
//
//  Created by 雨停 on 2017/6/29.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class youthModel;
@interface meCell : UITableViewCell
@property (nonatomic,strong)youthModel  * model;
@property (nonatomic,strong)NSDictionary * dic;
 @property (nonatomic,strong)  UIImageView   * _line;
@end
