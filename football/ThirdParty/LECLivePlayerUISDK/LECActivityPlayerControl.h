//
//  LECActivityPlayerControl.h
//  LECActivityPlayerUISDK
//
//  Created by tingting on 16/5/16.
//  Copyright © 2016年 tingting. All rights reserved.
//

#import "LECPlayerControl.h"
#import "LECLivePlayerControl.h"
@interface LECActivityPlayerControl : LECPlayerControl

//播放器视图初始化创建
- (UIView *)createPlayerWithOwner:(id)owner
                            frame:(CGRect)frame;

//注册活动直播播放器
- (BOOL)registerActivityLivePlayerWithId:(NSString *)pId;

- (BOOL)registerActivityLivePlayerWithId:(NSString *)pId
                                  option:(LECPlayerOption *)option//业务信息,可以为nil
                               completed:(void (^)(BOOL success))block;


@end
