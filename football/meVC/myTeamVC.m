//
//  myTeamVC.m
//  football
//
//  Created by 雨停 on 2017/8/1.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "myTeamVC.h"
#import "teamNameCell.h"
#import "addTeamVC.h"
@interface myTeamVC ()<UITableViewDelegate,UITableViewDataSource >
@property  (nonatomic,strong)UITableView * myTab;
@property  (nonatomic,strong)NSMutableArray * arr;
@end

@implementation myTeamVC
- (id)init{
    if(self = [super init]){
        self.from = [NSString string];
    }
    return self;
}
- (void)viewDidLoad {
    self.arr  = [NSMutableArray array];
    [super viewDidLoad];
    [self setSubview];
    
}
-(void)setSubview{
    if([self.from isEqualToString:@"me"]){
         self.title =@"我的球队";
    }else{
         self.title =@"修改球队";
    }
   
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.myTab  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    self.myTab.dataSource = self;
    self.myTab.delegate   = self;
    self.myTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTab.tableFooterView = [self setBottomView];
    [self.myTab registerNib:[UINib nibWithNibName:@"teamNameCell" bundle:nil] forCellReuseIdentifier:@"team"];
    [self.view addSubview:self.myTab];
}
-(void)leftItemClick:(id)sender{
    if([self.from isEqualToString:@"me"]){
    [self dismissViewControllerAnimated:YES completion:nil];
    }
        [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    teamNameCell * cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"team"];
    cell.dic = self.arr[indexPath.row];
    if([self.from isEqualToString:@"signup"]){
        cell.rightPic.image =Img(@"nocheak");
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.from isEqualToString:@"signup"]){
  teamNameCell*cell = [tableView cellForRowAtIndexPath:indexPath];
  cell.rightPic.image =Img(@"cheak");
    }
    else if
        ([self.from isEqualToString:@"me"]){
            addTeamVC * team = [[addTeamVC alloc]init];
       
            team.from  = [self.arr[indexPath.row] objectForKey:@"id"];
            team.style = [self.arr[indexPath.row] objectForKey:@"id"];

            [self.navigationController pushViewController:team animated:YES];

    }
 }
 -(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
     if([self.from isEqualToString:@"signup"]){
     teamNameCell *cell = [tableView cellForRowAtIndexPath:indexPath];
     cell.rightPic.image =Img(@"nocheak");}
 }
-(UIView *)setBottomView{
    UIView * bottom = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 80)];
    bottom. backgroundColor = KRgb(0.91, 0.91, 0.91);
    UIButton  * btn =[XYUIKit buttonWithBackgroundColor:KClearColor titleColor:KGrayColor titleHighlightColor:KClearColor title:@"+添加新球队" fontSize:17];
    btn .frame = CGRectMake(40, 18, KScreenWidth-80, 44);
    btn.layer .borderWidth =1;
    btn.layer.borderColor =KGrayColor.CGColor;
    [bottom   addSubview:btn];
    [btn addTarget: self  action:@selector(writeInfo:) forControlEvents:UIControlEventTouchUpInside];
    return bottom  ;
}
- (void)writeInfo:(UIButton *)sender{
    if(self.arr.count==11){
        [SVProgressHUD showErrorWithStatus:@"球队数量已达上限"];
        return;
    }
    
    addTeamVC * team = [[addTeamVC alloc]init];
    team.from =@"setup";
    [self.navigationController pushViewController:team animated:YES];
}
//IOS9前自定义左滑多个按钮需实现此方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除模型
        [self requestType:HttpRequestTypePost url:nil
           parameters:@{
                        @"action": @"delMyTeam",
                        @"team_id": [self.arr[indexPath.row] objectForKey:@"id"]}
             successBlock:^(BaseModel *response) {
    [self.arr removeObjectAtIndex:indexPath.row];
    // 刷新
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];

    
} failureBlock:^(NSError *error) {
    
}];
   }

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


-(void)viewWillAppear:(BOOL)animated{
    
    
    appInfoModel * model = [appInfoModel yy_modelWithDictionary:[ball getObjectById:@"urlInfo" fromTable:@"person"]];
    NSMutableDictionary  * dic =[NSMutableDictionary  dictionary];
    [dic addEntriesFromDictionary:@{
                                     @"client_id"    : model.app_key,
                                     @"state"        : model.seed_secret,
                                     @"access_token" : model.access_token,
                                     @"action"       : @"getMyTeamList",
                                     }];
    [RequestManager requestWithType:HttpRequestTypePost
                          urlString:model.source_url
                         parameters:dic
                       successBlock:^(id response){
                    
                           if([[response objectForKey:@"errno"] isEqualToString:@"0"]){
                           [self.arr removeAllObjects];
                           [self.arr addObjectsFromArray:[response objectForKey:@"data"]];
                           [self.myTab reloadData];
                           }
                       }failureBlock:^(NSError *error) {
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
    
    
}

@end
