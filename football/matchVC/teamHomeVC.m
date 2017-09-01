//
//  teamHomeVC.m
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "teamHomeVC.h"
#import "homePersonCell.h"
#import "appInfoModel.h"
#import "membersModel.h"
#import "homeBaseModel.h"
#import "homeParamModel.h"
#import "homePersonModel.h"
@interface teamHomeVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTab;
@property  (nonatomic,strong)NSMutableArray  * arrGroup;
@property  (nonatomic,strong)NSMutableArray  * arrCoach;
@property  (nonatomic,strong)NSMutableArray  * arrTitle;


@property (weak, nonatomic) IBOutlet UIImageView *teamPic;
@property (weak, nonatomic) IBOutlet UILabel *teamDetaile;
@property (weak, nonatomic) IBOutlet UILabel *draw;
@property (weak, nonatomic) IBOutlet UILabel *integral;
@property (weak, nonatomic) IBOutlet UILabel *win;
@property (weak, nonatomic) IBOutlet UILabel *rank;
@property (weak, nonatomic) IBOutlet UILabel *loss;
@property  (nonatomic,strong)NSMutableArray  * arrPlayer;
@end

@implementation teamHomeVC
-(id)init{
    if(self = [super init]){
        self.teamID = [NSString string];
        self.dic = [NSDictionary dictionary];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
}
-(void)setSubview{
    self.arrTitle  = [NSMutableArray array];
    self.arrCoach  = [NSMutableArray array];
    self.arrPlayer = [NSMutableArray array];
    self.arrGroup  = [NSMutableArray array];
    self.teamPic.layer.cornerRadius =  35;
    self.teamPic.layer.masksToBounds=YES;
   
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.title=@"球队主页";
     self.myTab.separatorStyle = UITableViewScrollPositionNone;
    [self.myTab registerNib:[UINib nibWithNibName:@"homePersonCell" bundle:nil] forCellReuseIdentifier:@"homePerson"];
    
}
-(void)leftItemClick:(id)sender{
    [self.navigationController    popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrGroup.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr =self.arrGroup[section];
    return    arr.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    UILabel * lab = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KGrayColor textAlignment:NSTextAlignmentLeft numberOfLines:0 text:nil fontSize:13];
    [view addSubview:lab];
    lab.frame = CGRectMake(20, 8, 200, 32);
    lab.text = self.arrTitle[section];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section    {
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section    {
    return 40;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    homePersonCell  * cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"homePerson"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    NSArray * arr =self.arrGroup[indexPath.section];
    cell.model = arr[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 102;
}
-(void)viewWillAppear:(BOOL)animated{
    [self requestType:HttpRequestTypePost
                  url:nil parameters:@{ @"action" : @"getTeamHomePage",
                                        @"team_id" : self.teamID

                                                }
         successBlock:^(BaseModel *response) {
             appInfoModel * model = response.data;
             
             
             if([response .errorno   isEqualToString:@"0"]){
                 
                 [self.arrGroup removeAllObjects];
                 [self.arrTitle removeAllObjects];
                 [self.arrCoach removeAllObjects];
                 [self.arrPlayer removeAllObjects];


                 
                 homeBaseModel * homeBase = model.base;
                 if(homeBase){
        self.teamName.text = homeBase.name;
        self.teamDetaile.text    = homeBase.descrip;
        [self.teamPic sd_setImageWithURL:imgUrl(homeBase.logo) placeholderImage:nil];
                 }
                 homeParamModel *paramModel =model.param;
                 if(paramModel){
        self.draw.text =  [NSString stringWithFormat:@"排名:%@",paramModel.draw];
        self.integral.text =  [NSString stringWithFormat:@"积分:%@",paramModel.integral];
        self.loss.text  =  [NSString stringWithFormat:@"负:%@",paramModel.loss];
        self.win.text = [NSString stringWithFormat:@"胜:%@",paramModel.win];
        self.rank.text = [NSString stringWithFormat:@"平:%@", paramModel.ranking];
                 }
                 membersModel   * membModel = model.members;
                 if(membModel){
                     if(membModel.coach){
                         [self.arrCoach  addObjectsFromArray:membModel.coach];
                         
                     }
                     if(membModel.assists){
                         [self.arrCoach   addObjectsFromArray:membModel.assists];
                     }
                     if(membModel.player){
                         [self.arrPlayer addObjectsFromArray:membModel.player];
                     }
                 }
                 if(self.arrPlayer.count!=0){
                    [self.arrGroup insertObject:self.arrPlayer atIndex:0];
                     [self.arrTitle insertObject:@"球员" atIndex:0];
                 }
            if(self.arrCoach.count!=0){
                     [self.arrGroup insertObject:self.arrCoach atIndex:0];
                     [self.arrTitle insertObject:@"教练" atIndex:0];
                 }
                        
             [self.myTab reloadData];
             }
         } failureBlock:^(NSError *error) {
             
         }];
}

@end
