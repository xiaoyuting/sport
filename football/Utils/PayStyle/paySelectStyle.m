//
//  paySelectStyle.m
//  football
//
//  Created by 雨停 on 2017/8/16.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "paySelectStyle.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import "AlipaySDK/AlipaySDK.h"
//#import "payRequsestHandler.h"
#import <WXApi.h>
//#import "CommonUtil.h"
//#import "GDataXMLNode.h"


@implementation paySelectStyle
#pragma mark   ==============点击订单模拟支付行为==============
//
//选中商品调用支付宝极简支付
//
- (void)doAlipayPayAppID:(NSString *)appID  Price:(NSString *)price orderNum:(NSString *)ordernum orderTime:(NSString *)ordertime PrivateKey:(NSString *)privateKey Body:(NSString *)body subJect:(NSString *)subject
{
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    //NSString *appID = @"2017061107466058";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    /*NSString *rsa2PrivateKey =
     @"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC0J5GGpOqZuvUnD8QI6xDeyq6jaYe/VdU/t+6fmPv26+og8EgY/fJHzObJxQc+1doyRPIu59G1To6q+MC/wFZhxNDewa70i+8AjPS8QDa9pOqgvwJH5BlayclRCZXKzecERMA0DBteFB0baYif5G+8iBqQwPC5J1HdD82wHjXC8Lwtarg6Ix52/eB0XL/i6dYDbUuZekLJIZiDIkkWreB/En62tjgNKD6Bs0oi7tarPsDoibPeRxL3DnHFrbMkBrZaWXslLcj2pXeGmGb5vjmsY88cWYSgGJsBtLZ7ToU6iG54wFUPiskM3NzvBhBPKge/64alkbZTQ0q+YVScdVh7AgMBAAECggEBAI3deuOkinl0mAiiiaTcNvS6druIJrWtSbhbhzV2qzPOoxg9HwlPMLMJz9OjrAj3LlPXpz74nlNAAWjxaheVxnBHJJPFwZgheZvdY/u6NWExtPHQeGNUZALyU+3Utnh1nC3oVdKmlgaHoEQt3sDKipLUOtcymF21cOm7wCWoJH3U8MKJnoONBUnMBJcoiMZ1Vs5r+sJ0Z3fk4eP/1Z+Zg8DBSNsl9NSlbBmxVflw50aBa6I4CMnMegw/1t7L6TZtPTiP8o7hZ0G9KxJPeGnBo/um06mG3Clj3VF6DMd4eblgs8mEfWe+qTiP0IdPXUrR7eq6dszFNlC75a9+VMaRkgECgYEA7oYwyqu6RPpy00nd4gmyvyIbV2c4xygIJJ3uggXZCUSUVLX5RUapeOeC2wGjKe17Io/E6nQOWoqdkQyk3jM8kTGruXPyAd3xmzdSW3A42gjkW9QW+2Ery1JzW4GlVN0k86nBWPpqmYsp9Aqtj7sMgM5rRKOGEnPnCu4GL0pcA9sCgYEAwVqVymkW29Vtp1yC6ifMZK5uhTVlHAKAYjEl/9D8CBuN3vBaxVMVaGO3UiWqmERyiLN3tLsIAmP6ms6HgJnZpLakQbfNJgtOpKLLm2ypI88YrDoKZSHgW2J4Z8kaAQNLXbWY2BF+jH1UGYxyWm5/vaTo0SaxgMM2rTSJokzeb+ECgYAW8oAFL4pHEpUzcJrRIT+6FazttreGqXpHE46bobZkpt1iXPNzT74ELLmxGjI5WWiMRaqbJ7ktysIn70B5RBKioVW1DMuOlGynEyZwN5awm0Rk9T2Ux59v+ymv9wQR6wigDIfWaJkS1omdud1Cw6sLRVCalOTUJ6Rlr8qWiB/cGwKBgQCn/7wsvbil08DN7Py21VOrmz/eMDGk76t7JbcdmgiSRtazAWXtE66DIDkVgDLE0JwvmLgG6YchBJunTJHBtGu9yQ/ZJgly59oyBF0is3wW6AdJBbkofBHDdUCm9L3KaYFfb7zY6AJrsS2UcUqetmn5bkL4D0WlWni0b/Syd1XCIQKBgEnLVMR4mYbsnDj94owqjgC7y0A6Pq4+XGmwd+jj/uw/Tlh0z6J6dzT175faKFeuGGX0mb7cOikY/IAMUzvahYqdzAqdVDnHSJ+KbiF0bw32uN4O2iMFtHnCDzzus7NmYvjCGYxfnGalX6viBUFPUTOd+sX4zaAjkMOwVKbbmhcO";*/
    
  NSString *rsa2PrivateKey =  @"MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCKckXAFuSC6I6YbcaSLTJxBaeXp+G2SB6ErGGe00xGzBvnx+0iosXwUOFhjiOnQNOFJ/qakLBALb0oz9FAkuH9RXzsCf7A7kQ7AQubW4eIv02Fn3RuF2CRuc+22TkvsxDnwHpElw3uhfy8w4OFFD0BvFovjD/Mh+0qtgTG3XqxjRjVoMDCYynTkyzllf15MhyHkc95Hd7bKwtJWg7bDREAMfZsOkjkO7ves1T+cMx/3ytxcociE6ZQA2Rr+TkZBmreVOWxhynF+6tUE2JDS2Ogzxp//zx5wVAVJI4udS7yFK6I7DDBaj4cb8+Mj/ejKbK0SWQ4sr/6zBBphFe8LB+nAgMBAAECggEAQ4/Mdhc14KR4oe5ATyl7SiiGRr4Iqhm7uuccpJNcz9ffblbkZFim28W8lwz0XTSHhJ2j8DXXrRolC3uPFEIZwq1cbxvZlHEyHtE9xsz98T/aJvFPskH6QGM6+HI9NAfgohgOEtbcV6BPXBbVYeYkd2phYH7Cy58xn/w/jISc0XPbBp6+qyFJcgTSCDLSoijVSMRPPTwyRLaHcpSqwoE/SZuwxiH40aGip06RlsZCPDAvB2Ht0oiDOZYfUc+F9ZWGhIgIgWN4142tyhkWUZxywJvgL3hiQOxtjeQwbJ3xV7jhFlU4a6hk7y487AuPhDCF5UdKjUVszSXslLGm7nVZcQKBgQDtf72/mksS4w73O92BIW/lm5MfVBuXbmgrR1q2ucwHlNUbEAz7LgeJ69TclSWdfaoZXBJG4d38NUarlKXfsjKTLX1KVHYbuZolJQGT8ebWNaMS7rQzm9BtYPQtFb+hUuw1+7uIGmAMe86NVUxul8CfRixGnQv2qhwmEnlqXcy2KwKBgQCVOzOZe7m6WVdeNKPT0vv2ph5q+Sota0AACG6gzSif7eBV9Vx1XoTYoH4vXhKVbj+sxBcxNvQoVavr3MMLv8cVIgV/FIvHLy4sKsGQwfpcnV8HI/qjvl2hgzxJlr7COuA7VuKTrHXZhG29qLc8ZTyWELESfkZxkLONNe8nk5WadQKBgG0/3MY9sJkgj6rVBAC5o+KIHTZFF2giZpK6ARWbBCrcoOcRDBejRd6A+Gr7xNDclJmTy+iFT/sLetXEzETJkRA41bCSh74bM7gwfLhUh240QC6eVZCD9W3LMqdmoL8SCQyQHuTt1Q8JCKvk+ALLldTuj8FvzqgJ+mbdCrMOMPP/AoGAO6+l/6lAq4u4KfGb5MjqBciDOf3WJLxUqK62sJHdwbl+lGLCTB81uv7V+VQC0sl5pjv3mrOEC+3YCUoOqNBXa9hjomQxU8VHDls7eA5deFVpAI4fXQZypHq8ziIAweaScKlbjfzYVdtlmQm13+4NwWeDqwXeXuWlKsF7mbSpjVECgYBM2HP0M/RF8Lq+OO+1NOPuuSZawDhzeNguDdo5hX8JsLpkSLK+s0H+KUqOLJZIIe2BYaTRhu8hiB/XAukTvET7My+g/Zh1+rreTSOS9lrpDuqIEDWOMd8iq87gvt2mGTuhvhOkilac1Cx/DFh752xGqA/YwXLik3h2zOGbJ0yy/w==";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
//    if ([appID length] == 0 ||
//        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"缺少appId或者私钥。"
//                                                       delegate:self
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    //order.app_id = @"2017061107466058";
    order.app_id =@"2017082208320627";
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    //order.biz_content.body         = body;
    //order.biz_content.subject      = subject;
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    //order.biz_content.out_trade_no =ordernum;//[self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.out_trade_no = [self generateTradeNO];
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    //order.biz_content.total_amount =price;
    order.biz_content.total_amount=[NSString stringWithFormat:@"%.2f", 0.01];
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"footAlipay";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        NSLog(@"orderString===%@",orderString);
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            NSNotification * notification = [NSNotification notificationWithName:@"aliPay" object:[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]]];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }];
    }
}
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


