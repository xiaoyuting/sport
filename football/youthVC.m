//
//  youthVC.m
//  football
//
//  Created by 雨停 on 2017/6/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "youthVC.h"
#import "ABSSegmentCate.h"
#import "Header.h"
#import "youthCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "youthCollecCell.h"
#import "CollecCell.h"
#import "youthSelectVC.h"
#import "NavigationVC.h"
#import "youthSelectAdrVC.h"
#import "onlineVcModel.h"
#import "classDetaileVC.h"
#import "coursesModel.h"
#import "myMemberVC.h"
#import "matchVideoVC.h"
#import "NavigationVC.h"
@interface youthVC ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate>
@property  (weak, nonatomic) IBOutlet UIScrollView *contentSrcView;
@property  (nonatomic,strong)ABSSegmentCate * segmentedControl;
@property  (nonatomic,strong)UITableView    * leftTab;
@property  (nonatomic,strong)UICollectionView    * rightColl;
@property  (nonatomic ,strong)NSMutableArray     * leftArr;
@property  (nonatomic ,strong)NSMutableArray     * rightArr;
@property  (nonatomic,strong)NSMutableArray     * rightTitleArr;
@property  (nonatomic,assign) int          left ;
@property  (nonatomic,assign) int          right;
@property  (nonatomic,assign) NSInteger    posiTion;

@end

@implementation youthVC

- (void)viewDidLoad {
    self.rightTitleArr  = [NSMutableArray array];
    self.leftArr  =  [NSMutableArray array];
    self.rightArr =  [NSMutableArray array];
    [super viewDidLoad];
    [self setSegmentedControl];
    [self loadNewDataleft];
    [self loadNewDataRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)rightItemClick:(id)sender{
    
    if(self.posiTion==0){
    youthSelectVC * select = [[youthSelectVC alloc]init];
    //select.seledelegate=self;
    NavigationVC  * nav =[[NavigationVC alloc]initWithRootViewController:select];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        youthSelectAdrVC * select = [[youthSelectAdrVC alloc]init];
        //select.seledelegate=self;
        NavigationVC  * nav =[[NavigationVC alloc]initWithRootViewController:select];
        [self presentViewController:nav animated:YES completion:nil];
    }
}
-(void)setSegmentedControl{
    [self setLine];
    //[self setNavRightItemTitle:nil andImage:Img(@"select")];
    CGFloat const kSegmentedControlHeight = 44;
    
    NSArray *dataArray = @[@"青训课程", @"在线教案"];
   
    
    
    self.segmentedControl = [self setSegframe:CGRectMake(45, 0, KScreenWidth-90, kSegmentedControlHeight) titleArr:dataArray space:90];
    [self.view addSubview:_segmentedControl];;
    [self.view addSubview:_segmentedControl];
    
        CGFloat const kScrollViewHeight =KScreenHeight -44-50-64;
    
       self.contentSrcView.contentSize = CGSizeMake(KScreenWidth * dataArray.count, kScrollViewHeight);
       self.contentSrcView.delegate = self;
    
       self.contentSrcView.pagingEnabled = YES;

  
            CGFloat left =  KScreenWidth;
            UITableView * tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, kScrollViewHeight) style:UITableViewStylePlain];
            tab.separatorStyle = UITableViewCellSeparatorStyleNone;
            tab.delegate = self;
            tab.dataSource = self;
          [self.contentSrcView addSubview:tab];
        self.leftTab =tab;
    
        [tab  registerClass:[youthCell class] forCellReuseIdentifier:NSStringFromClass([youthCell class])];
    self.leftTab.mj_header =[MJRefreshNormalHeader   headerWithRefreshingBlock:^{
        [self loadNewDataleft];
    }];
    self.leftTab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreDataleft];
        
    }];
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    self.rightColl = [[UICollectionView  alloc]initWithFrame:CGRectMake(left, 0, left, kScrollViewHeight) collectionViewLayout:layout];
    self.rightColl.backgroundColor =KWhiteColor;
    [self.contentSrcView addSubview:self.rightColl];
    self.rightColl.delegate = self;
    self.rightColl.dataSource = self;
    //注册头视图
    [self.rightColl registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
   [self.rightColl  registerClass:[CollecCell class] forCellWithReuseIdentifier:@"cell"];
    self.rightColl.mj_header =[MJRefreshNormalHeader   headerWithRefreshingBlock:^{
        [self loadNewDataRight];
    }];
    self.rightColl.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreDataRight];
        
    }];
    
    [_segmentedControl segmentedControlSelectedWithBlock:^(ABSSegmentCate *segmentedControl, NSInteger selectedIndex) {
        NSLog(@"selectedIndex : %zd", selectedIndex);
        self.posiTion = selectedIndex;
         [self.contentSrcView setContentOffset:CGPointMake(selectedIndex * KScreenWidth, 0) animated:YES];
    }];
}


