//
//  myVideoVC.m
//  football
//
//  Created by 雨停 on 2017/7/19.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "myVideoVC.h"

@interface myVideoVC ()

@end

@implementation myVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)setSubview{
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.title = @"我的视频";
    [self showPlaceholderViewWithImage:Img(@"videoCheak_no") message:@"没有视屏" buttonTitle:nil centerOffsetY:0 onSuperView:self.view];
}

-(void)leftItemClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
