//
//  footSetinfo.m
//  football
//
//  Created by 雨停 on 2017/8/17.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "footSetinfo.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "messagSetVC.h"
#import "aboutFootVC.h"
#import "meHelpCenterVC.h"
@interface footSetinfo ()
@property (weak, nonatomic) IBOutlet UILabel *memeory;
@property (weak, nonatomic) IBOutlet UILabel *footname;

@end

@implementation footSetinfo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
    [self getapp_Version];
    
       
}
-(void)setSubView{
    self.view.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.title =@"设置";

    float ImageCache = [[SDImageCache sharedImageCache]getSize]/1000/1000;
    self.memeory.text =[NSString stringWithFormat:@"%.2fM",ImageCache];
}
-(void)leftItemClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushVC:(UIButton *)sender {
    if(sender.tag==0){
        messagSetVC * messageSet = [[messagSetVC alloc]init];
        [self.navigationController pushViewController:messageSet animated:YES];
    }else if(sender.tag==1){
   [[UIApplication  sharedApplication] openURL:imgUrl(@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1271267464&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8")];
    }else if(sender.tag==2){
        meHelpCenterVC * help = [[meHelpCenterVC alloc]init];
        [self.navigationController pushViewController:help animated:YES];
    }else if(sender.tag==3){
    [self setCount];
    }else if(sender.tag==4){
        aboutFootVC* about = [[aboutFootVC alloc]init];
        [self.navigationController pushViewController:about animated:YES];

        
    }
}


-(void)setCount{
    //调用第三方方法
    float ImageCache = [[SDImageCache sharedImageCache]getSize]/1000/1000;
   
    NSString * CacheString = [NSString stringWithFormat:@"缓存大小为%.2fM.确定要清理缓存么?",ImageCache];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:CacheString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag = 100;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //调用第三方方法
        [self clearTmpPics];
    }
}

//清除缓存

- (void)clearTmpPics

{
    [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
        
    } ];
   [[SDImageCache sharedImageCache] clearMemory];//可有可无
    float ImageCache = [[SDImageCache sharedImageCache]getSize]/1000/1000;
    self.memeory.text =[NSString stringWithFormat:@"%.2fM",ImageCache];
    
}
-(void)getapp_Version{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    self.footname .text = [NSString stringWithFormat:@"数苗足球V%@.%@",app_build,app_Version];
    }


@end
