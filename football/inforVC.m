//
//  inforVC.m
//  football
//
//  Created by 雨停 on 2017/6/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "inforVC.h"
#import "SDCycleScrollView.h"
#import "ABSSegmentCate.h"
#import "NavigationVC.h"
#import "leftCollecCell.h"
#import "leftYouthCell.h"
#import "SDAutoLayout.h"
#import "leftCoachCell.h"
#import "leftStarCell.h"
#import "subjectVC.h"
#import "coachVC.h"
#import "starVC.h"
#import "ViewController.h"
#import "starDetaileVC.h"
#import "coachDetaileVC.h"
#import "inforDetaileVC.h"
#import "classDetaileVC.h"
#import "newsModel.h"
#import "carouselModel.h"
#import "coachesModel.h"
#import "playersModel.h"
#import "newsModel.h"
#import "coursesModel.h"
@interface inforVC () <SDCycleScrollViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *contentSrcView;
@property (nonatomic,strong)ABSSegmentCate * segmentedControl;
@property (nonatomic,strong)UITableView    * leftTab;
@property (nonatomic,strong)UITableView    * centerTab;
@property (nonatomic,strong)UITableView    * rightTab;
@property (nonatomic,assign) int         left;
@property (nonatomic,assign) int         center;
@property (nonatomic,assign) int         right;
@property (nonatomic,strong) NSMutableArray  * leftArr;
@property (nonatomic,strong) NSMutableArray  * centerArr;
@property (nonatomic,strong) NSMutableArray  * rightArr;
@property (nonatomic,strong) SDCycleScrollView * leftPic;
@property (nonatomic,strong) SDCycleScrollView * centerPic;
@property (nonatomic,strong) SDCycleScrollView * rightPic;
@property (nonatomic,strong) NSMutableArray  * lnewsArr;
@property (nonatomic,strong) NSMutableArray  * lcoursesArr;
@property (nonatomic,strong) NSMutableArray  * lhotArr;
@property (nonatomic,strong) NSMutableArray  * lplayersArr;
@property (nonatomic,strong) NSMutableArray  * lcoachArr;
@end

@implementation inforVC
-(void)playBtnClick{
    [self loadcenterNewdata];
    [self loadrightNewdata];
}
- (void)viewDidLoad {
    
    self. leftArr   = [ NSMutableArray array];
    self. centerArr = [ NSMutableArray array];
    self. rightArr  = [ NSMutableArray array];
    self. lnewsArr  = [ NSMutableArray array];
    self. lcoursesArr = [NSMutableArray array];
    self. lhotArr   = [ NSMutableArray array];
    self. lplayersArr = [NSMutableArray array];
    self. lcoachArr   = [NSMutableArray array];
    
    [super viewDidLoad];
    [self setSegmentedControl];
    [self loadcenterNewdata];
    [self loadrightNewdata];
    [self loadleftNewdata];
   
}
 


-(void)location:(id)sender{
    ViewController *vc=[[ViewController alloc]init];
    NavigationVC * nav = [[NavigationVC alloc]initWithRootViewController:vc];
    [vc returnText:^(NSString *cityname) {
        
        NSLog(@"%@",cityname);
       
        
        [self setNavLeftItemTitle:cityname andImage:Img(@"zhankai") ];
        //self.citylable.text=cityname;
    }];
    
    [self presentViewController:nav animated:YES completion:nil];

}

