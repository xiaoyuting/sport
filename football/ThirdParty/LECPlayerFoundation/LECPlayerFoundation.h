//
//  LECPlayerFoundation.h
//  LECPlayerFoundation
//
//  Created by CC on 16/5/11.
//  Copyright © 2016年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    LECServiceForChina = 0,                 //中国版
    LECServiceForUS = 1                     //北美版
} LECServiceType;//SDK版本服务


@interface LECPlayerFoundation : NSObject

+ (LECPlayerFoundation *) sharedFoundation;

- (void) startService:(LECServiceType)serviceType;

- (void) startService:(LECServiceType)serviceType
  enableAudioSoloMode:(BOOL)enable;//是否启动时候获取到系统播放音频播放权限,Default is YES

- (void) stopService;


- (NSString *) sdkVersion;

/**
 *  写入文件的日志开关
 *
 *  @param onOff YES:开 NO：关   默认为YES
 */
-(void)fileLogEnable:(BOOL)onOff;
/**
 *  控制台的日志开关
 *
 *  @param onOff YES:开 NO：关    默认为NO
 */
-(void)consoleLogEnable:(BOOL)onOff;

@end
