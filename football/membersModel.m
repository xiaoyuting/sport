//
//  membersModel.m
//  football
//
//  Created by 雨停 on 2017/8/1.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "membersModel.h"
#import "homePersonModel.h"
@implementation membersModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"coach"   :    [homePersonModel class],
             @"assists" :    [homePersonModel  class],
             @"player"  :    [homePersonModel class],
                          };
}

@end
