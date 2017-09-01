//
//  signupVC.m
//  football
//
//  Created by 雨停 on 2017/7/25.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "signupVC.h"
#import "SDAutoLayout.h"
#import "signUpCell.h"
#import "signUpsetCell.h"
#import "orderVC.h"
#import "sampleVideoVC.h"
#import "addTeamVC.h"
#import "appInfoModel.h"
#import "myVideoModel.h"
#import "myMatchModel.h"
#import "myTeamModel.h"
#import "myTeamVC.h"
#import "paySelectVC.h"
@interface signupVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView    * tab;
@property (nonatomic,strong)NSMutableArray * groupArr;
@property (nonatomic,strong)UIImageView    * hIcon;
@property (nonatomic,strong)UILabel        * hTitle;
@property (nonatomic,strong)UILabel        * hTimeaddress;
@property (nonatomic,strong)UIImageView    * hLine;
@property (nonatomic,strong)UILabel        * hPrice;
@property (nonatomic,strong)UILabel        * hOriginalprice;

@property (nonatomic,strong) NSArray * arrInfo;
@property (nonatomic,strong) myMatchModel * matchmodel;
@property (nonatomic,strong) myVideoModel  * videomodel;
@property (nonatomic,strong) myTeamModel  * teammodel;
@property (nonatomic,copy)  NSString     * coachName;
@property (nonatomic,copy)  NSString     * num;
@property (nonatomic,copy)  NSString     * teamName;
@property (nonatomic,copy)  NSString     * phone;
@end

