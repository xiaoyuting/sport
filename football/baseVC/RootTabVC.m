//
//  RootTabVC.m
//  CateTool
//
//  Created by 雨停 on 2017/1/8.
//  Copyright © 2017年 雨停. All rights reserved.
//

#import "RootTabVC.h"
#import "Header.h"
#import "NavigationVC.h"
#import "XYBaseVC.h"
@interface RootTabVC ()

@end

@implementation RootTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarItemTheme];
    [self addNavigationVC];
    // Do any additional setup after loading the view.
}
-(void)setTabBarItemTheme{
    [[UIApplication  sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.tabBar setTintColor:mainColor];
    self.tabBar.translucent=NO;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      [UIColor blackColor],
                                                       NSForegroundColorAttributeName,
                                                      FontSize (10),
                                                       NSFontAttributeName,nil]
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      mainColor,
                                                       NSForegroundColorAttributeName,
                                                      FontSize(10),
                                                       NSFontAttributeName,nil]
                                             forState:UIControlStateSelected];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth ,  1)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.tabBar addSubview: lineView];
    [self.tabBar setShadowImage: Img (@"new")];
    [self.tabBar setBackgroundImage: [[UIImage alloc]init]];
}
-(void)addNavigationVC{
    NSArray *titleArr       = @[@"资讯",@"青训",@"赛事",@"我的"];
    NSArray *vcNameArr      = @[@"infor",@"youth",@"match",@"me"];
    NSArray *tabIconNameArr = @[@"i_infor",@"i_youth",@"i_match",@"i_me"];
    NSMutableArray *vcArr = [NSMutableArray array];
    for (NSInteger i = 0; i < titleArr.count ; i++) {
         NSString *vcName = [NSString stringWithFormat: @"%@",vcNameArr[i]];
           // Class vcClass = NSClassFromString(vcName);
        XYBaseVC *vc  = [[UIStoryboard  storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:vcName];;
                 //vc.title = titleArr[i];
        NavigationVC  *nav = [[NavigationVC alloc]initWithRootViewController:vc];
        nav.navigationBar.barTintColor=mainColor;
//        NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
//        titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
//        [nav.navigationBar setTitleTextAttributes:titleAttr];
//
        nav.tabBarItem.title = titleArr[i];
        nav.tabBarItem.image =Img(tabIconNameArr[i]);
        nav.tabBarItem.selectedImage =  Img(tabIconNameArr[i]);
        [vc.navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
        [vcArr   addObject:nav];
        
    }
    self.viewControllers  = vcArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
