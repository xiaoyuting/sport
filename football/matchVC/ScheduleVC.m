//
//  ScheduleVC.m
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "ScheduleVC.h"
#import "ABSSegmentCate.h"
#import "sampleMatchCell.h"
@interface ScheduleVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property  (strong, nonatomic)UIScrollView    * contentScrView;
@property  (nonatomic,strong)ABSSegmentCate   * segmentedControl;
@property (nonatomic,strong) NSMutableArray * arr;
@property (nonatomic,strong)NSMutableArray  * arrName;
@property (nonatomic,strong)NSMutableArray  * arrInfo;
@property (nonatomic,strong)NSMutableArray  * tabArr;
@end

@implementation ScheduleVC
-(id)init{
    if(self = [super init]){
        self.idTag =[NSString string];
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabArr  =[NSMutableArray array];
    self.arr     =[NSMutableArray array];
    self.arrName =[NSMutableArray array];
    self.arrInfo =[NSMutableArray array];
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.title =@"赛程表";
    
 
    // Do any additional setup after loading the view.
}
-(void)setSubview{
    if(self.arr.count==0){
        [self showPlaceholderViewWithImage:Img(@"no_match") message:@"没有赛程" buttonTitle:nil centerOffsetY:0 onSuperView:self.view];
        return;
    }
    [self setLine];
    CGFloat const kSegmentedControlHeight = 44;
    NSArray *dataArray = @[@"第一轮", @"第二轮",@"第三轮",@"第四轮", @"第五轮",@"第六轮",@"第七轮", @"第八轮",@"第九轮"];
    NSIndexSet * index = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.arr.count-1)];
    [self.arrName   addObjectsFromArray:[dataArray objectsAtIndexes:index]];
    self.segmentedControl = [self setSegframe:CGRectMake(0, 0, KScreenWidth, kSegmentedControlHeight) titleArr:self.arrName space:90];
    [self.view addSubview:_segmentedControl];
    
    
    CGFloat const kScrollViewHeight =KScreenHeight -44;
    self.contentScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, KScreenWidth, kScrollViewHeight)];
    [self.view  addSubview: self.contentScrView];
    self.contentScrView.contentSize = CGSizeMake(KScreenWidth * dataArray.count, kScrollViewHeight);
    self.contentScrView.delegate = self;
    self.contentScrView.pagingEnabled = YES;
    for (int i = 0; i < self.arrName.count; i ++) {
        CGFloat left = i * KScreenWidth;
        
        UITableView * tab = [[UITableView alloc]initWithFrame:CGRectMake(left, 0, KScreenWidth, kScrollViewHeight) style:UITableViewStylePlain];
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        tab.delegate = self;
        tab.dataSource = self;
        tab.tag=i;
        tab.tableHeaderView = [self headView];
        [self.contentScrView addSubview:tab];
        [tab registerNib:[UINib nibWithNibName:@"sampleMatchCell" bundle:nil] forCellReuseIdentifier:@"sampleMatchCell"];
         [self.tabArr addObject:tab];
            }
   
    [_segmentedControl segmentedControlSelectedWithBlock:^(ABSSegmentCate *segmentedControl, NSInteger selectedIndex) {
        NSLog(@"selectedIndex : %zd", selectedIndex);
        
        [self.contentScrView setContentOffset:CGPointMake(selectedIndex * KScreenWidth, 0) animated:YES];
    }];
    
}
#pragma mark -
#pragma mark - scrollView protocol methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if([scrollView isEqual:self.contentScrView]){
        NSInteger const kPageIndex = scrollView.contentOffset.x / KScreenWidth;
        [self.segmentedControl segmentedControlSetSelectedIndexWithSelectedBlock:kPageIndex];
        // 重设选中位置
        [self.segmentedControl segmentedControlSetSelectedIndex:kPageIndex];}
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    for (int i=0; i<self.arr.count; i++) {
        if(tableView.tag ==i){
            NSDictionary * dic = self.arr[i];
            NSArray * arr =[dic objectForKey:@"list"];
            return arr.count;
        }
    }
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    for (int i=0; i<self.arr.count; i++) {
        if(tableView.tag ==i){
            NSDictionary * dic = self.arr[i];
            NSArray * arr =[dic objectForKey:@"list"];
            Class currentClass = [sampleMatchCell class];
            sampleMatchCell * cell = nil;
           
            
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
             cell.dic =arr[indexPath.row];
            return cell;
        }
    }
    
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UIView *)headView{
    UIView * head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 16)];
    head.backgroundColor = KRgb(0.91, 0.91, 0.91);
    return head;
}
-(void)leftItemClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    appInfoModel * model = [appInfoModel yy_modelWithDictionary:[ball getObjectById:@"urlInfo" fromTable:@"person"]];
    NSDictionary  * dic =@{
                           @"client_id"    : model.app_key,
                           @"state"        : model.seed_secret,
                           @"access_token" : model.access_token,
                           @"action" : @"getSchedule",
                           @"match_id" : self.idTag
                           
                           };
    
    [RequestManager requestWithType:HttpRequestTypePost
                          urlString:model.source_url
                         parameters:dic
                       successBlock:^(id response){
                            [self.arr removeAllObjects];
                           if([[response objectForKey:@"errno"] isEqualToString:@"0"]){
                            [self.arr addObjectsFromArray:[response objectForKey:@"data"]];
                            [self setSubview ];
                                                         }
                           
                       }failureBlock:^(NSError *error) {
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
    
    
    
}

@end
