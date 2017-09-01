//
//  LoginVC+rootTabVC.m
//  football
//
//  Created by 雨停 on 2017/7/22.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "LoginVC+rootTabVC.h"
#import "RootTabVC.h"

@implementation LoginVC (rootTabVC)
-(void)setBaseVC{
       RootTabVC* rootVC=[[UIStoryboard  storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"main"];
        rootVC.delegate = self;
    [self presentViewController:rootVC animated:YES completion:nil];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSLog(@"%@",viewController.tabBarItem.title);
    if(![ball getStringById:@"load" fromTable:@"person"]){
        if ([viewController.tabBarItem.title isEqualToString:@"我的"]) {
            
            LoginVC * login = [[LoginVC alloc]init];
            
            NavigationVC   * nav  = [[NavigationVC alloc]initWithRootViewController:login];
            [( NavigationVC *)tabBarController.selectedViewController presentViewController:nav animated:YES completion:nil];
        
               return NO;
        }

        
        
 
    }
//    if ([viewController.tabBarItem.title isEqualToString:@"购物车"] || [viewController.tabBarItem.title isEqualToString:@"我"]) {
    
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
   // }
    return YES;
    
}

@end
