//
//  matchVC.m
//  football
//
//  Created by 雨停 on 2017/6/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "matchVC.h"
#import "ABSSegmentCate.h"
#import "Header.h"
#import "XYUIKit.h"
#import "mathCell.h"
#import "VideoCell.h"
#import "SDAutoLayout.h"
#import "NavigationVC.h"
#import "matchDetailVC.h"
#import "matchSelectVC.h"
#import "zhiBoVC.h"
#import "LCActivityViewController+UI.h"
#import "rowsViewModel.h"
#import "VideoCell.h"
#import "ShareView.h"
#import "JSHAREService.h"

//#import "LCActivityViewController.h"

@interface matchVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,selectInfodelegate >
 @property(nonatomic,retain)VideoCell *currentCell;
@property(nonatomic,retain)NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrView;
@property  (nonatomic,strong)ABSSegmentCate  *segmentedControl;
@property (nonatomic,strong)UITableView    * leftTab;
@property (nonatomic,strong)UITableView    * rightTab;

@property (nonatomic,strong)NSMutableArray * leftArr;
@property (nonatomic,strong)NSMutableDictionary  * dic;
@property (nonatomic,assign) int  pageL;
@property (nonatomic,assign) int  pageR;
@property (nonatomic, strong) ShareView * shareView;
@property  (nonatomic,assign)int  shearSelect;
@end

@implementation matchVC
 
- (void)viewDidLoad {
    self.dataSource = [NSMutableArray array];
 
    self.dic =[NSMutableDictionary  dictionary];

    self.leftArr = [NSMutableArray array];
    [super viewDidLoad];
    
    [self setSegmentedControl];
    
    [self loadNewDataleft];
    [self loadNewDataright];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)rightItemClick:(id)sender{
    matchSelectVC * select = [[matchSelectVC alloc]init];
    select.seledelegate=self;
    NavigationVC  * nav =[[NavigationVC alloc]initWithRootViewController:select];
    [self presentViewController:nav animated:YES completion:nil];

}
-(void)setRequest:(NSMutableDictionary *)dic{
    NSLog(@"dic========%@",dic);
    [self.dic addEntriesFromDictionary:dic];
    NSLog(@"dic========%@",self.dic);
    [self loadNewDataleft];
   }
