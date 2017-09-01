//
//  matchleftcellModel.m
//  football
//
//  Created by 雨停 on 2017/7/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "matchleftcellModel.h"

@implementation matchleftcellModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{

    return @{
           @"descrip":@"description"
             };
}
// Dic -> model
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {

    self.descrip = dic[@"description"];

    return YES;
}

// model -> Dic
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {

    dic[@"description"] =self.descrip;

   return YES;
}

@end
