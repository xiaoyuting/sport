//
//  BaseModel.h
//  BicycleApp
//
//  Created by 雨停 on 2017/6/16.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>
@class appInfoModel;
@interface BaseModel : NSObject
@property (nonatomic,strong) appInfoModel * data;
@property (nonatomic,copy) NSString  * errorno;
@property (nonatomic,copy) NSString  * status;
@property (nonatomic,copy) NSString  * errmsg;
@property (nonatomic,copy) NSString  * message;
@property (nonatomic,copy) NSString  * team_id;

@end
