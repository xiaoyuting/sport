//
//  selectHeadCell.h
//  football
//
//  Created by 雨停 on 2017/7/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^cheakinfo)(NSIndexPath*);
@interface selectHeadCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
- (void)setContentView:(NSArray *)dataArray;
+ (CGFloat)HeightWithArray:(NSArray *)array;
@property  (nonatomic, strong) NSArray *cityArray;
@property  (nonatomic,copy)cheakinfo cheakinfo;
@end