// 调起微信支付，传进来商品名称和价格
/*- (void)getWeChatPayWithOrderName:(NSString *)name
                            price:(NSString*)price

{
    
    //----------------------------获取prePayId配置------------------------------
    // 订单标题，展示给用户
    NSString* orderName = name;
    // 订单金额,单位（分）, 1是0.01元
    NSString* orderPrice = price;
    // 支付类型，固定为APP
    NSString* orderType = @"APP";
    // 随机数串
    NSString *noncestr  = [self genNonceStr];
    // 商户订单号
    NSString *orderNO   = [self genOutTradNo];
    
    //================================
    //预付单参数订单设置
    //================================
    NSMutableDictionary *packageParams = [NSMutableDictionary dictionary];
    
    [packageParams setObject: WXAppId      forKey:@"appid"];       //开放平台appid
    [packageParams setObject: WXPartnerId  forKey:@"mch_id"];      //商户号
    [packageParams setObject: noncestr     forKey:@"nonce_str"];   //随机串
    [packageParams setObject: orderType    forKey:@"trade_type"];  //支付类型，固定为APP
    [packageParams setObject: orderName    forKey:@"body"];        //订单描述，展示给用户
    [packageParams setObject: orderNO      forKey:@"out_trade_no"];//商户订单号
    [packageParams setObject: orderPrice   forKey:@"total_fee"];   //订单金额，单位为分
    [packageParams setObject: [CommonUtil getIPAddress:YES] forKey:@"spbill_create_ip"];//发器支付的机器ip
    [packageParams setObject: @"http://weixin.qq.com"  forKey:@"notify_url"];  //支付结果异步通知
    NSString *prePayid;
    prePayid = [self sendPrepay:packageParams];
    //---------------------------获取prePayId结束------------------------------
    
    
    
    
    
    if(prePayid){
        NSString *timeStamp = [self genTimeStamp];
        // 调起微信支付
        PayReq *request = [[PayReq alloc] init];
        request.partnerId = WXPartnerId;
        request.prepayId = prePayid;
        request.package = @"Sign=WXPay";
        request.nonceStr = noncestr;
        request.timeStamp = [timeStamp intValue];
        
        // 这里要注意key里的值一定要填对， 微信官方给的参数名是错误的，不是第二个字母大写
        NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
        [signParams setObject: WXAppId               forKey:@"appid"];
        [signParams setObject: WXPartnerId           forKey:@"partnerid"];
        [signParams setObject: request.nonceStr      forKey:@"noncestr"];
        [signParams setObject: request.package       forKey:@"package"];
        [signParams setObject: timeStamp             forKey:@"timestamp"];
        [signParams setObject: request.prepayId      forKey:@"prepayid"];
        
        //生成签名
        NSString *sign  = [self genSign:signParams];
        
        //添加签名
        request.sign = sign;
        
        [WXApi sendReq:request];
        
        
    } else{
        NSLog(@"获取prePayId失败！");
    }
    
    
    
}

*/

