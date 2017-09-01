//
//  leftCoachCell.h
//  football
//
//  Created by 雨停 on 2017/6/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^coachBlock) ();
typedef void(^coachDetaile)(NSIndexPath * indexPath);
@interface leftCoachCell : UITableViewCell
@property  (nonatomic,copy) coachBlock  coachBlock;
@property  (nonatomic,copy) coachDetaile  coachDetaile;
-(void)setInfoArr:(NSArray * )arr;

@end
