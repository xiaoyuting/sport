//
//  leftStarCell.m
//  football
//
//  Created by 雨停 on 2017/6/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "leftStarCell.h"
#import "XYUIKit.h"
#import "Header.h"
#import "leftCollecStarCell.h"
@interface leftStarCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UILabel  *title;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)UICollectionView  * collecView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayer;
@property  (nonatomic,strong)NSArray   * arr;
@end
@implementation leftStarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
    }
    return self;
}

-(void)setInfoArr:(NSArray * )arr{
    self.arr = arr;
    [self setSubView];
}
-(void)setSubView{
    
    self.title   = [ XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLines:1 text:@"今日球星" fontSize:21];
    self.title.font =FontBold(21);
    self.title.frame = CGRectMake(20, 17, (KScreenWidth-40)/2.0, 29);
    [self.contentView addSubview:self.title];
    
    
    self.btn = [XYUIKit buttonWithBackgroundColor:[UIColor clearColor] titleColor:mainColor title:@"往期球星" fontSize:17];
    [self.btn addTarget:self action:@selector(getInfo) forControlEvents:UIControlEventTouchUpInside];
    self.btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.btn.frame = CGRectMake(KScreenWidth/2.0, 20,KScreenWidth/2.0-11,24 );
    [self.contentView addSubview: self.btn];
    self.flowLayer = [[UICollectionViewFlowLayout alloc]init];
    [self.flowLayer setScrollDirection:UICollectionViewScrollDirectionHorizontal  ];
    self.collecView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 45.5, KScreenWidth, (KScreenWidth-40)*267.85/335.0) collectionViewLayout:self.flowLayer];
    self.collecView.delegate = self;
    self.collecView.dataSource = self;
    [self.collecView registerClass:[leftCollecStarCell class] forCellWithReuseIdentifier:@"cell"];
    self.collecView.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
    self.collecView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.collecView];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, (KScreenWidth-40)*267.85/335.0+44.5, KScreenWidth, 1)];
    line.image = Img(@"line2");
    [self.contentView addSubview:line];
    
    
    
}
-(void)getInfo{
    if(self.block){
        self.block(_btn);
    }
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
    static NSString *identify =@"cell";
  leftCollecStarCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.model=self.arr[indexPath.row];
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
    UIEdgeInsets top = {0,20,0,20};
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
    
    self.starDetaile(indexPath);
}


@end
