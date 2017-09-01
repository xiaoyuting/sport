//
//  AppDelegate+AppInfo.m
//  football
//
//  Created by 雨停 on 2017/7/21.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "AppDelegate+AppInfo.h"
#import "ZKUDID.h"
#import "CusMD5.h"
@implementation AppDelegate (AppInfo)
-(void)initAppinfo{ dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
         NSLog(@"group1");
        [self getInfo];
    });
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self registToken];
        NSLog(@"group 2");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3];
        [self getToken];
        NSLog(@"group3");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"update UI");
    });
   
}
-(void)getInfo{
    [ZKUDID setDebug:YES];
    NSString *UDID = [ZKUDID value];
    NSLog(@"UDID: %@",UDID);
    NSString *strEnRes = [CusMD5 md5String:UDID];
    NSLog(@"strEnRes: %@",strEnRes);
    
    [RequestManager requestWithType:HttpRequestTypePost urlString:@"http://api.smartsport.top/authed/oauth.html" parameters:@{@"imei":UDID,@"code":strEnRes}
                       successBlock:^(id response) {
                            NSLog(@"response==%@",response);
                           NSDictionary *dic = [response    objectForKey:@"data"];
                          
                           [ball  putObject:dic  withId:@"urlInfo" intoTable:@"person"];
                           
                         //  [ball getObjectById:@"urlInfo" fromTable:@"person"];
                       
                           
                       } failureBlock:^(NSError *error) {
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
}

-(void)registToken{
    appInfoModel * model = [appInfoModel yy_modelWithDictionary: [ball getObjectById:@"urlInfo" fromTable:@"person"]];
    [RequestManager requestWithType:HttpRequestTypePost urlString:model.authorize_url parameters:@{
                                                                                                                    @"response_type":@"code",
                                                                                                                                @"client_id":model.app_key,
                                                                                                                    @"state"    :model.seed_secret
                                                                                                                                }
     successBlock:^(id response) {
         NSLog(@"response==%@",response);
    NSMutableDictionary *dic  = [NSMutableDictionary   dictionaryWithDictionary:[ball getObjectById:@"urlInfo" fromTable:@"person"]];
    [dic setObject:[[response objectForKey:@"data"] objectForKey:@"authorize_code"]forKey:@"authorize_code"];
   
         [ball putObject:dic withId:@"urlInfo" intoTable:@"person"];
                       } failureBlock:^(NSError *error) {
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
    
    
}

-(void)getToken{
    appInfoModel * model = [appInfoModel yy_modelWithDictionary: [ball getObjectById:@"urlInfo" fromTable:@"person"]];
    [RequestManager requestWithType:HttpRequestTypePost urlString:model.token_url parameters:@{
                                                                                               
                                                                                                   @"client_id":model.app_key,
                                                                                                   
                                                                           @"state"    :model.seed_secret,
                                                                                                   @"grant_type":@"authorization_code",
                                                                                                   @"client_secret":model.app_secret,
                                                                                                   @"code":model.authorize_code,
                                                                                                   }
                       successBlock:^(id response) {
                           NSLog(@"response==%@",response);
                           NSMutableDictionary *dic  = [NSMutableDictionary   dictionaryWithDictionary:[ball getObjectById:@"urlInfo" fromTable:@"person"]];
                           [dic setObject:[[response objectForKey:@"data"] objectForKey:@"access_token"]forKey:@"access_token"];
                           [dic setObject:[[response objectForKey:@"data"] objectForKey:@"refresh_token"]forKey:@"refresh_token"];
                           [ball putObject:dic withId:@"urlInfo" intoTable:@"person"];
 
                           
                           
                       } failureBlock:^(NSError *error) {
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
    

    
}
@end
