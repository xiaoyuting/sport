//
//  InfoSetVC.m
//  football
//
//  Created by 雨停 on 2017/7/13.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "InfoSetVC.h"
#import "InfoSetCell.h"
#import "KSDatePicker.h"
#import "DPPopUpMenu.h"
#import "ZYInputAlertView.h"
static const float RealSrceenHight =  667.0;
static const float RealSrceenWidth =  375.0;
#define AdaptationH(x) x/RealSrceenHight*[[UIScreen mainScreen]bounds].size.height
#define AdaptationW(x) x/RealSrceenWidth*[[UIScreen mainScreen]bounds].size.width
#define AdapationLabelFont(n) n*([[UIScreen mainScreen]bounds].size.width/375.0f)
@interface InfoSetVC ()<UITableViewDelegate,UITableViewDataSource,DPPopUpMenuDelegate>
@property (nonatomic,strong)UITableView  * tab;
@property (nonatomic,strong)UILabel      * promort;
@property (nonatomic, strong) UIButton    * selectBtn;
@property (nonatomic,strong) NSMutableArray  * arr ;
@property (strong, nonatomic)  UIButton *typeBtn;
@end

@implementation InfoSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview ];
   
    self.automaticallyAdjustsScrollViewInsets = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setSubview{
    NSArray * arr = @[
  @{@"title":@"真实姓名",@"detaile":@"姓名"},
  @{@"title":@"出生日期",@"detaile":@"1991-05-01"},
  @{@"title":@"性别",@"detaile":@"男"},
  @{@"title":@"身高",@"detaile":@"180CM"},
  @{@"title":@"体重",@"detaile":@"65KG"},
  @{@"title":@"惯用脚",@"detaile":@"右脚"}];
    self.arr = [NSMutableArray arrayWithArray:arr];
    self.title = @"完善个人信息";
    //创建一个UIButton
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 24)];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //覆盖返回按键
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self setNavRightItemTitle:@"跳过" andImage:nil];
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, 272) style:UITableViewStylePlain ];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    [self.tab registerClass:[InfoSetCell class] forCellReuseIdentifier:NSStringFromClass([InfoSetCell class])];
    [self.view addSubview:self.tab];
    
    self.promort = [XYUIKit labelWithTextColor:[UIColor lightGrayColor] numberOfLines:1 text:@"完善个人信息有助于帮你找到最佳的青训训练与足球赛事" fontSize:12];
    self.promort.frame = CGRectMake(17, self.tab.bottom+7.5, KScreenWidth-51, 18);

    [self.view addSubview:self.promort];
    
    self.selectBtn = [XYUIKit buttonWithBackgroundColor:mainColor titleColor:[UIColor whiteColor] title:@"确定" fontSize:14];
    [self.selectBtn addTarget:self action:@selector(setInfo) forControlEvents:UIControlEventTouchUpInside];
    self.selectBtn.frame = CGRectMake(48, self.promort.bottom+42, KScreenWidth-96, 46);
    self.selectBtn.layer.cornerRadius = 4;
    [self.view addSubview:self.selectBtn];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.arr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Class currentClass = [InfoSetCell class];
    InfoSetCell * cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row==0){
        cell.img.hidden=YES;
    }
    NSDictionary * dic =self.arr[indexPath.row];
    cell.title.text =  [dic objectForKey:@"title"];
    cell.detile.text = [dic objectForKey:@"detaile"];
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (void)rightItemClick:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==0){
        
    }
    if(indexPath.row==1){
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, AdaptationW(300), AdaptationH(300))];
        //配置中心，详情见KSDatePikcerApperance
        picker.appearance.radius = 5;
        //设置回调
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit || buttonType==KSDatePickerWeakButtonTag || buttonType==KSDatePickerMonthButtonTag || buttonType==KSDatePickerThreeMonthButtonTag) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary: self.arr[1]];
                [dic setValue:[formatter stringFromDate:currentDate] forKey:@"detaile"];
                [self.arr setObject:dic  atIndexedSubscript:1];
                [self.tab reloadData];
                           }};
        // 显示
        [picker show];

    }else if(indexPath.row==2){
        DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
        men.titleText=@"性别";
        men.delegate=self;
        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"保密",@"name",@"0",@"typeID",[NSString stringWithFormat:@"%ld",indexPath.row],@"cellID", nil];
        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"男",@"name",@"1",@"typeID",[NSString stringWithFormat:@"%ld",indexPath.row],@"cellID", nil];
        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"女",@"name",@"2",@"typeID",[NSString stringWithFormat:@"%ld",indexPath.row],@"cellID", nil];
        men.dataArray = [NSArray arrayWithObjects:dic1,dic2,dic3, nil];
        [men show];

    }
    else if(indexPath.row==5){
        DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
        men.titleText=@"惯用脚";
        men.delegate=self;
        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"左脚",@"name",@"1",@"typeID",[NSString stringWithFormat:@"%ld",indexPath.row],@"cellID", nil];
        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"右脚",@"name",@"2",@"typeID",[NSString stringWithFormat:@"%ld",indexPath.row],@"cellID", nil];
        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"左右均衡",@"name",@"3",@"typeID",[NSString stringWithFormat:@"%ld",indexPath.row],@"cellID", nil];
                men.dataArray = [NSArray arrayWithObjects:dic1,dic2,dic3, nil];
        [men show];
    }else if(indexPath.row==3){
        __weak typeof(self) weakSelf = self;
        
        ZYInputAlertView *alertView = [ZYInputAlertView alertView];
        alertView.inputTextView.keyboardType = UIKeyboardTypeNumberPad;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary: self.arr[indexPath.row]];
        alertView.inputTextView.keyboardType =UIKeyboardTypeNumberPad;
        alertView.placeholder =[dic objectForKey:@"title"] ;
        [alertView confirmBtnClickBlock:^(NSString *inputString) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary: self.arr[indexPath.row]];
            [dic setValue:[NSString stringWithFormat:@"%@CM", inputString] forKey:@"detaile"];
            [weakSelf.arr setObject:dic  atIndexedSubscript:indexPath.row];
            [weakSelf.tab reloadData];
        }];
        [alertView show];
    }else if(indexPath.row==4){
        __weak typeof(self) weakSelf = self;
        
        ZYInputAlertView *alertView = [ZYInputAlertView alertView];
        alertView.inputTextView.keyboardType = UIKeyboardTypeNumberPad;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary: self.arr[indexPath.row]];
        alertView.placeholder =[dic objectForKey:@"title"] ;
        [alertView confirmBtnClickBlock:^(NSString *inputString) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary: self.arr[indexPath.row]];
            [dic setValue:[NSString stringWithFormat:@"%@KG", inputString] forKey:@"detaile"];
            [weakSelf.arr setObject:dic  atIndexedSubscript:indexPath.row];
            [weakSelf.tab reloadData];
        }];
        [alertView show];
    }

    
    else{
        __weak typeof(self) weakSelf = self;
        
        ZYInputAlertView *alertView = [ZYInputAlertView alertView];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary: self.arr[indexPath.row]];
        alertView.placeholder =[dic objectForKey:@"title"] ;
        [alertView confirmBtnClickBlock:^(NSString *inputString) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary: self.arr[indexPath.row]];
            [dic setValue:inputString forKey:@"detaile"];
            [weakSelf.arr setObject:dic  atIndexedSubscript:indexPath.row];
            [weakSelf.tab reloadData];
        }];
        [alertView show];
    }
    
}
-(void)DPPopUpMenuCellDidClick:(DPPopUpMenu *)popUpMeunView withDic:(NSDictionary *)dic{

    NSLog(@"%@",[dic objectForKey:@"name"]);
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary: self.arr[  [[dic objectForKey:@"cellID"] integerValue]]];
    [d setValue:[dic objectForKey:@"name"] forKey:@"detaile"];
    [self.arr setObject:d  atIndexedSubscript:[[dic objectForKey:@"cellID"] integerValue]];
    [self.tab reloadData];
}
-(void)setInfo{
    NSString * leg =@"3";
    NSString * sex =@"0";
    if( [[self.arr[2] objectForKey:@"detaile"]isEqualToString:@"男"]){
        sex=@"1";
    }else if([[self.arr[2] objectForKey:@"detaile"]isEqualToString:@"女"]){
        sex=@"2";
    }
    if( [[self.arr[5] objectForKey:@"detaile"]isEqualToString:@"右脚"]){
        leg=@"1";
    }else if([[self.arr[5] objectForKey:@"detaile"]isEqualToString:@"左脚"]){
        leg=@"2";
    }
    NSString * height =[self.arr[3] objectForKey:@"detaile"];
    
    NSString * SubHeight = [height substringWithRange:NSMakeRange(0, height.length-2)];
    NSString * weight =[self.arr[4] objectForKey:@"detaile"];
    
    NSString * SubWeight = [weight substringWithRange:NSMakeRange(0, weight.length-2)];

    
    NSDictionary*dic =
  @{
    @"action"   : @"saveBaseUserInfo",
    @"truename" :  [self.arr[0] objectForKey:@"detaile"],
    @"birthday" :  [self.arr[1] objectForKey:@"detaile"],
    @"sex"      :  sex,     //0保密1男2女
    @"height"   :  SubHeight ,
    @"weight"   :  SubWeight ,
    @"leg"      : leg,
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
