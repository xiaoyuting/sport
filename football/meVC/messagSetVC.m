//
//  messagSetVC.m
//  football
//
//  Created by 雨停 on 2017/8/17.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "messagSetVC.h"
#define IOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >=8.0 ? YES : NO)
@interface messagSetVC ()

@end

@implementation messagSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    // Do any additional setup after loading the view from its nib.
}
-(void)setSubview{
    [self.switchBtn setOn:YES];
    self.switchBtn.userInteractionEnabled = NO;
    if (IOS8) { //iOS8以上包含iOS8
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIRemoteNotificationTypeNone) {
            [self.switchBtn setOn:NO];
            self.titleNotifition.text=@"已关闭";
            
        }
    }else{ // ios7 一下
        if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes]  == UIRemoteNotificationTypeNone) {
             self.titleNotifition.text=@"已关闭";
             [self.switchBtn setOn:NO];
        }
    }
    self.title = @"消息推送设置";
    [self setNavLeftItemTitle:@"返回" andImage:nil];

}
- (IBAction)Btnclick:(UIButton *)sender {
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        
      
        [[UIApplication sharedApplication] openURL:url];
        
    }
    
   }
-(void)leftItemClick:(id)sender{
    [self absPopNav];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pullFoundation:(UISwitch *)sender {
    if(sender.on==NO){
       self.titleNotifition.text=@"已开启";
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
         [self.switchBtn setOn:YES];
    }else{
       self.titleNotifition.text=@"已关闭";
        [[UIApplication sharedApplication] registerForRemoteNotifications]; 
       [self.switchBtn setOn:NO];
    }
}

-(void)viewWillAppear:(BOOL)animated{
   [self setSubview ];  
}
@end
