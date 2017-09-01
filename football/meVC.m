//
//  meVC.m
//  football
//
//  Created by 雨停 on 2017/6/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "meVC.h"
#import "NavigationVC.h"
#import "meHeadView.h"
#import "UIButton+Badge.h"
#import "myClassVC.h"
#import "myCollectVC.h"
#import "myOrderVC.h"
#import "RegistVC.h"
#import "myMemberVC.h"
#import "myVideoVC.h"
#import "InfoSetVC.h"
#import "myTeamVC.h"
#import "myMessageVC.h"
#import "footSetinfo.h"
#import "myfooterInfoSet.h"
@interface meVC ()

@property (strong, nonatomic) UIButton          * right;
@property (strong, nonatomic) UIButton          * left;
@property (nonatomic ,strong) UILabel           * meLab;

@property (strong ,nonatomic) meHeadView        * vic;



@end

@implementation meVC

- (void)viewDidLoad {
   
    [super viewDidLoad];
    [self setSubview];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
    self.vic = [[NSBundle mainBundle] loadNibNamed:@"meHead" owner:nil options:nil].lastObject;
    self.vic.frame = CGRectMake(0, 64, KScreenWidth, KScreenHeight-64);
    self.vic.myPhoto.layer.cornerRadius=35.5;
    WeakSelf(self);
    self.vic .personInfo = ^(NSInteger tag) {
        if(tag==0){
        myfooterInfoSet * mysetvc = [[myfooterInfoSet  alloc]init];
        NavigationVC   * nav  = [[NavigationVC alloc]initWithRootViewController:mysetvc];
        [weakself presentViewController:nav animated:NO completion:nil];
        }else if(tag==1){
            myClassVC *classVC=[[myClassVC    alloc]init];
            NavigationVC * nav = [[NavigationVC alloc]initWithRootViewController:classVC];
            [weakself presentViewController:nav animated:NO completion:nil];

        }
        else if(tag==2){
            myCollectVC  *collectVC=[[  myCollectVC     alloc]init];
            NavigationVC * nav = [[NavigationVC alloc]initWithRootViewController:collectVC];

            [weakself presentViewController:nav animated:NO completion:nil];

        }
        else if(tag==3){
            myVideoVC * videoVC = [[myVideoVC alloc]init];
            NavigationVC * nav = [[NavigationVC alloc]initWithRootViewController:videoVC];

            [weakself presentViewController:nav animated:NO completion:nil];

 
        }
        else if(tag==4){
            myTeamVC * teamVC = [[myTeamVC alloc]init];
            teamVC.from = @"me";
            NavigationVC * nav = [[NavigationVC alloc]initWithRootViewController:teamVC];
            [weakself presentViewController:nav  animated:YES completion:nil];

        }else if(tag==5){
            Toast(@"正在筹备中");
            
        }else if(tag==6){
            myMemberVC * memberVC = [[myMemberVC alloc]init];
            NavigationVC * nav = [[NavigationVC alloc]initWithRootViewController:memberVC];

            [weakself presentViewController:nav animated:NO completion:nil];

        }
        else if(tag==7){
            myOrderVC  * orderVC  = [[myOrderVC  alloc]init];
            NavigationVC * nav = [[NavigationVC alloc]initWithRootViewController:orderVC];

            [weakself presentViewController:nav animated:NO completion:nil];

        }
    };
     [self.view addSubview:self.vic];
    
   }
-(void)headCheakBtn:(UIButton * )sender{
    if(sender.tag==1){
        
       footSetinfo     * myMessagevc = [[footSetinfo alloc]init];
        NavigationVC   * nav  = [[NavigationVC alloc]initWithRootViewController:myMessagevc];
        [self presentViewController:nav animated:NO completion:nil];
       }else if(sender.tag ==0){
        myMessageVC    * myMessagevc = [[myMessageVC alloc]init];
        NavigationVC   * nav  = [[NavigationVC alloc]initWithRootViewController:myMessagevc];
        [self presentViewController:nav animated:NO completion:nil];    }
}
-(void)setSubview{
    UIView  * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth  , 64)];
    self.right = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-60, 20, 60, 40)];
    //self.right.badgeValue = @"0";
    self.right.tag =0;
    [self.right setBadgeMinSize:8];
    [self.right addTarget:self action:@selector(headCheakBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.right setImage:Img(@"mes") forState:UIControlStateNormal];
    self.right.badgeBGColor = [UIColor redColor];
    [topView addSubview:self.right];
    
    self.left = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 60, 40)];
    self.left.tag =1;
    [self.left setImage:Img(@"set") forState:UIControlStateNormal];
    self.left.badgeBGColor = [UIColor redColor];
     [self.left addTarget:self action:@selector(headCheakBtn:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.left];
    
    self.meLab   = [XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter numberOfLines:0 text:@"我的" fontSize:17];
    self.meLab.font = FontBold(17);
    self.meLab.frame = CGRectMake(0, 32, 150, 24);
    self.meLab.centerX = KScreenWidth/2.0;

    [topView addSubview:self.meLab];
    topView.backgroundColor = mainColor;
    [self.view addSubview:topView];
   

     }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated
{   [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
    if([ball getStringById:@"load" fromTable:@"person"]){
//        _vic.nameBtn.userInteractionEnabled = NO;
//        _vic.vipBtn .userInteractionEnabled = NO;
//        [_vic.nameBtn setTitle:@"已登陆" forState:UIControlStateNormal];
//        [_vic.vipBtn setTitle:[ball getStringById:@"phoneNum" fromTable:@"person"] forState:UIControlStateNormal];
   
        [self requestType:HttpRequestTypePost url:nil parameters:@{
                                                                   @"action":@"getUserInfo"
                                                                   } successBlock:^(BaseModel *response) {
            if([response.errorno isEqualToString:@"0"]){
                self.vic.myname.text = response.data.username;
                self.vic.myheight.text = [NSString stringWithFormat:@"身高:%@CM",response.data.height];
                self.vic.myweight.text = [NSString  stringWithFormat:@"体重:%@KG",response.data.weight];
                if([response.data.leg isEqualToString:@"1"]){
                  self.vic.myfoot.text = @"惯用脚:左脚";
                }
                else if([response.data.leg isEqualToString:@"2"]){
                    self.vic.myfoot.text = @"惯用脚:右脚";

                }else{
                     self.vic.myfoot.text = @"惯用脚:左右平衡";
                }
                if(![ball getStringById:@"member" fromTable:@"person"]){
                    self.vic.myvip.text =@"非会员";
                }else{
                    self.vic.myvip.text =@"会员";
                }
                [self.vic.myPhoto sd_setImageWithURL:imgUrl(response.data.header_url) placeholderImage:nil];
            }
        } failureBlock:^(NSError *error) {
            
        }];
        
//    }else{
//        _vic.nameBtn.userInteractionEnabled=YES;
//        _vic.vipBtn .userInteractionEnabled = YES;
//        [_vic.nameBtn setTitle:@"登录／注册" forState:UIControlStateNormal];
//        [_vic.vipBtn setTitle: @"手机号登录" forState:UIControlStateNormal];
    }

    
}

 
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden =NO;
    
    
}


@end