@implementation signupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
    // Do any additional setup after loading the view.
}
-(id)init{
    if(self=[super init]){
       self.tagID = [NSString string];
    }
    return self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setSubview{
    self. arrInfo = @[
                      @{@"title":@"报名球队",@"detaile":@"选择球队"},
                      @{@"title":@"参数队员",@"detaile":@"人数"},
                      @{@"title":@"联系人" , @"detaile":@"联系人姓名"},
                      @{@"title":@"联系电话",@"detaile":@"66666666"}
                      ];
    self.view.backgroundColor =KWhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self. groupArr = [NSMutableArray array];
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.title =@"赛事报名";
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-110) style:UITableViewStyleGrouped ];
    self.tab.delegate   = self;
    self.tab.dataSource = self;
    [self.tab registerClass:[signUpCell class] forCellReuseIdentifier:NSStringFromClass([signUpCell class])];
    [self.tab registerClass:[signUpsetCell class] forCellReuseIdentifier:NSStringFromClass([signUpsetCell class])];
    self.tab.tableHeaderView = [self headView];
    self.tab.tableFooterView = [self footView];

    [self.view addSubview:self.tab];
    
   
    UIButton * btn = [XYUIKit buttonWithBackgroundColor:KRgb(1, 0.23, 0.19) titleColor:KWhiteColor title:@"去支付" fontSize:20];
    [btn addTarget:self action:@selector(goOrder:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, KScreenHeight-46, KScreenWidth, 46);
    [self.view addSubview: btn];
}
-(void)leftItemClick:(id)sender{
    [self.navigationController   popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0){
        return 2;
    }else if(section==1){
        return 4;
    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
    signUpCell * cell=nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([signUpCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row==0){
            cell.title.text = @"购买定制视屏";
            cell.price.text = [NSString stringWithFormat:@"¥%@", self.videomodel.sell_price];
            cell.detile.text = self.videomodel.name;
        }else if(indexPath.row==1){
            cell.title.text = @"商品总金额";
            
            cell.countprice.text = [NSString stringWithFormat:@"¥%d",[self.matchmodel.sell_price intValue]+[self.videomodel.sell_price intValue] ];
            cell.imgR.alpha=0;
        }
      
    return cell;
    }else if(indexPath.section==1){
        signUpsetCell * cell=nil;
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([signUpsetCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
      
        if(indexPath.row==1){
            cell.img.alpha=0;
        }
        cell.dic =self.arrInfo[indexPath.row];
        return cell;
    }else{
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  {
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==1){
       return 10;
    }else{
    return 0.00000001;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row==0){
            sampleVideoVC *sample = [[sampleVideoVC alloc]init];
            [self.navigationController pushViewController:sample animated:YES];
            
        }
    }else if (indexPath.section==1){
        if(indexPath.row==0){
            myTeamVC * teamVC = [[myTeamVC alloc]init];
            
            
            teamVC.from =@"signup";
            
            [self.navigationController pushViewController:teamVC  animated:YES];
        }
    }
}
-(UIView *)footView{
    UIView * foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 44)];
    foot.backgroundColor =RGBColor(249, 249, 249);
    UIButton * left = [XYUIKit buttonWithBackgroundColor:KWhiteColor titleColor:KRgb(0.09, 0.66, 0.93)  title:@"退款说明" fontSize:13];
    UIButton * right = [XYUIKit buttonWithBackgroundColor:KWhiteColor titleColor:KRgb(0.09, 0.66, 0.93)  title:@"免责申明" fontSize:13];
    left.frame =CGRectMake(0, 0, KScreenWidth/2.0-0.5, 44);
    right.frame =CGRectMake(KScreenWidth/2.0+0.5, 0, KScreenWidth/2.0-0.5, 44);
    left.tag=0;right.tag=1;
    [foot addSubview:left];
    [foot addSubview:right];
    return  foot;
}
-(UIView *)headView{
    UIView * head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 140)];
    
    self.hIcon  = [[UIImageView alloc]init];
    _hIcon.contentMode = UIViewContentModeScaleAspectFill;
    _hIcon.layer.masksToBounds =YES;
    self.hTitle = [XYUIKit labelWithTextColor:KRgb(0.07, 0.07, 0.07) numberOfLines:0 text:nil fontSize:13];
    self.hTimeaddress = [XYUIKit labelWithTextColor:KGrayColor numberOfLines:0 text:nil fontSize:13];
    self.hLine =[[UIImageView alloc]init];
    self.hLine.backgroundColor = RGBColor(229, 229, 229);
    self.hPrice = [XYUIKit labelWithTextColor:KmainRed numberOfLines:0 text:nil fontSize:17];
    self.hPrice.font = Font(@"PingFangSC-Semibold",17);
    self.hOriginalprice = [XYUIKit labelWithTextColor:KRgb(0.8, 0.81, 0.82) numberOfLines:0 text:nil fontSize:13];
    [head sd_addSubviews:@[self.hIcon,self.hTitle,self.hTimeaddress,self.hLine,self.hPrice,self.hOriginalprice]];
    self.hIcon.sd_layout
    .leftSpaceToView(head, 16)
    .topSpaceToView(head, 15)
    .heightIs(64)
    .widthIs(64);
    
    self.hTitle.sd_layout
    .leftSpaceToView(self.hIcon, 16)
    .topSpaceToView(head, 15)
    .rightSpaceToView(head, 15)
    .autoHeightRatio(0);
    
    self.hTimeaddress.sd_layout
    .leftSpaceToView(self.hIcon, 15)
    .topSpaceToView(self.hTitle, 8)
    .rightSpaceToView(head, 15)
    .autoHeightRatio(0);
    
    self.hLine.sd_layout
    .topSpaceToView(self.hIcon, 16)
    .leftSpaceToView(head, 0)
    .rightSpaceToView(head, 0)
    .heightIs(1);
    
    self.hPrice.sd_layout
    .leftSpaceToView(head, 16)
    .topSpaceToView(self.hLine, 10)
    .heightIs(24);
    [self.hPrice setSingleLineAutoResizeWithMaxWidth:100];
    
    self.hOriginalprice.sd_layout
    .leftSpaceToView(self.hPrice, 7)
    .centerYEqualToView(self.hPrice)
    .heightIs(18);
    [self.hOriginalprice  setSingleLineAutoResizeWithMaxWidth:100];
    // 设置view1高度根据子其内容自适应
    head.backgroundColor = KWhiteColor;
    return head;
}
-(void)setInfo{
    [self.hIcon  sd_setImageWithURL:imgUrl(self.matchmodel.cover) placeholderImage:nil];
    self.hTitle.text =self.matchmodel.name;
    self.hTimeaddress .text =  [NSString stringWithFormat:@"%@|%@",self.matchmodel.start_time,self.matchmodel.county];
    self.hPrice.text =  [NSString stringWithFormat:@"¥%@ ",self.matchmodel.sell_price];
    self.hOriginalprice.text = self.matchmodel.price;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)viewDidLayoutSubviews
{
    if ([self.tab respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tab setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tab respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tab setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)goOrder:(UIButton *)sender{
    
    orderVC * order = [[orderVC alloc]init];
    order.price = [NSString stringWithFormat:@"¥%d",[self.matchmodel.sell_price intValue]+[self.videomodel.sell_price intValue] ];
    [self.navigationController pushViewController:order animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:
         @{
         @"action"   : @"matchApply",
          @"match_id": self.tagID
           }
         successBlock:^(BaseModel *response) {
             if([response.errorno isEqualToString:@"0"]){
                 
                 
                 self.matchmodel =response.data.match;
                 self.videomodel =response.data.video;
                 self.teammodel  =response.data.myteam;
                 if(!self.teammodel){
                     self. arrInfo = @[
                                       @{@"title":@"报名球队",@"detaile":@"暂无球队"},
                                       @{@"title":@"参数队员",@"detaile":@""},
                                       @{@"title":@"联系人" , @"detaile":@""},
                                       @{@"title":@"联系电话",@"detaile":@""}
                                       ];
                 }else{
                     self. arrInfo = @[
                                       @{@"title":@"报名球队",@"detaile":self.teammodel.team_name},
                                       @{@"title":@"参数队员",@"detaile":self.teammodel.members},
                                       @{@"title":@"联系人" , @"detaile":@""},
                                       @{@"title":@"联系电话",@"detaile":@""}
                                       ];
                 }
                
                     [self setInfo];
                 [self.tab reloadData];
             }
            // mymatchModel * matchmodel;
            //  myViewModel  * videomodel;
            // myTeamModel  * teammodel;
    
} failureBlock:^(NSError *error) {
    
}];
}
@end
