//
//  CityViewCell.m
//  AddressInfo
//
//  Created by Alesary on 16/1/6.
//  Copyright © 2016年 Mr.Chen. All rights reserved.
//

#import "CityViewCell.h"
#import "ItemViewCell.h"
#import "ZWCollectionViewFlowLayout.h"
#import "Public.h"

static NSString *cellIdentifier = @"ItemCell";

@interface CityViewCell () <ZWwaterFlowDelegate>
{
    UICollectionView *_CollectionView;
    
    ZWCollectionViewFlowLayout *_flowLayout;//自定义layout
}

@end
@implementation CityViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    return self;
}

-(void)setContentView:(NSArray *)dataArray
{
     self.cityArray=dataArray;
     [self initContentView];
}
-(void)initContentView
{
    
    //初始化自定义layout
    _flowLayout = [[ZWCollectionViewFlowLayout alloc] init];
    _flowLayout.colMagrin = ColMagrin;
    _flowLayout.rowMagrin = RowMagrin;
    _flowLayout.sectionInset = UIEdgeInsetsMake(RowMagrin, ColMagrin, ColMagrin, RowMagrin);
    _flowLayout.colCount = 3;
    _flowLayout.degelate = self;
    
    _CollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screen_width, [CityViewCell getHeightWithCityArray:self.cityArray]) collectionViewLayout:_flowLayout]; 
    _CollectionView.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    //注册显示cell的类型
    UINib *cellNib=[UINib nibWithNibName:@"ItemViewCell" bundle:nil];
    
    [_CollectionView registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    
    _CollectionView.delegate=self;
    _CollectionView.dataSource=self;
    
    _CollectionView.bounces=NO;
    _CollectionView.scrollEnabled=NO;
    _CollectionView.showsVerticalScrollIndicator=NO; //指示条
   // _CollectionView.backgroundColor=[UIColor whiteColor];

    
    [self addSubview:_CollectionView];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.cityArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
     ItemViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.CityName.text=self.cityArray[indexPath.item];
     return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    [self.delegate SelectCityNameInCollectionBy:self.cityArray[indexPath.item]];
}


#pragma mark ZWwaterFlowDelegate
- (CGFloat)ZWwaterFlow:(ZWCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPach
{
    
    return colHeight;
}

+ (CGFloat)getHeightWithCityArray:(NSArray *)array
{
    CGFloat height;
    if (array.count%3==0) {
        
        height=array.count/3*colHeight+(array.count/3+1)*RowMagrin;
    }else{
        
        height=(array.count/3+1)*colHeight+(array.count/3+2)*RowMagrin;
    }
    
    return height;
}

@end
