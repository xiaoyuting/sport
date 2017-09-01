//
//  LECLivePlayerControl.h
//  LECLivePlayerUISDK
//
//  Created by tingting on 16/5/16.
//  Copyright © 2016年 tingting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LECLivePlayerControl.h"
#import "LECGlobalDefine.h"
#import "LECPlayerOption.h"
#import "LECPlayerControl.h"

@interface LECLivePlayerControl : LECPlayerControl


//播放器视图初始化创建
- (UIView *)createPlayerWithOwner:(id)owner
                            frame:(CGRect)frame;

//注册直播播放器,播放直播ID
- (BOOL)registerLivePlayerWithId:(NSString *)pId
                       mediaType:(LECPlayerMediaType)mediaType;

- (BOOL)registerLivePlayerWithId:(NSString *)pId
                       mediaType:(LECPlayerMediaType)mediaType
                          option:(LECPlayerOption *)option;//业务信息,可以为nil

//注册直播播放器播放StreamID
- (BOOL)registerLivePlayerWithStreamId:(NSString *)pId
                             mediaType:(LECPlayerMediaType)mediaType;

- (BOOL)registerLivePlayerWithStreamId:(NSString *)pId
                             mediaType:(LECPlayerMediaType)mediaType
                                option:(LECPlayerOption *)option;//业务信息,可以为nil


@end