-(void)setSegmentedControl{
   
    [self setNavRightItemTitle:nil andImage:Img(@"select")];
    [self setLine];
    CGFloat const kSegmentedControlHeight = 44;
    NSArray *dataArray = @[@"比赛", @"直播"];
    self.segmentedControl = [self setSegframe:CGRectMake(45, 0, KScreenWidth-90, kSegmentedControlHeight) titleArr:dataArray space:90];
    [self.view addSubview:_segmentedControl];

    
    CGFloat const kScrollViewHeight =KScreenHeight -44-50-64;
        self.contentScrView.contentSize = CGSizeMake(KScreenWidth * dataArray.count, kScrollViewHeight);
        self.contentScrView.delegate = self;
        self.contentScrView.pagingEnabled = YES;
     for (int i = 0; i < dataArray.count; i ++) {
            CGFloat left = i * KScreenWidth;
       
         UITableView * tab = [[UITableView alloc]initWithFrame:CGRectMake(left, 0, KScreenWidth, kScrollViewHeight) style:UITableViewStylePlain];
         tab.separatorStyle = UITableViewCellSeparatorStyleNone;
         tab.delegate = self;
         tab.dataSource = self;

        [self.contentScrView addSubview:tab];
         if(i==0){
             [tab registerClass:[mathCell class ] forCellReuseIdentifier:NSStringFromClass([mathCell  class])];
             self.leftTab = tab;
         }else{
            [tab registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];
         
             self.rightTab = tab;
                      }
        }
    self.leftTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewDataleft];
    }];
    self.leftTab.mj_footer   = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreDataleft];
    }];
    self.rightTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewDataright];
    }];
    self.rightTab.mj_footer   = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreDataright];
    }];

    
    [_segmentedControl segmentedControlSelectedWithBlock:^(ABSSegmentCate *segmentedControl, NSInteger selectedIndex) {
        NSLog(@"selectedIndex : %zd", selectedIndex);
        if(selectedIndex ==0){
             [self setNavRightItemTitle:nil andImage:Img(@"select")];
        }else{
             [self setNavRightItemTitle:nil andImage:nil];
        }
        [self.contentScrView setContentOffset:CGPointMake(selectedIndex * KScreenWidth, 0) animated:YES];
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView==self.leftTab){
    matchDetailVC * detaile = [[matchDetailVC alloc]init];
    NSDictionary * dic = self.leftArr[indexPath.row];
    detaile.idTag =[dic objectForKey:@"id"];
    NavigationVC  * nav =[[NavigationVC alloc]initWithRootViewController:detaile];
    [self presentViewController:nav animated:YES completion:nil];
    
    }else{
        if(![ball getStringById:@"load" fromTable:@"person"]){
            [SVProgressHUD showErrorWithStatus:@"需先登录"];
            [SVProgressHUD dismissWithDelay:1.0f];
            LoginVC *loginVC = [[LoginVC alloc]init];
            NavigationVC * navVC = [[NavigationVC alloc]initWithRootViewController:loginVC];
            [self presentViewController:navVC animated:YES completion:nil];
            return;
        }else{
            LCActivityViewController_UI * viewController = [[LCActivityViewController_UI alloc] initWithNibName:@"LCActivityViewController+UI" bundle:nil];
            rowsViewModel * model =   [self.dataSource objectAtIndex:indexPath.row];
            viewController.activityId = model.activityId;
            // [self.navigationController pushViewController:viewController animated:YES];
            NavigationVC * nav  = [[NavigationVC alloc]initWithRootViewController:viewController] ;
            [self presentViewController:nav animated:YES completion:^{
                
            }];

        }

         }
}
#pragma mark -
#pragma mark - scrollView protocol methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if([scrollView isEqual:self.contentScrView]){
    NSInteger const kPageIndex = scrollView.contentOffset.x / KScreenWidth;
    // [self.segmentedControl segmentedControlSetSelectedIndexWithSelectedBlock:kPageIndex];
        if(kPageIndex == 0){
            [self setNavRightItemTitle:nil andImage:Img(@"select")];
        }else{
            [self setNavRightItemTitle:nil andImage:nil];
        }
    // 重设选中位置
    [self.segmentedControl segmentedControlSetSelectedIndex:kPageIndex];
    }
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([tableView isEqual:self.leftTab]){
        return self.leftArr.count;
    }else{
        return self.dataSource.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if([tableView isEqual:self.leftTab]){
        Class currentClass = [mathCell class];
        mathCell * cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dic = self.leftArr[indexPath.row];
        
      // WeakSelf(self);
   /* cell.cheak = ^{
          //跳转下单
        matchDetailVC * detaile = [[matchDetailVC alloc]init];
        NSDictionary * dic = self.leftArr[indexPath.row];
        detaile.idTag =[dic objectForKey:@"id"];
        
        NavigationVC  * nav =[[NavigationVC alloc]initWithRootViewController:detaile];
        [weakself presentViewController:nav animated:YES completion:nil];
        };*/
        return cell;
        
    }else {

        static NSString *identifier = @"VideoCell";
        VideoCell *cell = (VideoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        cell.model = [self.dataSource objectAtIndex:indexPath.row];
        WeakSelf(self);
        cell.shearBlock = ^{
            
            if(![ball getStringById:@"load" fromTable:@"person"]){
                [SVProgressHUD showErrorWithStatus:@"需先登录"];
                [SVProgressHUD dismissWithDelay:1.0f];
                LoginVC *loginVC = [[LoginVC alloc]init];
                NavigationVC * navVC = [[NavigationVC alloc]initWithRootViewController:loginVC];
                [weakself presentViewController:navVC animated:YES completion:nil];
                return;
            }else{
                [weakself.shareView showWithContentType:JSHARELink];
                 weakself .shearSelect = (int)indexPath.row;
            }

           
           
        };
        
        
        
        return cell;

    }
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    //    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    
}
//常用
- (void)shareLinkWithPlatform:(JSHAREPlatform)platform {
    
    JSHAREMessage *message = [JSHAREMessage message];
    rowsViewModel* model = [self.dataSource objectAtIndex:self.shearSelect];
    NSString *imageURL = model.coverImgUrl ;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
    message.mediaType = JSHAREImage;
    message.platform = platform;
    message.image = imageData;
    
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        
    }];

