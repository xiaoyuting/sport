//
//  starVC.m
//  football
//
//  Created by 雨停 on 2017/6/30.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "starVC.h"
#import "Header.h"
#import "leftCollecStarCell.h"
#import "starDetaileVC.h"
#import "playersModel.h"
@interface starVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property  (nonatomic, strong)UICollectionView    * collecView;
@property  (nonatomic, strong)UICollectionViewFlowLayout *flowLayout;
@property  (nonatomic, strong)NSMutableArray       * arr;
@property  (nonatomic,assign)   int   page;
@end

@implementation starVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
    self.view.backgroundColor =[UIColor colorWithHexString:@"F9F9F9"];
    [self loadNewDataRight];
}
-(void)setSubView{
    self.arr = [NSMutableArray array];
    self.title = @"全部球星";
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collecView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:self.flowLayout];
    self.collecView.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
    self.collecView.delegate = self;
    self.collecView.dataSource = self;
   
    [self.collecView registerClass:[leftCollecStarCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collecView];
    self.collecView.mj_header =[MJRefreshNormalHeader   headerWithRefreshingBlock:^{
        [self loadNewDataRight];
    }];
    self.collecView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreDataRight];
        
    }];

    
}
-(void)loadNewDataRight{
    self.page =1;
    [self sendRequest];
    [self.collecView.mj_header endRefreshing];
}
-(void)loadMoreDataRight{
    [self sendRequest];
    [self.collecView.mj_footer endRefreshing];

}
-(void)leftItemClick:(id)sender{
    [self absPopNav];
}
//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr.count;
}

//设置元素内容
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  * identify =@"cell";
   leftCollecStarCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.model =self.arr[indexPath.row];
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
    return 0;
}
//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{  //top, left, bottom, right;
    UIEdgeInsets top = {10,20,10,20};
    return top;
}
/** 头部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    
    return CGSizeMake(0, 0);
}

/** 顶部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    
    return CGSizeMake(0, 0);
}

//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"%f",(kDeviceHeight-88-49)/4.0);
    return CGSizeMake(KScreenWidth-40,(KScreenWidth-40)*267.85/335.0);
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    starDetaileVC * starDetaile = [[starDetaileVC alloc]init];
    playersModel  * model  =self.arr[indexPath.row];
    starDetaile.playerID = model.id;
    [self absPushViewController:starDetaile animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sendRequest{
    [self requestType:HttpRequestTypePost url:nil
           parameters:@{@"action" : @"getRecommendPlayers",
                        @"page"   :  [NSString stringWithFormat:@"%d",self.page]    //选填（页数）
                        }
         successBlock:^(BaseModel *response) {
             if([response.errorno  isEqualToString:@"0"]){
                 if(self.page== 1){
                     [self.arr removeAllObjects];
                 }
                 
                 [self.arr addObjectsFromArray:response.data.players];
                 [self.collecView reloadData];
                 self.page ++;
              }
             } failureBlock:^(NSError *error) {
               
           }];
    
}

@end