-(void)setSegmentedControl{
    [self setLine];
    [self setNavLeftItemTitle:@"上海市" andImage:Img(@"zhankai") ];
    CGFloat const kSegmentedControlHeight = 44;
    
   NSArray *dataArray = @[@"青训资讯", @"活动资讯", @"赛事新闻"];
    self.segmentedControl = [self setSegframe:CGRectMake(45, 0, KScreenWidth   -90, kSegmentedControlHeight) titleArr:dataArray  space:90];
    [self.view addSubview:_segmentedControl];
    
    CGFloat const kScrollViewHeight =KScreenHeight-50-44-64;
    
    self.contentSrcView.contentSize = CGSizeMake(KScreenWidth * 3, kScrollViewHeight);
    self.contentSrcView.delegate = self;

    // scrollView.backgroundColor = [UIColor whiteColor];
     self.contentSrcView.pagingEnabled = YES;
   
    for (int i = 0; i < 3; i ++) {
        
        CGFloat left = i * KScreenWidth ;
        UITableView * tab = [[UITableView alloc]initWithFrame:CGRectMake(left, 0, KScreenWidth, kScrollViewHeight) style:UITableViewStyleGrouped];
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        tab.delegate = self;
        tab.dataSource = self;
        [self.contentSrcView addSubview:tab];
        if(i==0){
           
            [tab registerClass:[leftCollecCell class] forCellReuseIdentifier:NSStringFromClass( [leftCollecCell class])];
            [tab registerClass:[leftYouthCell class] forCellReuseIdentifier:NSStringFromClass([leftYouthCell class])];
            [tab registerClass:[leftCoachCell class] forCellReuseIdentifier:NSStringFromClass([leftCoachCell class])];
            [tab registerClass:[leftStarCell class] forCellReuseIdentifier:NSStringFromClass([leftStarCell class])];
            self.leftTab = tab;
            self.leftPic =[self setScrollerPhoto];

            tab.tableHeaderView =self.leftPic;
        }else if(i==1){
             [tab registerClass:[leftYouthCell class] forCellReuseIdentifier:NSStringFromClass([leftYouthCell class])];
            
            self.centerTab = tab;
            self.centerPic =[self setScrollerPhoto];
            tab.tableHeaderView =self.centerPic;
        }else{
            [tab registerClass:[leftYouthCell class] forCellReuseIdentifier:NSStringFromClass([leftYouthCell class])];
            self.rightTab = tab;
            self.rightPic =[self setScrollerPhoto];
            
            tab.tableHeaderView =self.rightPic;
            
        }
    }
    self.leftTab.mj_header =[MJRefreshNormalHeader   headerWithRefreshingBlock:^{
        [self loadleftNewdata];
    }];
//    self.leftTab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [self loadleftMoredata];
//        
//    }];
//    
    self.centerTab.mj_header =[MJRefreshNormalHeader   headerWithRefreshingBlock:^{
        [self loadcenterNewdata];
    }];
    self.centerTab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadcenterMoredata];

    }];
    self.rightTab.mj_header =[MJRefreshNormalHeader   headerWithRefreshingBlock:^{
        [self loadrightNewdata];
    }];
    self.rightTab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadrightMoredata];
        
    }];
   
    [_segmentedControl segmentedControlSelectedWithBlock:^(ABSSegmentCate *segmentedControl, NSInteger selectedIndex) {
        NSLog(@"selectedIndex : %zd", selectedIndex);
        [ self.contentSrcView setContentOffset:CGPointMake(selectedIndex * KScreenWidth, 0) animated:YES];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView==self.leftTab){
    return self.leftArr.count;
    }
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        if([tableView isEqual:self.leftTab]){
            
            if(section ==3){
                NSArray * arr = self.leftArr[section];
                return  arr.count;

            }
            else if(section==1){
                NSArray * arr = self.leftArr[section];
                return  arr.count;
            }
            return 1;
        }else if([tableView isEqual:self.centerTab]){
           return  self.centerArr.count;
        }else  if([tableView isEqual:self.rightTab]) {
            return self.rightArr.count;
        }
        return 0;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if([tableView isEqual:self.leftTab]){
        
            
            if(section==1){
                UIView *view = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
                view.backgroundColor =KWhiteColor ;
                UILabel * lab = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KBlackColor textAlignment:NSTextAlignmentLeft numberOfLines:0 text:nil fontSize:21];
                lab.font = FontBold(21);
                [view addSubview:lab];
                lab.frame = CGRectMake(20, 8, 200, 32);
                lab.text =@"青训咨询";
                return view;
     }
    }else if([tableView isEqual:self.centerTab]){
        if (section ==0){
           
                UIView *view = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
                view.backgroundColor =KWhiteColor ;
                UILabel * lab = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KBlackColor textAlignment:NSTextAlignmentLeft numberOfLines:0 text:nil fontSize:21];
                lab.font = FontBold(21);
                [view addSubview:lab];
                lab.frame = CGRectMake(20, 8, 200, 32);
                
                
                lab.text =@"活动咨询";
                return view;
            }
            
            

        
    }else  if([tableView isEqual:self.rightTab]) {
        if (section ==0){
            
            UIView *view = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
            view.backgroundColor =KWhiteColor ;
            UILabel * lab = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KBlackColor textAlignment:NSTextAlignmentLeft numberOfLines:0 text:nil fontSize:21];
            lab.font = FontBold(21);
            [view addSubview:lab];
            lab.frame = CGRectMake(20, 8, 200, 32);
            
            
            lab.text =@"赛事新闻";
            return view;
        }
        

    }


           return nil;
    
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if([tableView isEqual:self.leftTab]){
        
        
        if(section==1){
            
            return 40;
        }
    }else if([tableView isEqual:self.centerTab]){
        if (section ==0){
            return 40;
        }
    }else  if([tableView isEqual:self.rightTab]) {
        if (section ==0){
            return 40;
        }
    }
    return 0.00001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     __block inforVC * weakSelf  = self;
    if([tableView isEqual:self.leftTab]){
        if(indexPath.section ==0){
            Class currentClass = [leftCollecCell class];
            leftCollecCell * cell = nil;
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
            //cell = [tableView dequeueReusableCellWithIdentifier:@"left"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.blockBtn = ^{
                [weakSelf  jumpClassVC];
            };
          cell.blockCell = ^(NSIndexPath *index) {
              classDetaileVC * Detaile = [[classDetaileVC alloc]init];
              coursesModel  * model  =weakSelf.lplayersArr[index.row];
              Detaile.infoID = model.id;
              [self absPushViewController:Detaile animated:YES];
          };
            [cell setinfoArr:self.lcoursesArr];
            return cell;
        }else if(indexPath.section ==1){
            Class currentClass = [leftYouthCell class];
            leftYouthCell * cell = nil;
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.modelcenter = self.lnewsArr[indexPath.row];
            
            return cell;
        }else if(indexPath.section==2){
            Class currentClass = [leftCoachCell class];
            leftCoachCell * cell = nil;
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setInfoArr:self.lcoachArr];
            cell.coachBlock = ^{
                [weakSelf jumpCoachVC];
            };
                cell.coachDetaile = ^(NSIndexPath *indexPath) {
                coachDetaileVC * coachDetaile = [[coachDetaileVC alloc]init];
                coachesModel* model = weakSelf.lcoachArr[indexPath.row];
                coachDetaile.coachID =model.id;
                [self absPushViewController:coachDetaile animated:YES];

            };
            return cell;
        }
        else if(indexPath.section ==3){
            Class currentClass = [leftYouthCell class];
            leftYouthCell * cell = nil;
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.modelcenter =self.lhotArr[indexPath.row];
            
            return cell;
        }
        else{
            Class currentClass = [leftStarCell class];
            leftStarCell * cell = nil;
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.block = ^{
          
                [weakSelf jumpStarVC];
            };
            cell.starDetaile = ^(NSIndexPath *indexPath) {
                starDetaileVC * starDetaile = [[starDetaileVC alloc]init];
                playersModel  * model  =weakSelf.lplayersArr[indexPath.row];
                starDetaile.playerID = model.id;
                [self absPushViewController:starDetaile animated:YES];
            };
            [cell  setInfoArr:self.lplayersArr];
            return cell;
        }
       

    }else if([tableView isEqual:self.centerTab]){
        Class currentClass = [leftYouthCell class];
        leftYouthCell * cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.modelcenter    =  self.centerArr[indexPath.row] ;
        
        return cell;
    }else{
        Class currentClass = [leftYouthCell class];
         leftYouthCell * cell = nil;
         cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
       // cell = [tableView dequeueReusableCellWithIdentifier:@"right"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.modelcenter = self.rightArr[indexPath.row];
        
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if([tableView isEqual:self.leftTab]){
        if(indexPath.section ==0){
            
            return   (KScreenWidth-50)/2.0+62+25+48;
            
        }else if(indexPath.section==1){
            return [tableView cellHeightForIndexPath:indexPath model:self.lnewsArr keyPath:@"model" cellClass:[leftYouthCell class] contentViewWidth:[self cellContentViewWith]];
        }else if(indexPath.section  ==2){
            return (KScreenWidth-50)/2.0+8.5+52+57.5;
        }else if(indexPath.section==3){
            return [tableView cellHeightForIndexPath:indexPath model:self.lhotArr keyPath:@"model" cellClass:[leftYouthCell class] contentViewWidth:[self cellContentViewWith]];
        }
        
        else{
            return (KScreenWidth-40)*267.85/335.0+45.5;
        }
     }else if([tableView isEqual:self.centerTab]){
        return [tableView cellHeightForIndexPath:indexPath model:self.centerArr[indexPath.row] keyPath:@"modelcenter" cellClass:[leftYouthCell class] contentViewWidth:[self cellContentViewWith]];
    }else{
       return [tableView cellHeightForIndexPath:indexPath model:self.rightArr[indexPath.row] keyPath:@"modelright" cellClass:[leftYouthCell class] contentViewWidth:[self cellContentViewWith]];
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView isEqual:self.leftTab]){
        if(indexPath.section ==0){
            
            
            
        }else if(indexPath.section==1){
            inforDetaileVC * infoVC = [[inforDetaileVC alloc]init];
            newsModel * model = self.lnewsArr[indexPath.row];
            infoVC.infoID = model.id;
            [self absPushViewController:infoVC animated:YES];
           
        }else if(indexPath.section==3){
            
            inforDetaileVC * infoVC = [[inforDetaileVC alloc]init];
            newsModel * model = self.lhotArr[indexPath.row];
            infoVC.infoID = model.id;
            [self absPushViewController:infoVC animated:YES];
           
        }else{
            
        }
    }else if([tableView isEqual:self.centerTab]){
        inforDetaileVC * infoVC = [[inforDetaileVC alloc]init];
        newsModel * model = self.centerArr[indexPath.row];
        infoVC.infoID = model.id;
        [self absPushViewController:infoVC animated:YES];
    }else{
       
        inforDetaileVC * infoVC = [[inforDetaileVC alloc]init];
        newsModel * model = self.rightArr[indexPath.row];
        infoVC.infoID = model.id;
        [self absPushViewController:infoVC animated:YES];
    }

    
}
 
