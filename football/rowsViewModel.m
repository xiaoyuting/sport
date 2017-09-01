//
//  rowsViewModel.m
//  football
//
//  Created by 雨停 on 2017/8/3.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "rowsViewModel.h"

@implementation rowsViewModel
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