//    JSHAREMessage *message = [JSHAREMessage message];
//     rowsViewModel* model = [self.dataSource objectAtIndex:self.shearSelect];
//    message.mediaType = JSHARELink;
//    message.url = @"";
//    message.text = model.descrip    ;
//    message.title = model.activityName;
//    message.platform = platform;
//    NSString *imageURL = model.coverImgUrl ;
//    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
//    
//    message.image = imageData;
//    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
//        
//        NSLog(@"分享回调");
//        
//        
//    }];
}
- (ShareView *)shareView {
    if (!_shareView) {
        _shareView = [ShareView getFactoryShareViewWithCallBack:^(JSHAREPlatform platform, JSHAREMediaType type) {
            //常用
            [self shareLinkWithPlatform:platform];
            
            
        }];
        [self.view addSubview:self.shareView];
    }
    return _shareView;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([tableView isEqual:self.leftTab]){
        //    int index = indexPath.row % 5;
        //    NSString *str = _textArray[index];
        
        // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
        /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
        return [tableView cellHeightForIndexPath:indexPath model:self.leftArr[indexPath.row] keyPath:@"model" cellClass:[mathCell class] contentViewWidth:[self cellContentViewWith]];
    }else{
        return 296;
    }
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    
    
}
-(void)loadNewDataleft{
    self.pageL=1;
    [self sendRequestLeft];
    [self.leftTab.mj_header endRefreshing];
}
-(void)loadMoreDataleft{
   
    [self sendRequestLeft];
    [self.leftTab.mj_footer endRefreshing];
}
-(void)sendRequestLeft{
    [self updatePlaceholderView];
    appInfoModel * model = [appInfoModel yy_modelWithDictionary:[ball getObjectById:@"urlInfo" fromTable:@"person"]];
    NSMutableDictionary  * dic =[NSMutableDictionary  dictionary];
    
    if(self.dic.count!=0){
        NSLog(@"%@",self.dic);
        [dic addEntriesFromDictionary:self.dic];
        
    }
    
    [ dic addEntriesFromDictionary:@{
                                     @"client_id" : model.app_key,
                                     @"state" : model.seed_secret,
                                     @"access_token" :model.access_token,
                                     @"action"       : @"getMatchList",
                                     @"page"         : [NSString stringWithFormat:@"%d",self.pageL]
                                     }];
    
 
    [RequestManager requestWithType:HttpRequestTypePost
                          urlString:model.source_url
                         parameters:dic
                       successBlock:^(id response){
                           NSLog(@"response==%@",response);
                           if([[response objectForKey:@"errno"] isEqualToString:@"0"]){
                           if(self.pageL==1){
                           [self.leftArr removeAllObjects];
                           }
                           [self.leftArr addObjectsFromArray:[response objectForKey:@"data"]];
                               [self.leftTab reloadData];
                               self.pageL++;
                           }
                           if(self.leftArr.count==0){
                               [self showPlaceholderViewWithImage:Img(@"match")
                                                          message:@"当前筛选没有数据"buttonTitle:@"返回" centerOffsetY:0 onSuperView:self.leftTab];
                           }
                       }failureBlock:^(NSError *error) {
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
}
-(void)playBtnClick{
    [self updatePlaceholderView];
    
    [self.dic removeAllObjects];
    [self loadNewDataleft];
}
-(void)loadNewDataright{
    self.pageR=0;
    [self sendRequestright];
    [self.rightTab.mj_header endRefreshing];
}
-(void)loadMoreDataright{
    
    [self sendRequestright];
    [self.rightTab.mj_footer endRefreshing];
}
-(void)sendRequestright{
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{
                        @"action" : @"getLetvLiveList",
                        
                        // @"activity_id" : @"",     //直播活动ID（选填）
                        //@"activity_name" : @"value",   //直播活动名称（选填）
                        // @"activity_status" : @"",   //直播活动状态（选填）0:未开始1:已开始 3:已结束
                        @"offset" : [NSString stringWithFormat:@"%d",self.pageR],   //从第几条数据开始查询，默认0（选填）
                        @"fetch_size" : @"10"
                        }
         successBlock:^(BaseModel *response) {
             NSLog(@"%@",response);
             if([response.errorno    isEqualToString:@"0"]){
                 if(self.pageR==0){
                     [self.dataSource removeAllObjects];
                 }
                 
                 [self.dataSource addObjectsFromArray:response.data.rows];
                 [self.rightTab reloadData];
                 self.pageR++;
             }
         } failureBlock:^(NSError *error) {
             
         }];

   
}


@end
