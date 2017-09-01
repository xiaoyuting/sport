//
//  NavigationVC.m
//  CateTool
//
//  Created by 雨停 on 2017/1/8.
//  Copyright © 2017年 雨停. All rights reserved.
//

#import "NavigationVC.h"


 
@interface NavigationVC () 
@end

@implementation NavigationVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationBar];
    // Do any additional setup after loading the view.
}
 - (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupNavigationBar{
   
    [[UINavigationBar appearance] setBarTintColor:mainColor];
    UIImage *bgImage = [self imageWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64) alphe:1.0];
    [[UINavigationBar appearance] setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                           NSForegroundColorAttributeName:[UIColor whiteColor]
                                                           }];
//    UINavigationBar * bar = self.navigationController.navigationBar;
//    UIImage *bgImage = [self imageWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64) alphe:1.0];
//    [bar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];

    
}
- (UIImage *) imageWithFrame:(CGRect)frame alphe:(CGFloat)alphe {
    frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    //UIColor *redColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:alphe];
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, mainColor.CGColor);
    CGContextFillRect(context, frame);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



@end
