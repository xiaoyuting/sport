//
//  AppDelegate+PushService.h
//  football
//
//  Created by 雨停 on 2017/7/17.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "AppDelegate.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import "JSHAREService.h"
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
@interface AppDelegate (PushService)<JPUSHRegisterDelegate>
-(void)setPushInfoDic:(NSDictionary *)launchOptions;
-(void)setShearInfo;
@end
