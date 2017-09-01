//
//  signUpinfoVC.m
//  football
//
//  Created by 雨停 on 2017/8/15.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "signUpinfoVC.h"
#import "orderVC.h"
#import "sampleVideoVC.h"
#import "addTeamVC.h"
#import "appInfoModel.h"
#import "myVideoModel.h"
#import "myMatchModel.h"
#import "myTeamModel.h"
#import "myTeamVC.h"
#import "paySelectVC.h"
@interface signUpinfoVC ()
@property (nonatomic,strong) myMatchModel * matchmodel;
@property (nonatomic,strong) myVideoModel  * videomodel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *matchPriceW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoPriceW;
@property (nonatomic,strong) myTeamModel  * teammodel;
@end

@implementation signUpinfoVC
-(id)init{
    if(self=[super init]){
        self.tagID = [NSString string];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.title =@"赛事报名";

}
-(void)leftItemClick:(id)sender{
    [self.navigationController   popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnFoundation:(UIButton *)sender {
    if(sender.tag==0){
        sampleVideoVC *sample = [[sampleVideoVC alloc]init];
        [self.navigationController pushViewController:sample animated:YES];
    }
    if(sender.tag==1){
        myTeamVC * teamVC = [[myTeamVC alloc]init];
        teamVC.from =@"signup";
        [self.navigationController pushViewController:teamVC  animated:YES];
    }
    if(sender.tag==4){
        if(self.connectName.text.length==0){
            Toast(@"请输入联系人姓名");
            return;
        }
        if(self.phoneNum.text.length==0){
            Toast(@"请输入电话号码");
            return;
        }
        
        paySelectVC * pay = [[paySelectVC alloc]init];
        pay.type = @"2";
        pay.typeID = self.tagID;
        pay.typePrice = [NSString stringWithFormat:@"%d",[self.videomodel.sell_price intValue]+[self.matchmodel.sell_price intValue]];
        [self absPushViewController:pay animated:YES];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:
     @{
       @"action"   : @"matchApply",
       @"match_id" : self.tagID
       }
         successBlock:^(BaseModel *response) {
             if([response.errorno isEqualToString:@"0"]){
                 
                 
                 self.matchmodel =response.data.match;
                 self.videomodel =response.data.video;
                 self.teammodel  =response.data.myteam;
                 
                 
                 
                 [self setInfo];
                
             }

            
             
         } failureBlock:^(NSError *error) {
             
         }];
}

-(void)setInfo{
    [self.matchPic  sd_setImageWithURL:imgUrl(self.matchmodel.cover) placeholderImage:nil];
    self.matchTitle.text =self.matchmodel.name;
    self.matchTime .text =  [NSString stringWithFormat:@"%@|%@",self.matchmodel.start_time,self.matchmodel.county];
    self.matchPrice.autoresizingMask=NO;
 
    self.matchPriceW.constant =[self getTextHeight:24 text: [NSString stringWithFormat:@"¥%@ ",self.matchmodel.sell_price] font:FontBold(17)];
    
    self.matchPrice.text =  [NSString stringWithFormat:@"¥%@ ",self.matchmodel.sell_price];
    
    
    self.matchPriceOri.text = self.matchmodel.price;
    
    self.videoName.text =self.videomodel.name;
    self.videoPrice.autoresizingMask =NO;
    self.videoPriceW.constant =[self getTextHeight:18 text: [NSString stringWithFormat:@"¥%@ ",self.videomodel.sell_price] font:FontBold(13)]+5;
    self.videoPrice.text =  [NSString stringWithFormat:@"¥%@ ",self.videomodel.sell_price];
    
    self.videoCountPrice.text = [NSString stringWithFormat:@"¥%d",[self.videomodel.sell_price intValue]+[self.matchmodel.sell_price intValue]];
    
    self.teamName.text = self.teammodel.team_name;
    self.teamNum.text = [NSString stringWithFormat:@"%@人",self.teammodel.members];
    
}

@end
