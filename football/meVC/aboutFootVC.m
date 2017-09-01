//
//  aboutFootVC.m
//  football
//
//  Created by 雨停 on 2017/8/17.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "aboutFootVC.h"

@interface aboutFootVC ()

@property (weak, nonatomic) IBOutlet UILabel *labFoot;
@end

@implementation aboutFootVC
- (IBAction)clinck:(UIButton *)sender {
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getapp_Version];
    self.title = @"关于";
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)leftItemClick:(id)sender{
    [self absPopNav];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getapp_Version{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    self.labFoot .text = [NSString stringWithFormat:@"数苗足球V%@.%@",app_build,app_Version];
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
