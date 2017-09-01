//
//  appInfoModel.m
//  BicycleApp
//
//  Created by 雨停 on 2017/7/3.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "appInfoModel.h"
#import "typeModel.h"
#import "statusSmodel.h"
 
#import "schdeuleModel.h"
#import "matchViewModel.h"
#import "picModel.h"
#import "membersModel.h"
#import "rowsViewModel.h"

#import "newsModel.h"
#import "carouselModel.h"
#import "coachesModel.h"
#import "coursesModel.h"
#import "onlineVcModel.h"
#import "playersModel.h"
#import "commentsModel.h"
@implementation appInfoModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{

    return @{
           @"descrip":@"description",
           @"levelV":@"level",
           @"typeV":@"type",
           @"statusV":@"status"
             };
}
// Dic -> model
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {

    self.descrip = dic[@"description"];
    self.levelV = dic[@"level"];
    self.typeV  = dic[@"type"];
    self.statusV = dic[@"status"];

    return YES;
}

// model -> Dic
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {

    dic[@"description"] =self.descrip;
    dic[@"level"] = self.levelV   ;
    dic[@"type"]  = self.typeV  ;
    dic[@"status"] = self.statusV ;

    return YES;
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"type"        : [statusSmodel class],
             @"status"      : [statusSmodel class],
             @"level"       : [statusSmodel class],
             @"match_video" : [matchViewModel class],
             @"schedule"    : [schdeuleModel class],
             @"match_imgs"  : [picModel class],
             @"player"      : [membersModel class],
             @"rows"        : [rowsViewModel class],
             @"cocah"       : [membersModel class],
             @"assists"     : [membersModel class],
             @"news"        : [newsModel class],
             @"carousel"    : [carouselModel class],
             @"coaches"     : [coachesModel class],
             @"courses"     : [coursesModel class],
             @"course"      : [coursesModel class],
             @"hot"         : [newsModel class],
             @"players"     : [playersModel class],
             @"info"        : [NSArray class],
             @"other_coach" : [coachesModel class],
             @"other_news"  : [newsModel class],
             @"other_course": [coursesModel class],
             @"comments"    : [commentsModel class],
             @"other"       : [matchViewModel class]
              };
}


@end
