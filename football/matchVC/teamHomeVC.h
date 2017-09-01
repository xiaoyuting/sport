//
//  teamHomeVC.h
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "XYBaseVC.h"

@interface teamHomeVC : XYBaseVC
@property (weak, nonatomic) IBOutlet UILabel *teamName;
@property (nonatomic,copy) NSString  * teamID;
@property (nonatomic,strong)NSDictionary * dic;
@end
