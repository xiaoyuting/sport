//
//  meHelpCenterVC.m
//  football
//
//  Created by 雨停 on 2017/8/31.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "meHelpCenterVC.h"

@interface meHelpCenterVC ()

@end

@implementation meHelpCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
    // Do any additional setup after loading the view from its nib.
}
-(void)setSubview{
    self.title =@"帮助中心";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    [self setNavLeftItemTitle:@"返回" andImage:nil];
}
- (void)leftItemClick:(id)sender{
    [self absPopNav];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnpushVC:(id)sender {
    Toast(@"筹建中");
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
