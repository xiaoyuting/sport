//
//  LECPlayerOption.h
//  LECPlayerFoundation
//
//  Created by CC on 16/5/9.
//  Copyright © 2016年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LECGlobalDefine.h"

/*
 播放器业务相关数据Model
 */

@interface LECPlayerOption : NSObject

@property (nonatomic, strong) NSString * p;//业务ID
@property (nonatomic, strong) NSString * customId;//用户ID,应用于业务相关租户ID
@property (nonatomic, assign) LECBusinessLine businessLine;//业务线类型
@property (nonatomic, strong) NSString * pu;//选择播放器
@property (nonatomic, strong) NSString * utoken;//客户系统自定义的token,应用于付费相关
@property (nonatomic, strong) NSString * cuid;//客户系统中的用户ID,应用于付费和客户自身业务相关的操作
@property (nonatomic, strong) NSString * appCategory;//SSP业务ID
@property (nonatomic, assign) BOOL isAudioService;//是否是音频服务,默认是NO

@end
