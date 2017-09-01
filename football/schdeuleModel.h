//
//  schdeuleModel.h
//  football
//
//  Created by 雨停 on 2017/7/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface schdeuleModel : NSObject
@property (nonatomic,copy)NSString * id;
@property (nonatomic,copy)NSString * home_team;
@property (nonatomic,copy)NSString * away_team;
@property (nonatomic,copy)NSString * home_logo;
@property (nonatomic,copy)NSString * away_logo;
@property (nonatomic,copy)NSString * cate_name;
@property (nonatomic,copy)NSString * group_name;
@property (nonatomic,copy)NSString * live_url;
@property (nonatomic,copy)NSString * start_time;
@property (nonatomic,copy)NSString * round;

@end
