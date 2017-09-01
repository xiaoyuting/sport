//
//  homeBaseModel.m
//  football
//
//  Created by 雨停 on 2017/8/17.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "homeBaseModel.h"

@implementation homeBaseModel
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
