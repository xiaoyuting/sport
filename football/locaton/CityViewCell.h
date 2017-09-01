//
//  CityViewCell.h
//  AddressInfo
//
//  Created by Alesary on 16/1/6.
//  Copyright © 2016年 Mr.Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityViewCellDelegate <NSObject>

-(void)SelectCityNameInCollectionBy:(NSString *)cityName;

@end

@interface CityViewCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *cityArray;

@property(nonatomic, assign)id<CityViewCellDelegate> delegate;

-(void)setContentView:(NSArray *)dataArray;

+ (CGFloat)getHeightWithCityArray:(NSArray *)array;
@end
