//
//  SearchResult.h
//  NBSearchView
//
//  Created by Alesary on 15/11/17.
//  Copyright © 2015年 Alesary. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  搜索结果的类
 */
@interface SearchResult : NSObject
/**
 *  获取搜索的结果集
 *
 *
 *
 *  
 */
+ (NSMutableArray*)getSearchResultBySearchText:(NSString*)searchText dataArray:(NSMutableArray*)dataArray;

@end
