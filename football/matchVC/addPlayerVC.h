//
//  addPlayerVC.h
//  football
//
//  Created by 雨停 on 2017/8/1.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "XYBaseVC.h"
@protocol infoDicdelegate
-(void)setPlayerInfo:(NSString *)str;
@end
@interface addPlayerVC : XYBaseVC
@property (weak, nonatomic) IBOutlet UIImageView *photoPic;
@property (weak, nonatomic) IBOutlet UILabel *playName;
@property (weak, nonatomic) IBOutlet UILabel *posizition;
@property (weak, nonatomic) IBOutlet UIButton *bottom;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (nonatomic, weak) id <infoDicdelegate> playerInfodelegate;
@property  (nonatomic ,copy ) NSString   * from;
@property  (nonatomic,strong) NSDictionary *dic;
@property  (nonatomic,copy)   NSString   * teamId;
 
@end
