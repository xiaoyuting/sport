//
//  AppDelegate+PayService.h
//  football
//
//  Created by 雨停 on 2017/8/16.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WXApi.h>
@interface AppDelegate (PayService)<WXApiDelegate>
-(void)setWXpayInfo;
@end
