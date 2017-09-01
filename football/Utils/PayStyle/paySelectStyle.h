//
//  paySelectStyle.h
//  football
//
//  Created by 雨停 on 2017/8/16.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface paySelectStyle : NSObject
//- (void)getWeChatPayWithOrderName:(NSString *)name
//                            price:(NSString*)price;
- (void)doAlipayPayAppID:(NSString *)appID
                   Price:(NSString *)price
                orderNum:(NSString *)ordernum
               orderTime:(NSString *)ordertime
              PrivateKey:(NSString *)privateKey
                    Body:(NSString *)body
                 subJect:(NSString *)subject;

+(void)alipayOrder:(NSString * )order;
+(void)WxpayappID:(NSString * )appid
        partnerID:(NSString *)partnertid
         noncestr:(NSString *)noncestr
         package :(NSString *)package
       timestamp :(NSString *)timestamp
         prepayid:(NSString *)prepayid
             sign:(NSString *)sign;
@end
