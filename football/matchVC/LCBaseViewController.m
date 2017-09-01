//
//  LCBaseViewController.m
//  LCPlayerSDKConsumerDemo
//
//  Created by CC on 15/12/15.
//  Copyright © 2015年 CC. All rights reserved.
//

#import "LCBaseViewController.h"

@interface LCBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation LCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)showTips:(NSString *)tips
{
    __weak typeof(self) wSelf = self;
    UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                         message:tips
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:controller
                        animated:YES
                      completion:^{
                          [wSelf performSelector:@selector(dismissAlertViewPage:)
                                      withObject:controller
                                      afterDelay:kDuration];
                      }];

}

- (void)dismissAlertViewPage:(UIAlertController *)controller
{
    [controller dismissViewControllerAnimated:YES
                                   completion:NULL];
}

- (NSString *)timeFormate:(NSTimeInterval)time
{
    int sec = time;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:sec];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    [formatter setTimeZone:GTMzone];
    NSString *timeStr = nil;
    if (sec < 60)
    {
        if (sec < 10)
        {
            timeStr = [NSString stringWithFormat:@"0%d",sec];
        }
        else
        {
            timeStr = [NSString stringWithFormat:@"%d",sec];
        }
        timeStr = [NSString stringWithFormat:@"00:00:%@",timeStr];
    }
    else if (sec < 3600)
    {
        [formatter setDateFormat:@"mm:ss"];
        timeStr = [formatter stringFromDate:date];
        timeStr = [NSString stringWithFormat:@"00:%@",timeStr];
    }
    else
    {
        [formatter setDateFormat:@"HH:mm:ss"];
        timeStr = [formatter stringFromDate:date];
    }
    return timeStr;
}
- (void)setNavLeftItemTitle:(NSString *)str andImage:(UIImage *)image {
    //    if ([self.navigationController.viewControllers count] ==1){
    if ([str isEqualToString:@""] || !str)
    {
        UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
     else if([str isEqualToString:@"返回"]){
        //创建一个UIButton
        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 24)];
        backButton.adjustsImageWhenHighlighted = NO;
        //设置UIButton的图像
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        backButton.titleLabel.font = FontSize(15);
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [backButton setImage:[UIImage imageNamed:@"Back Arrow Blue"] forState:UIControlStateNormal];
        //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
        [backButton addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
        //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        //覆盖返回按键
        self.navigationItem.leftBarButtonItem = backItem;
    }
    else
    {
        UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}
 

- (void)setNavRightItemTitle:(NSString *)str andImage:(UIImage *)image
{
    if ([str isEqualToString:@""] || !str)
    {
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    else
    {
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        [rightItem setTintColor:[UIColor whiteColor]];
        [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

- (void)rightItemClick:(id)sender {
    
}

- (void)leftItemClick:(id)sender{
    
}


@end
