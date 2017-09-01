//
//  bottomCell.h
//  football
//
//  Created by 雨停 on 2017/7/31.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^leftcheak)(NSIndexPath *);
typedef void(^rightcheak)(NSIndexPath *);
@interface bottomCell : UITableViewCell
-(void)setCateArr:(NSMutableArray *)arr  setDetaileArr:(NSMutableArray *)arrdetaile;
@property (nonatomic,copy )leftcheak left;
@property (nonatomic,copy )rightcheak right;
@end
