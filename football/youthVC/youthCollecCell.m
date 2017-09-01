//
//  youthCollecCell.m
//  football
//
//  Created by 雨停 on 2017/6/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "youthCollecCell.h"
#import "SDAutoLayout.h"
#import "CollecCell.h"
#import "Header.h"
#import "XYUIKit.h"
@interface youthCollecCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property  (nonatomic,strong)UICollectionView   * collecView;
@property  (nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@property  (nonatomic,strong)UILabel  * titleLab;
@end
@implementation youthCollecCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setsubView];
    }
    return self;
}
-(void)setsubView{
   self.contentView.backgroundColor = RGBColor(222, 222, 222);

    self.titleLab = [XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor grayColor] textAlignment:NSTextAlignmentLeft numberOfLines:1 text:nil fontSize:12];
    self.titleLab.frame = CGRectMake(10, 20, KScreenWidth-20, 20);
    [self.contentView addSubview:self.titleLab];
    //self.layout = [[UICollectionViewLayout alloc]init];
    self.flowLayout=[[UICollectionViewFlowLayout alloc] init];
    //[self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collecView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40,KScreenWidth, 165) collectionViewLayout: self.flowLayout];
    
    self.collecView.backgroundColor = RGBColor(222, 222, 222);
    self.collecView.bounces = NO;
    self.collecView.scrollEnabled = NO;
    [self.collecView registerClass:[CollecCell class] forCellWithReuseIdentifier:@"cell"];
    self.collecView.delegate  = self;
    self.collecView.dataSource = self;
    [self.contentView addSubview:self.collecView];
    
   }
//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

//设置元素内容
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =@"cell";
   CollecCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
   
   // cell.backgroundColor = [UIColor redColor];
   //    Vide oModel*model = [self.videoModels objectAtIndex:indexPath.row];
//    NSURL *url =[NSURL URLWithString:model.videoImgURL];
//    
//    [cell.imgView setImageWithURL:url];
//    cell.titleLbale.text = model.videoTitle;
    cell.model = nil;
    return cell;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{  //top, left, bottom, right;
    UIEdgeInsets top = {0,5,0,5};
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
    return CGSizeMake((KScreenWidth-15)/2.0,80);
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
//    DetailVideoViewController *detailVC = [[DetailVideoViewControlleralloc]init];
//    [self.navigationControllerpushViewController:detailVCanimated:YES];
//    [detailVC release];
}
-(void)setStr:(NSString *)str{
    _str=str;
    self.titleLab.text =@"第一学年";
    [self.collecView reloadData];
}

@end