// 发送给微信的XML格式数据
/*- (NSString *)genPackage:(NSMutableDictionary*)packageParams
{
    NSString *sign;
    NSMutableString *reqPars = [NSMutableString string];
    
    // 生成签名
    sign = [self genSign:packageParams];
    
    // 生成xml格式的数据, 作为post给微信的数据
    NSArray *keys = [packageParams allKeys];
    [reqPars appendString:@"<xml>"];
    for (NSString *categoryId in keys) {
        [reqPars appendFormat:@"<%@>%@</%@>"
         , categoryId, [packageParams objectForKey:categoryId],categoryId];
    }
    [reqPars appendFormat:@"<sign>%@</sign></xml>", sign];
    
    return [NSString stringWithString:reqPars];
}

*/


// 获取prePayId
/*- (NSString *)sendPrepay:(NSMutableDictionary *)prePayParams
{
    
    // 获取提交预支付的xml格式数据
    NSString *send = [self genPackage:prePayParams];
    // 打印检查， 格式应该是xml格式的字符串
    NSLog(@"%@", send);
    
    // 转换成NSData
    NSData *data_send = [send dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:getPrePayIdUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data_send];
    
    NSError *error = nil;
    // 拿到data后, 用xml解析， 这里随便用什么方法解析
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (!error) {
        // 1.根据data初始化一个GDataXMLDocument对象
        GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
        // 2.拿出根节点
        GDataXMLElement *rootElement = [document rootElement];
        GDataXMLElement *return_code = [[rootElement elementsForName:@"return_code"] lastObject];
        GDataXMLElement *return_msg = [[rootElement elementsForName:@"return_msg"] lastObject];
        GDataXMLElement *result_code = [[rootElement elementsForName:@"result_code"] lastObject];
        GDataXMLElement *prepay_id = [[rootElement elementsForName:@"prepay_id"] lastObject];
        // 如果return_code和result_code都为SUCCESS, 则说明成功
        NSLog(@"return_code---%@", [return_code stringValue]);
        // 返回信息，通常返回一些错误信息
        NSLog(@"return_msg---%@", [return_msg stringValue]);
        NSLog(@"result_code---%@", [result_code stringValue]);
        // 拿到这个就成功一大半啦
        NSLog(@"prepay_id---%@", [prepay_id stringValue]);
        
        return [prepay_id stringValue];
    } else {
        return nil;
    }
}*/