#pragma mark -
#pragma mark - scrollView protocol methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if([scrollView isEqual:self.contentSrcView]){
    NSInteger const kPageIndex = scrollView.contentOffset.x / KScreenWidth;
     [self.segmentedControl segmentedControlSetSelectedIndexWithSelectedBlock:kPageIndex];
    // 重设选中位置
        [self.segmentedControl segmentedControlSetSelectedIndex:kPageIndex];}
}

-(SDCycleScrollView  *)setScrollerPhoto
{
    UIView *view   =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 155)];
  
    // 网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 155) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView2.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    //cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [view addSubview:cycleScrollView2];
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
    
    /*
     block监听点击方式
     
     cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
     NSLog(@">>>>>  %ld", (long)index);
     };
     
     */

    return cycleScrollView2;
     }
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if(self.leftPic ==cycleScrollView){
        NSLog(@"---点击了第%ld张图片", (long)index);
    }
    else if(self.centerPic==cycleScrollView){
        NSLog(@"---点击了第%ld张图片", (long)index);
    }else if(self.rightPic==cycleScrollView){
        NSLog(@"---点击了第%ld张图片", (long)index);
    }
    
}

 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)jumpClassVC{
    subjectVC    * subVc=  [[subjectVC alloc]init];
    [self absPushViewController:subVc  animated:YES];
}
-(void)jumpCoachVC{
    coachVC    * subVc=  [[coachVC alloc]init];
    [self absPushViewController:subVc  animated:YES];
}
-(void)jumpStarVC{
    starVC    * subVc=  [[starVC alloc]init];
    [self absPushViewController:subVc  animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    if(![ball getStringById:@"city" fromTable:@"person"]){
        ViewController *vc=[[ViewController alloc]init];
        NavigationVC * nav = [[NavigationVC alloc]initWithRootViewController:vc];
        [vc returnText:^(NSString *cityname) {
            [ball putString:cityname withId:@"city" intoTable:@"person"];
            NSLog(@"%@",cityname);
            [self setNavLeftItemTitle:cityname andImage:Img(@"zhankai") ];
            //self.citylable.text=cityname;
        }];
        
        [self presentViewController:nav animated:NO completion:nil];
    }
    
}

-(void)loadcenterNewdata{
    self.left =1;
    [self centerRequest];
    [self.centerTab.mj_header endRefreshing ];
}
-(void)loadcenterMoredata{
    [self centerRequest];
    [self.centerTab.mj_footer endRefreshing ];
}
-(void)centerRequest{
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{@"action":@"getNews",
                        @"type"  :@"2",
                        @"page"  :[NSString stringWithFormat:@"%d",self.left] }
         successBlock:^(BaseModel *response) {
             if([response.errorno isEqualToString:@"0"]){
                 if(self.left==1){
                     [self.centerArr removeAllObjects];
                 }
                 NSArray * pic  = response.data.carousel  ;
                 NSMutableArray * arrPic = [NSMutableArray array];
                 for(carouselModel  * model in pic){
                     [arrPic addObject:model.imgurl];
                 }
                 self.centerPic.imageURLStringsGroup =arrPic;
                 [self.centerArr addObjectsFromArray: response.data.news];
                 
                 [self.centerTab reloadData];
                 self.left++;
             }
         } failureBlock:^(NSError *error) {
             
             
         }];
}
-(void)loadrightNewdata{
    self.right =1;
    [self rightRequest];
    [self.rightTab.mj_header endRefreshing ];
}
-(void)loadrightMoredata{
    [self rightRequest];
    [self.rightTab.mj_footer endRefreshing ];
}
-(void)rightRequest{
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{@"action":@"getNews",
                        @"type"  :@"3",
                        @"page"  :[NSString stringWithFormat:@"%d",self.right] }
         successBlock:^(BaseModel *response) {
             if([response.errorno isEqualToString:@"0"]){
                 if(self.right==1){
                     [self.rightArr removeAllObjects];
                 }
                 NSArray * pic  = response.data.carousel  ;
                 NSMutableArray * arrPic = [NSMutableArray array];
                 for(carouselModel  * model in pic){
                     [arrPic addObject:model.imgurl];
                 }
                 self.rightPic.imageURLStringsGroup =arrPic;
                 [self.rightArr addObjectsFromArray: response.data.news];
                 
                 [self.rightTab reloadData];
                 self.right++;
             }
             if(self.rightArr.count==0){
                 [self showPlaceholderViewWithImage:nil
                                            message:@"暂无新闻"
                                        buttonTitle:nil centerOffsetY:-100
                                        onSuperView:self.rightTab];
             }
         } failureBlock:^(NSError *error) {
             
         }];
}
-(void)loadleftNewdata{
    self.left =1;
    [self leftRequest];
    [self.leftTab.mj_header endRefreshing ];
}
-(void)loadleftMoredata{
    [self leftRequest];
    [self.leftTab.mj_footer endRefreshing ];
}
-(void)leftRequest{
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{
                        @"action" : @"getQxNews",

                         }
         successBlock:^(BaseModel *response) {
             if([response.errorno isEqualToString:@"0"]){
                 
                 [self.leftArr removeAllObjects];
                 [ self.lcoursesArr removeAllObjects];
                 [ self.lnewsArr removeAllObjects];
                 [ self.lcoachArr removeAllObjects];
                 [ self.lhotArr removeAllObjects];
                 [ self.lplayersArr removeAllObjects];

                 NSArray * pic  = response.data.carousel  ;
                 NSMutableArray * arrPic = [NSMutableArray array];
                 for(carouselModel  * model in pic){
                     [arrPic addObject:model.imgurl];
                 }
                 self.leftPic.imageURLStringsGroup =arrPic;
                 if(response.data.coaches){
                     [self.lcoachArr addObjectsFromArray:response.data.coaches];
                 }

                 if(response.data.news){
                     [self.lnewsArr addObjectsFromArray:response.data.news];
                 }
                 
                 if(response.data.players){
                     [self.lplayersArr addObjectsFromArray:response.data.players ];
                 }
                 if(response.data.courses){
                     [self.lcoursesArr addObjectsFromArray:response.data.courses ];
                 }
                 if(response.data.hot){
                     [self.lhotArr addObjectsFromArray:response.data.hot ];
                 }
                 [self.leftArr addObject:self.lcoursesArr];
                 [self.leftArr addObject:self.lnewsArr];
                 [self.leftArr addObject:self.lcoachArr];
                 [self.leftArr addObject:self.lhotArr];
                 [self.leftArr addObject:self.lplayersArr];

                 [self.leftTab reloadData];
             
             }
                      } failureBlock:^(NSError *error) {
             
         }];
}


@end
