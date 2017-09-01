//
//  youthSelectVC.m
//  football
//
//  Created by 雨停 on 2017/8/8.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "youthSelectVC.h"
#import "ItemViewCell.h"
@interface youthSelectVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView    * rightColl;
@property (nonatomic ,assign)NSIndexPath *firstindex;
@property (nonatomic ,assign)NSIndexPath *secondindex;
@property (nonatomic ,assign)NSIndexPath *thirdindex;
@property (nonatomic,strong) NSMutableArray    * arr;
@end

@implementation youthSelectVC

- (void)viewDidLoad {
    self.arr = [NSMutableArray array];
    self.firstindex  =[NSIndexPath indexPathForRow:0 inSection:0];
    self.secondindex  =[NSIndexPath indexPathForRow:0 inSection:1];
    self.thirdindex   = [NSIndexPath indexPathForRow:0 inSection:2];
    [super viewDidLoad];
    self.title = @"筛选";
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    [self setSubview];
    // Do any additional setup after loading the view.
}
-(void)setSubview{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    self.rightColl = [[UICollectionView  alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-48) collectionViewLayout:layout];
    self.rightColl.backgroundColor =KWhiteColor;
    [self.view addSubview:self.rightColl];
    self.rightColl.delegate = self;
    self.rightColl.dataSource = self;
    //注册头视图
    [self.rightColl registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
    UINib *cellNib=[UINib nibWithNibName:@"ItemViewCell" bundle:nil];
    
    [  self.rightColl registerNib:cellNib forCellWithReuseIdentifier:@"ItemCell"];

    UIButton * btnL = [XYUIKit buttonWithBackgroundColor:KWhiteColor titleColor:KGrayColor title:@"重置" fontSize:17];
    btnL.frame = CGRectMake(0, KScreenHeight-48, 0.5*KScreenWidth, 48);
    UIButton * btnR = [XYUIKit buttonWithBackgroundColor:mainColor titleColor:KWhiteColor title:@"确定" fontSize:17];
    btnR.frame = CGRectMake(0.5*KScreenWidth, KScreenHeight-48, 0.5*KScreenWidth, 48);
    btnR.tag =0;
    btnL.tag =1;
    [self.view addSubview:btnL];
    [self.view addSubview:btnR];
    [btnR addTarget:self action:@selector(choseInfo:) forControlEvents:UIControlEventTouchUpInside];
    [btnL addTarget:self action:@selector(choseInfo:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)choseInfo:(UIButton *)sender{
    if(sender.tag==0){
        // [self.seledelegate   setRequest:self.dic];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if(sender.tag==1){
        // [self.myTab reloadData];
    }
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
        
        if(indexPath.section==0){
            lab.text = @"入门级";
        }else if(indexPath.section==1){
            lab.text = @"初级";
            
        }else if(indexPath.section==2){
            lab.text = @"中级";
        }
        [headView addSubview:lab];
        
        
        return headView;
        
    } else if (kind == UICollectionElementKindSectionFooter) {
    }
    return nil;
    
}


//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    
    return 3;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

//设置元素内容
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =@"ItemCell";
   ItemViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.CityName.text =@"2132132";
    cell.CityName.textColor = KGrayColor;
    cell.layer.borderColor  = KGrayColor.CGColor;
    if(indexPath ==self.firstindex ){
        cell.CityName.textColor = mainColor;
        cell.layer.borderColor  = mainColor.CGColor;
    }
    if(indexPath ==self.secondindex ){
        cell.CityName.textColor = mainColor;
        cell.layer.borderColor  = mainColor.CGColor;
    }
    if(indexPath ==self.thirdindex ){
        cell.CityName.textColor = mainColor;
        cell.layer.borderColor  = mainColor.CGColor;
    }

    return cell;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
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
    return CGSizeMake((KScreenWidth-104)/3.0,32);
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    if(indexPath.section ==0 )
    {
        self.firstindex =indexPath;
        [self.rightColl reloadData];
    }else
        if(indexPath.section ==1 )
        {
            self.secondindex = indexPath;
            [self.rightColl reloadData];
        }else if(indexPath.section ==2)
        {
            self.thirdindex = indexPath;
            [self.rightColl reloadData];
                    }

}


-(void)leftItemClick:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
