//
//  LECStreamRateItem.h
//  LECPlayerFoundation
//
//  Created by CC on 16/5/9.
//  Copyright © 2016年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>

//码率信息Model
@interface LECStreamRateItem : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *subName;    //码率名称详情，如果是本地视频会显示(本地)
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) BOOL isLocal;
@property (nonatomic, assign) BOOL isEnabled;

@end
