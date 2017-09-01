//
//  NBSearchResultController.h
//  NBSearchView
//
//  Created by Alesary on 15/11/17.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NBSearchResultController;
@protocol NBSearchResultControllerDelegate <NSObject>

- (void)resultViewController:(NBSearchResultController*)resultVC didSelectFollowCity:(NSString*)cityName;


@end
@interface NBSearchResultController : UITableViewController
/**
 *  数据源数组
 */
@property (nonatomic,strong)NSMutableArray *dataSource;

/**
 *  delegate
 */
@property (nonatomic,weak) id<NBSearchResultControllerDelegate>delegate;


@end
