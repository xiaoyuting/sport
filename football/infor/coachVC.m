//
//  coachVC.m
//  football
//
//  Created by 雨停 on 2017/6/30.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "coachVC.h"
#import "coachCell.h"
#import "coachDetaileVC.h"
#import "coachesModel.h"
@interface coachVC ()<UITableViewDelegate,UITableViewDataSource>
@property  (nonatomic, strong)UITableView    * tab;
@property  (nonatomic,strong) NSMutableArray  * arr;
@property  (nonatomic,assign) int page;
@end

@implementation coachVC

- (void)viewDidLoad {
    self.arr  = [NSMutableArray array];
    [super viewDidLoad];
    [self setSubView];
    [self loadNewData];
}
-(void)setSubView{
    self.title = @"全部教练";
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.tab = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:self.tab];
    [self.tab registerClass:[coachCell class] forCellReuseIdentifier:NSStringFromClass([coachCell class])];
    self.tab.mj_header =[MJRefreshNormalHeader   headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    self.tab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
        
    }];
    

}
-(void)leftItemClick:(id)sender{
    [self absPopNav];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 103;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Class currentClass = [coachCell class];
    coachCell * cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model =self.arr[indexPath.row];
    return cell;
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    coachDetaileVC * coachDetaile = [[coachDetaileVC alloc]init];
    coachesModel  *  model =self.arr[indexPath.row];
    coachDetaile.coachID =model.id;
    [self absPushViewController:coachDetaile animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadNewData{
    self.page =1;
    [self sendRequest];
     [self.tab.mj_header endRefreshing];
}
-(void)loadMoreData{
    [self sendRequest];
    [self.tab.mj_footer endRefreshing];
    }
-(void)sendRequest{
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{@"action" : @"getRecommendCoaches",
                        @"page" : [NSString stringWithFormat:@"%d", self.page ]
                        //选填（页数）
                        }
         successBlock:^(BaseModel *response) {
             if([response.errorno  isEqualToString:@"0"]){
                 if(self.page==1){
                     [self.arr removeAllObjects];
                 }
                 [self.arr addObjectsFromArray:response.data.coaches];
                 [self.tab reloadData];
                 self.page ++;
             }
             
         } failureBlock:^(NSError *error) {
             
         }];
    

}
-(void)viewWillAppear:(BOOL)animated{
    }
@end
