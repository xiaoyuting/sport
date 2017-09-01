//
//  leftYouthCell.h
//  football
//
//  Created by 雨停 on 2017/6/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class youthModel;
@class newsModel;
@interface leftYouthCell : UITableViewCell
@property (nonatomic,strong)youthModel *model;
@property (nonatomic,strong)newsModel *modelcenter ;
@property (nonatomic,strong)youthModel *modelright;

@end
