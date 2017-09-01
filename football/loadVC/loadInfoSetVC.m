//
//  loadInfoSetVC.m
//  football
//
//  Created by 雨停 on 2017/8/21.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "loadInfoSetVC.h"
#import "KSDatePicker.h"
#import "DPPopUpMenu.h"
#import "ZYInputAlertView.h"
static const float RealSrceenHight =  667.0;
static const float RealSrceenWidth =  375.0;
#define AdaptationH(x) x/RealSrceenHight*[[UIScreen mainScreen]bounds].size.height
#define AdaptationW(x) x/RealSrceenWidth*[[UIScreen mainScreen]bounds].size.width
#define AdapationLabelFont(n) n*([[UIScreen mainScreen]bounds].size.width/375.0f)
@interface loadInfoSetVC ()<DPPopUpMenuDelegate>
@property (nonatomic,copy)NSString   * sexTag;
@property (nonatomic,copy)NSString   * footTag;
@end

@implementation loadInfoSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sexTag  = @"1";
    self.footTag = @"3";
    self.name.text=@"";
    self.title = @"完善个人信息";
    [self setNavRightItemTitle:@"跳过" andImage:nil];
    //创建一个UIButton
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 24)];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //覆盖返回按键
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)rightItemClick:(id)sender{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ageSet:(UIButton *)sender {
    KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, AdaptationW(300), AdaptationH(300))];
    //配置中心，详情见KSDatePikcerApperance
    picker.appearance.radius = 5;
    //设置回调
    picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
        if (buttonType == KSDatePickerButtonCommit || buttonType==KSDatePickerWeakButtonTag || buttonType==KSDatePickerMonthButtonTag || buttonType==KSDatePickerThreeMonthButtonTag) {
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            
            
            self.age.text = [formatter stringFromDate:currentDate] ;
        }};
    // 显示
    [picker show];

}
- (IBAction)sexSet:(UIButton *)sender {
    DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
    men.titleText=@"性别";
    men.delegate=self;
    men.tag=0;
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"保密",@"name",@"0",@"typeID" , nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"男",@"name",@"1",@"typeID" , nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"女",@"name",@"2",@"typeID" , nil];
    men.dataArray = [NSArray arrayWithObjects:dic1,dic2,dic3, nil];
    [men show];

}
- (IBAction)heifhtSet:(UIButton *)sender {
    DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
    men.titleText=@"身高";
    men.tag=1;
    men.delegate=self;
    NSString *path=[[NSBundle mainBundle] pathForResource:@"personfooter" ofType:@"plist"];
    men.dataArray =  [[NSArray arrayWithContentsOfFile:path] subarrayWithRange:NSMakeRange(60, 170)];
    [men show];
}

- (IBAction)weightSet:(UIButton *)sender {
    DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
    men.titleText=@"体重";
    men.tag=2;
    men.delegate=self;
    NSString *path=[[NSBundle mainBundle] pathForResource:@"personfooter" ofType:@"plist"];
    men.dataArray =  [[NSArray arrayWithContentsOfFile:path] subarrayWithRange:NSMakeRange(30, 170)];
    [men show];
}
- (IBAction)footSet:(UIButton *)sender {
    
    DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
    men.titleText=@"惯用脚";
    men.delegate=self;
    men.tag=3;
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"左脚",@"name",@"1",@"typeID" , nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"右脚",@"name",@"2",@"typeID",  nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"左右均衡",@"name",@"3",@"typeID",  nil];
    men.dataArray = [NSArray arrayWithObjects:dic1,dic2,dic3, nil];
    [men show];
}

-(void)DPPopUpMenuCellDidClick:(DPPopUpMenu *)popUpMeunView withDic:(NSDictionary *)dic{
    
    //NSLog(@"%@",[dic objectForKey:@"name"]);
    
    if(popUpMeunView.tag==0){
        self.sexTag = [dic objectForKey:@"typeID"];
        self.sex.text = [dic objectForKey:@"name"];
    }else if(popUpMeunView.tag==1){
        self.height.text = [dic objectForKey:@"name"];
    }else if(popUpMeunView.tag==2){
        self.weight.text = [dic objectForKey:@"name"];
    }else if(popUpMeunView.tag==3){
        self.foot.text = [dic objectForKey:@"name"];
        self.footTag = [dic objectForKey:@"typeID"];
    }
}


- (IBAction)setPush:(UIButton *)sender {
    [self setInfo];
}
-(void)setInfo{
    
    
    NSDictionary*dic =
    @{
      @"action"   : @"saveBaseUserInfo",
      @"truename" :  self.name.text,
      @"birthday" :  self.age.text,
      @"sex"      :  self.sexTag,     //0保密1男2女
      @"height"   :  self.height.text ,
      @"weight"   :  self.weight.text ,
      @"leg"      :  self.footTag,
      } ;  // 惯用脚：1右脚2左脚3左右均衡
    
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:dic
         successBlock:^(BaseModel *response) {
             
             if([response .errorno    isEqualToString:@"0"]){
                 [self.navigationController popToRootViewControllerAnimated:YES];
             }
             
         } failureBlock:^(NSError *error) {
             
         }];
}

@end
