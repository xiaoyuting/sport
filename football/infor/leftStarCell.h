//
//  leftStarCell.h
//  football
//
//  Created by 雨停 on 2017/6/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BlockType)();
typedef void(^starDetaile)(NSIndexPath * indexPath);
@interface leftStarCell : UITableViewCell
@property (nonatomic,copy)BlockType block;
@property (nonatomic,copy)starDetaile starDetaile;
-(void)setInfoArr:(NSArray * )arr;
@end
