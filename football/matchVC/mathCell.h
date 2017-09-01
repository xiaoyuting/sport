//
//  mathCell.h
//  football
//
//  Created by 雨停 on 2017/6/29.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class youthModel ;
typedef void(^cheak)();
@interface mathCell : UITableViewCell
@property  (nonatomic,strong)youthModel * model;
@property  (nonatomic,copy)cheak  cheak;
@property  (nonatomic,strong)NSMutableDictionary   *dic;
@end
