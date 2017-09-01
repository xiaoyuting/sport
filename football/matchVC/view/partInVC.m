//
//  partInVC.m
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "partInVC.h"
#import "partInCell.h"
#import "teamHomeVC.h"
@interface partInVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView  * tab;
@property (nonatomic,strong)NSMutableArray * arr;
@end

@implementation partInVC
-(id)init{
    if(self = [super init]){
        self.idTag =[NSString string];
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = [NSMutableArray array];
    [self setSubview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSubview{
    
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.title =@"参赛球队";
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0,0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tab ];
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tab registerNib:[UINib nibWithNibName:@"partInCell" bundle:nil] forCellReuseIdentifier:@"partIn"];
    self.tab .delegate =self;
    self.tab .dataSource = self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count ;
}
-(void)leftItemClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 102;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    partInCell * cell =nil;

    cell = [tableView dequeueReusableCellWithIdentifier:@"partIn"];
    cell.dic = self.arr[indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    teamHomeVC *homeVc =[[teamHomeVC alloc]init];
    homeVc.teamID =[self.arr[indexPath.row] objectForKey:@"team_id"];
    homeVc.dic = self.arr[indexPath.row];
    [self.navigationController pushViewController:homeVc animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    appInfoModel * model = [appInfoModel yy_modelWithDictionary:[ball getObjectById:@"urlInfo" fromTable:@"person"]];
    NSDictionary  * dic =@{
                           @"client_id"    : model.app_key,
                           @"state"        : model.seed_secret,
                           @"access_token" : model.access_token,
                           @"action" : @"getApplyTeam",
                           @"match_id" : self.idTag

                           };
    
    [RequestManager requestWithType:HttpRequestTypePost
                          urlString:model.source_url
                         parameters:dic
                       successBlock:^(id response){
                           NSLog(@"%@",response);
                            [self.arr removeAllObjects];
                              if([[response objectForKey:@"errno"] isEqualToString:@"0"]){
                              [self.arr addObjectsFromArray:[response objectForKey:@"data"]];
                                  if(self.arr.count==0){
                                      [self showPlaceholderViewWithImage:Img(@"no_player") message:@"没有球队参赛" buttonTitle:nil centerOffsetY:0 onSuperView:self.view];
                                  }
                               [self.tab  reloadData];
                           }
                       }failureBlock:^(NSError *error) {
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
    
    /* NSDictionary * dic =@{
     @"action" : @"getMatchList",
     // @"page" : @"2",    //选填 页数
     // @"type" : @"11",   //选填 赛事赛制
     //@"status" :@"1",   //选填 比赛状态 1报名中2进行中
     // @"level" : @"19",  //选填  比赛级别
     // @"city" :@"310100",  //选填 城市id
     //@"county" : @"310104"  //选填  区县id
     
     };
     [self requestType:HttpRequestTypePost url:nil parameters:dic  successBlock:^(BaseModel *response) {
     
     } failureBlock:^(NSError *error) {
     
     }];*/
    
    
}

@end
