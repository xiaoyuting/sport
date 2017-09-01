//
//  AppDelegate.m
//  football
//
//  Created by 雨停 on 2017/6/26.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+AppService.h"
#import "AppDelegate+AppInfo.h"
#import "LECPlayerFoundation.h"
#import "AppDelegate+PushService.h"
#import "AppDelegate+PayService.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskAll;
    }
    
    return UIInterfaceOrientationMaskPortrait;
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
   
    [[LECPlayerFoundation sharedFoundation]startService:LECServiceForChina];
    
    // yes:open Log no:close Log
    [[LECPlayerFoundation sharedFoundation]fileLogEnable:NO];
    [[LECPlayerFoundation sharedFoundation]consoleLogEnable:NO];
    
       //注册崩溃处理
    // NSSetUncaughtExceptionHandler (&CaughtExceptionHandler);
  

    /*
     确保App启动的屏幕方向
     */
    [[UIApplication sharedApplication] setStatusBarOrientation:(UIInterfaceOrientationPortrait) animated:NO];
    [self initWindow];
    [self setLaunchfirst];
    [self setKeyboardManager];
    [self setPushInfoDic:launchOptions];
    [self getAppInfo];
    [self setShearInfo];
    [self setWXpayInfo];
    return YES;
}
-(void)getAppInfo{
    if(![ball getObjectById:@"urlInfo" fromTable:@"person"]){
        [self initAppinfo];
    }
}
/*-(void)setNoti{
    NSString * str =@"1";
    [kNotificationCenter addObserver:self selector:@selector(refreshUrlInfo:) name:@"urlinfo" object:str];
}
-(void)refreshUrlInfo:(NSNotification*)no{
    
    [self initAppinfo];

}*/

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and ball enough application state information to reball your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark crash catch

void CaughtExceptionHandler(NSException *exception) {
    
    //应用版本
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    NSString *version = [mainBundle objectForInfoDictionaryKey:@"internalVersion"];
    
    if(nil == version) {
        
        version = @"";
        
    }
    //设备版本
    //    NSString *deviceModel = [UIDevice currentDevice].platform;
    NSString *deviceModel = @"iPhone";
    //系统版本
    NSString *sysVersion = [UIDevice currentDevice].systemVersion;
    //邮件主题
    NSString *subject = [NSString stringWithFormat:@"[Crash][iOS_SDK4.0][%@][%@][%@]", version, sysVersion, deviceModel];
    
    //邮箱
    NSString *mailAddress = @"houdi@letv.com";
    
    
    
    //调用栈
    NSArray *stackSysbolsArray = [exception callStackSymbols];
    
    //崩溃原因
    NSString *reason = [exception reason];
    
    //崩溃原因
    NSString *name = [exception name];
    
    //邮件正文
    NSString *body = [NSString stringWithFormat:@"<br>----------------------------------------------------<br>当你看到这个页面的时候别慌,简单的描述下刚才的操作,然后邮件我<br><br>----------------------------------------------------<br>崩溃标识:<br><br>%@<br>----------------------------------------------------<br>崩溃原因:<br><br>%@<br>----------------------------------------------------<br>崩溃详情:<br><br>%@<br>",
                      
                      name,
                      
                      reason,
                      
                      [stackSysbolsArray componentsJoinedByString:@"<br>"]];
    
    
    //邮件url
    NSString *urlStr = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@",
                        
                        mailAddress,subject,body];
    
    
    
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [[UIApplication sharedApplication] openURL:url];
}


@end
