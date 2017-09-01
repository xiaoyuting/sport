//
//  commentsModel.h
//  football
//
//  Created by 雨停 on 2017/8/25.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commentsModel : NSObject
@property (nonatomic,copy)NSString  * id;
@property (nonatomic,copy)NSString  *uid;
@property (nonatomic,copy)NSString  *content;
@property (nonatomic,copy)NSString  *username;
@property (nonatomic,copy)NSString  *header_url;
@property (nonatomic,copy)NSString  *comment_time;

@end
