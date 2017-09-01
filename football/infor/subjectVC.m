//
//  subjectVC.m
//  football
//
//  Created by 雨停 on 2017/6/30.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "subjectVC.h"
#import "youthCell.h"
#import "classDetaileVC.h"
#import "SDAutoLayout.h"
#import "coursesModel.h"
@interface subjectVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView      * tab;
@property (nonatomic , strong) NSMutableArray   * arr;
@property (nonatomic , assign) int        page;
@end

@implementation subjectVC

- (void)viewDidLoad {
    self.arr = [NSMutableArray array];
    self.title = @"全部青训课程";
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    [super viewDidLoad];
    [self setSubview];
    [self loadNewData];
}
-(void)leftItemClick:(id)sender{
    [self absPopNav];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSubview{
    self.tab = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tab];
    [self.tab registerClass:[youthCell class] forCellReuseIdentifier:NSStringFromClass([youthCell class])];
    self.tab.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    self.tab.mj_footer =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Class  currentClass = [youthCell class];
    youthCell  * cell =nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model= self.arr[indexPath.row];
    return  cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    classDetaileVC * Detaile = [[classDetaileVC alloc]init];
    coursesModel  * model  =self.arr[indexPath.row];
    Detaile.infoID = model.id;
    [self absPushViewController:Detaile animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
        /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
        return [tableView cellHeightForIndexPath:indexPath model:self.arr[indexPath.row] keyPath:@"model" cellClass:[youthCell class] contentViewWidth:[self cellContentViewWith]];
}


- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
- (void)loadNewData{
    self.page =1;
    [self  sendRequest];
    [self.tab.mj_header endRefreshing];
}
- (void)loadMoreData{
    [self  sendRequest];
    [self.tab.mj_footer  endRefreshing];
}
-(void)sendRequest {
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{@"action"       : @"getRecommendCourses",
                        @"page"         : [NSString stringWithFormat:@"%d",self.page]} successBlock:^(BaseModel *response) {
                            if([response.errorno isEqualToString:@"0"]){
                                if(self.page==1){
                                    [self.arr removeAllObjects];
                                }
                                [self.arr addObjectsFromArray:response.data.courses];
                                [self.tab reloadData];
                                self.page ++;
                            }
                        } failureBlock:^(NSError *error) {
                            
                        }];
    
}


@end
