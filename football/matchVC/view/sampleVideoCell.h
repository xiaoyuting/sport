//
//  sampleVideoCell.h
//  football
//
//  Created by 雨停 on 2017/7/26.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class matchViewModel;
@interface sampleVideoCell : UITableViewCell
@property (nonatomic,strong)matchViewModel * model;
@property (nonatomic,strong)NSString       * modelVideo;
@end
