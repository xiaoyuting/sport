//
//  selectHeadCell.m
//  football
//
//  Created by 雨停 on 2017/7/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "selectHeadCell.h"
#import "ItemViewCell.h"
#import "statusSmodel.h"
@interface selectHeadCell()
@property (nonatomic,strong) UICollectionViewFlowLayout * flowLayer;//自定义layout
@property (nonatomic,strong) UICollectionView *collecView;
@property (nonatomic) CGFloat  collH;
@property (nonatomic ,assign)NSIndexPath *firstindex;
@property (nonatomic ,assign)NSIndexPath *secondindex;
@property (nonatomic ,assign)NSIndexPath *thirdindex;

@end
@implementation selectHeadCell


    
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
  
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setContentView:(NSArray *)dataArray
{   self.firstindex  =[NSIndexPath indexPathForRow:0 inSection:0];
    self.secondindex  =[NSIndexPath indexPathForRow:0 inSection:1];
    self.thirdindex   = [NSIndexPath indexPathForRow:0 inSection:2];
    self.cityArray=dataArray;
    [self setSubview];
}

- (void)setSubview{
    self.flowLayer = [[UICollectionViewFlowLayout alloc]init];
    [self.flowLayer setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collecView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, [selectHeadCell HeightWithArray:self.cityArray]) collectionViewLayout:self.flowLayer];
    self.collecView.delegate = self;
    self.collecView.dataSource = self;
    UINib *cellNib=[UINib nibWithNibName:@"ItemViewCell" bundle:nil];
    self.collecView.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    [  self.collecView registerNib:cellNib forCellWithReuseIdentifier:@"ItemCell"];
    self.collecView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.collecView];
}
//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   return self.cityArray.count;
}

//设置元素内容
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    ItemViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];
    statusSmodel     * model =self.cityArray[indexPath.row];
    cell.CityName.text=model.name;
    
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
    return 8;
}
//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{  //top, left, bottom, right;
    UIEdgeInsets top = {0,10,0,10};
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
    return CGSizeMake((KScreenWidth-104)/3.0,32);
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"%@",indexPath);
   
    if(indexPath.section ==0 ){
        self.firstindex =indexPath;
        [self.collecView reloadData];
        if(self.cheakinfo){
            self.cheakinfo(self.firstindex );
        }
    }else
      if(indexPath.section ==1 ){
          self.secondindex = indexPath;
           [self.collecView reloadData];
          if(self.cheakinfo){
              self.cheakinfo(  self.secondindex );
          }
    }else if(indexPath.section ==2){
          self.thirdindex = indexPath;
         [self.collecView reloadData];
        if(self.cheakinfo){
            self.cheakinfo(  self.thirdindex);
        }
    }
   
 
}
+ (CGFloat)HeightWithArray:(NSArray *)array
{
    CGFloat height;
    if (array.count%3==0) {
        
        height=array.count/3*32+(array.count/3+1)*8-16;
    }else{
        
        height=(array.count/3+1)*32+(array.count/3+2)*8-16;
    }
   
    return height;
}

@end
