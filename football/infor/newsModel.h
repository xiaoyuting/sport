//
//  newsModel.h
//  football
//
//  Created by 雨停 on 2017/8/9.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface newsModel : NSObject
@property (nonatomic,copy)NSString *   cate_name  ;
@property (nonatomic,copy)NSString *  cover_url;
@property (nonatomic,copy)NSString * ctime  ;
@property (nonatomic,copy)NSString * descrip  ;
@property (nonatomic,copy)NSString * hits  ;
@property (nonatomic,copy)NSString * id ;
@property (nonatomic,copy)NSString * title;

@end