#pragma mark - scrollView protocol methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if([scrollView isEqual:self.contentSrcView]){
    NSInteger const kPageIndex = scrollView.contentOffset.x / KScreenWidth;
     [self.segmentedControl segmentedControlSetSelectedIndexWithSelectedBlock:kPageIndex];
        self.posiTion = kPageIndex;
        [self.segmentedControl segmentedControlSetSelectedIndex:kPageIndex];}
}

-(void)loadNewDataleft{
    self.left  =1;
    [self sendRequestLeft];
    [self.leftTab.mj_header  endRefreshing];
}
-(void)loadMoreDataleft{
    
    [self sendRequestLeft];
    [self.leftTab.mj_footer  endRefreshing];

}
-(void)sendRequestLeft{
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{@"action"       : @"getRecommendCourses",
                        @"page"         : [NSString stringWithFormat:@"%d",self.left]} successBlock:^(BaseModel *response) {
                            if([response.errorno isEqualToString:@"0"]){
                                if(self.left==1){
                                    [self.leftArr removeAllObjects];
                                }
                                [self.leftArr addObjectsFromArray:response.data.courses];
                                [self.leftTab reloadData];
                                self.left ++;
                            }
                        } failureBlock:^(NSError *error) {
                            
                        }];
}

-(void)loadNewDataRight{
    //self.right  =1;
    [self sendRequestRight];
    [self.rightColl.mj_header  endRefreshing];
}
-(void)loadMoreDataRight{
    
    [self sendRequestRight];
    [self.rightColl.mj_footer  endRefreshing];
    
}
-(void)sendRequestRight{
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{@"action" : @"getOnlineCourses"
                      }
         successBlock:^(BaseModel *response) {
             if([response.errorno isEqualToString:@"0"]){
            // if(self.right==1){
             [self. rightArr removeAllObjects];
            // }
             [self.rightArr addObjectsFromArray:response.data.info];
            
             [self.rightColl reloadData];
            //    self.right++;
             }
         } failureBlock:^(NSError *error) {
             
         }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    classDetaileVC * Detaile = [[classDetaileVC alloc]init];
    coursesModel  * model  =self.leftArr[indexPath.row];
    Detaile.infoID = model.id;
    [self absPushViewController:Detaile animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
 
        Class currentClass = [youthCell class];
        youthCell * cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.leftArr[indexPath.row];
       //[cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        return cell;
        
    }
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    //    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    int index = indexPath.row % 5;
//    NSString *str = _textArray[index];
    
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
        return [tableView cellHeightForIndexPath:indexPath model:self.leftArr[indexPath.row] keyPath:@"model" cellClass:[youthCell class] contentViewWidth:[self cellContentViewWith]];
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

//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                withReuseIdentifier:@"UICollectionViewHeader"
                                                                                       forIndexPath:indexPath];
        for(UIView * view in headView.subviews){
            [view removeFromSuperview];
        }
        
        UILabel  * lab = [XYUIKit labelWithTextColor:KBlackColor numberOfLines:0 text:nil fontSize:12];
        //lab.backgroundColor = KWhiteColor;
        lab.frame =CGRectMake(20, 0, 0.4*KScreenWidth, 32);
        
        NSArray * arr = self.rightArr[indexPath.section];
        onlineVcModel * model = [onlineVcModel yy_modelWithDictionary:arr[0]] ;
        lab.text =model.cate;
        [headView addSubview:lab];
        
        
        return headView;
        
    } else if (kind == UICollectionElementKindSectionFooter) {
             }
    return nil;
    
            }


//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    
    return self.rightArr.count;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray * arr = self.rightArr[section];
    return arr.count;
}

//设置元素内容
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =@"cell";
    CollecCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.model = nil;
    NSArray * arr = self.rightArr[indexPath.section];
    onlineVcModel * model = [onlineVcModel yy_modelWithDictionary:arr[indexPath.row]] ;
    cell.model =model;
    return cell;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{  //top, left, bottom, right;
    UIEdgeInsets top = {0,16,0,16};
    return top;
}
/** 头部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    
   return CGSizeMake(KScreenWidth,32);
}

/** 顶部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    
    return CGSizeMake(0, 0);
}

//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"%f",(kDeviceHeight-88-49)/4.0);
    return CGSizeMake((KScreenWidth-46)/2.0,(KScreenWidth-46)/2.0+62);
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    
    if(![ball getStringById:@"member" fromTable:@"person"]){
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"会员权限"
                                                             message:@"观看在线教案需要成为会员"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                                   otherButtonTitles:@"开启会员", nil];
        [alert show];
        return ;
    }
    matchVideoVC  * vc = [[matchVideoVC alloc]init];
    NavigationVC  * niv = [[NavigationVC alloc]initWithRootViewController:vc];
    [self presentViewController:niv animated:YES completion:nil];
   

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        myMemberVC * memberVC = [[myMemberVC alloc]init];
        NavigationVC * nav = [[NavigationVC alloc]initWithRootViewController:memberVC];
        
        [self presentViewController:nav animated:NO completion:nil];
    }
}
@end
