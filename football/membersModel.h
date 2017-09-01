//
//  membersModel.h
//  football
//
//  Created by 雨停 on 2017/8/1.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface membersModel : NSObject
@property (nonatomic,copy)NSString * id;
@property (nonatomic,copy)NSString *  name;
@property (nonatomic,copy)NSString *  type;   //type为球队成员类型，0球员1助理教练2教练
@property (nonatomic,copy)NSString *  number;
@property (nonatomic,copy)NSString *  position;
@property (nonatomic,strong)NSArray  * coach;
@property (nonatomic,strong)NSArray  * assists;
@property (nonatomic,strong)NSArray  * player;
@end
