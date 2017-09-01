//
//  youthSelectAdrVC.m
//  football
//
//  Created by 雨停 on 2017/8/9.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "youthSelectAdrVC.h"

@interface youthSelectAdrVC ()

@end

@implementation youthSelectAdrVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"筛选";
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    
}
-(void)leftItemClick:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }

 
@end
