//
//  AppDelegate+AppService.m
//  football
//
//  Created by 雨停 on 2017/7/17.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "RootTabVC.h"
#import "LaunchIntroductionView.h"

#import "IQKeyboardManager.h"


@implementation AppDelegate (AppService)


-(void)initService{
    
}

#pragma mark ————— 初始化window —————
-(void)initWindow{
    

    ball;
    person;
    
    if([ball getStringById:@"load" fromTable:@"person"]){
        RootTabVC* rootVC=[[UIStoryboard  storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"main"];
        rootVC.delegate = self;
        self.window.rootViewController=rootVC;
        [self.window makeKeyAndVisible];
        
    }else{
        
        
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    LoginVC *  rootVC = [[LoginVC  alloc]init];
        rootVC.exitBtn.alpha=0;
    NavigationVC * navVC = [[NavigationVC alloc]initWithRootViewController:rootVC];
    self.window.rootViewController=navVC;
        [self.window makeKeyAndVisible];
    
}
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSLog(@"%@",viewController.tabBarItem.title);
    
    if ([viewController.tabBarItem.title isEqualToString:@"购物车"] || [viewController.tabBarItem.title isEqualToString:@"我"]) {
        
        //        LoginVC * login = [[LoginVC alloc]init];
        //
        //        NavigationVC   * nav  = [[NavigationVC alloc]initWithRootViewController:login];
        //        [( NavigationVC *)tabBarController.selectedViewController presentViewController:nav animated:YES completion:nil];
        // return NO;
        //NSLog(@"%@",viewController.tabBarItem.title);
        //        if (user.Auth || user.PSP_CODE) {
        //            return YES;
        //        } else {
        //            ABSLoginVC *loginVC = [[ABSLoginVC alloc]init];
        //            loginVC.hidesBottomBarWhenPushed = YES;
        //            [(ABSNavigationVC *)tabBarController.selectedViewController presentViewController:loginVC animated:YES completion:nil];
        //            return NO;
        //        }
    }
    return YES;
    
}

#pragma mark ————— 初始化用户系统 —————
-(void)initUserManager{
    }

#pragma mark ————— 登录状态处理 —————
- (void)loginStateChange:(NSNotification *)notification
{
   }


#pragma mark ————— 网络状态变化 —————
- (void)netWorkStateChange:(NSNotification *)notification
{
    }


#pragma mark ————— 友盟 初始化 —————
-(void)initUMeng{
    }
#pragma mark ————— 配置第三方 —————
-(void)configUSharePlatforms{
    }

#pragma mark ————— OpenURL 回调 —————
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
   
    return YES;
}

#pragma mark ————— 网络状态监听 —————
- (void)monitorNetworkStatus
{
    
}

+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
#pragma mark ————— 引导图 —————
-(void)setLaunchfirst{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
   // [LaunchIntroductionView sharedWithImages:@[@"load1",@"load2",@"load3"]];
    [LaunchIntroductionView sharedWithImages:@[@"load1",@"load2",@"load3"]  buttonImage:nil  buttonFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight)];
   
}
#pragma mark ————— 键盘 —————
-(void)setKeyboardManager{
    
    // 控制点击背景是否收起键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    // 控制键盘上的工具条文字颜色是否用户自定义
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
    // 控制是否显示键盘上的工具条
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}


@end