#pragma mark - 生成各种参数

- (NSString *)genTimeStamp
{
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
}

/**
 * 注意：商户系统内部的订单号,32个字符内、可包含字母,确保在商户系统唯一
 */
/*- (NSString *)genNonceStr
{
    return [CommonUtil md5:[NSString stringWithFormat:@"%d", arc4random() % 10000]];
}*/

/**
 * 建议 traceid 字段包含用户信息及订单信息，方便后续对订单状态的查询和跟踪
 */
/*- (NSString *)genTraceId
{
    return [NSString stringWithFormat:@"myt_%@", [self genTimeStamp]];
}

- (NSString *)genOutTradNo
{
    return [CommonUtil md5:[NSString stringWithFormat:@"%d", arc4random() % 10000]];
}*/


#pragma mark - 签名
/** 签名 */
/*- (NSString *)genSign:(NSDictionary *)signParams
{
    // 排序, 因为微信规定 ---> 参数名ASCII码从小到大排序
    NSArray *keys = [signParams allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    //生成 ---> 微信规定的签名格式
    NSMutableString *sign = [NSMutableString string];
    for (NSString *key in sortedKeys) {
        [sign appendString:key];
        [sign appendString:@"="];
        [sign appendString:[signParams objectForKey:key]];
        [sign appendString:@"&"];
    }
    NSString *signString = [[sign copy] substringWithRange:NSMakeRange(0, sign.length - 1)];
    
    // 拼接API密钥
    NSString *result = [NSString stringWithFormat:@"%@&key=%@", signString, WXAPIKey];
    // 打印检查
    NSLog(@"result = %@", result);
    // md5加密
    NSString *signMD5 = [CommonUtil md5:result];
    // 微信规定签名英文大写
    signMD5 = signMD5.uppercaseString;
    // 打印检查
    NSLog(@"signMD5 = %@", signMD5);
    return signMD5;
}*/
+(void)alipayOrder:(NSString * )order{
    NSString *appScheme = @"footAlipay";
    
    // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
    
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:order fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        NSString * str = [resultDic objectForKey:@"memo"];
        NSLog(@"str===%@",str);
        NSNotification * notification = [NSNotification notificationWithName:@"aliPay" object:[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]]];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];

}
+(void)WxpayappID:(NSString * )appid
        partnerID:(NSString *)partnertid
         noncestr:(NSString *)noncestr
         package :(NSString *)package
       timestamp :(NSString *)timestamp
         prepayid:(NSString *)prepayid
             sign:(NSString *)sign
{
   
    // 调起微信支付
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = partnertid;
    request.prepayId  = prepayid;
    request.package   = package;
    request.nonceStr  = noncestr;
    request.timeStamp = [timestamp intValue];
    
       //添加签名
    request.sign = sign;
    
    [WXApi sendReq:request];
    
 
}
@end
