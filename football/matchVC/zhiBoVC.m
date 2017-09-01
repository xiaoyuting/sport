//
//  zhiBoVC.m
//  football
//
//  Created by 雨停 on 2017/7/26.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "zhiBoVC.h"

@interface zhiBoVC ()
@end

@implementation zhiBoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
        
    
    
}
-(void)setSubview{
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.title = @"直播详情";
    [self setNavRightItemTitle:nil andImage:Img(@"shearW")];
}
-(void)leftItemClick:(id)sender{
//    if (self.presentingViewController) {
//         [self dismissViewControllerAnimated:YES completion:nil];
//        
//      
//    }else{
        [self.navigationController popViewControllerAnimated:YES];
        
   // }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
