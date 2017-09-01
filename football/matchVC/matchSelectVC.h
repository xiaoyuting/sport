//
//  matchSelectVC.h
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "XYBaseVC.h"
@protocol  selectInfodelegate
-(void)setRequest:(NSMutableDictionary *)dic;
@end
@interface matchSelectVC : XYBaseVC
@property (nonatomic,weak)id <selectInfodelegate> seledelegate;
@end
