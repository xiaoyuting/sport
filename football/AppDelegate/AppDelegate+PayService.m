//
//  AppDelegate+PayService.m
//  football
//
//  Created by 雨停 on 2017/8/16.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "AppDelegate+PayService.h"

@implementation AppDelegate (PayService)

#pragma mark 跳转处理
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSLog(@"result = %@",resultDic);
            NSNotification * notification = [NSNotification notificationWithName:@"aliPay" object:[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]]];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//            // 解析 auth code
//            NSString *result = resultDic[@"result"];
//            NSString *authCode = nil;
//            if (result.length>0) {
//                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//                for (NSString *subResult in resultArr) {
//                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                        authCode = [subResult substringFromIndex:10];
//                        break;
//                    }
//                }
//            }
//            NSLog(@"授权结果 authCode = %@", authCode?:@"");
//        }];
    }
        if([url.scheme isEqualToString:@"wx5939ba19b940fea1"]){
            return [WXApi handleOpenURL:url delegate:self];
        }

    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{      NSLog(@"%@",url);
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
           
            NSNotification * notification = [NSNotification notificationWithName:@"aliPay" object:[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]]];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//            // 解析 auth code
//            NSString *result = resultDic[@"result"];
//            NSString *authCode = nil;
//            if (result.length>0) {
//                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//                for (NSString *subResult in resultArr) {
//                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                        authCode = [subResult substringFromIndex:10];
//                        break;
//                    }
//                }
//            }
//            NSLog(@"授权结果 authCode = %@", authCode?:@"");
//        }];
    }
        if([url.scheme isEqualToString:@"wx5939ba19b940fea1"]){
            return [WXApi handleOpenURL:url delegate:self];
        }

    return YES;
}

-(void)setWXpayInfo{
    
    [WXApi registerApp:@"wx5939ba19b940fea1"];

}
-(void) onResp:(BaseResp*)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
        //                                                        message:payResoult
        //                                                       delegate:self
        //                                              cancelButtonTitle:@"OK"
        //                                              otherButtonTitles:nil, nil];
        //        [alert show];
        //        [[NSNotificationCenter defaultCenter] postNotificationName:HUDDismissNotification object:nil userInfo:nil];
        //这里可以向外面跑消息
        //发出通知 从微信回调回来之后,发一个通知,让请求支付的页面接收消息,并且展示出来,或者进行一些自定义的展示或者跳转
        NSNotification * notification = [NSNotification notificationWithName:@"WXPay" object:[NSString stringWithFormat:@"%d",resp.errCode]];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }
}

@end
