//
//  integralCell.m
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "integralCell.h"

@implementation integralCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    
    self.teamname.text  = [dic objectForKey:@"team_name"];
    self.FS.text =  [dic objectForKey:@"integral"];
    self.HH.text =  [dic objectForKey:@"card"];
    self.ZJ.text =  [dic objectForKey:@"score"];
    self.DF.text =  [dic objectForKey:@"ball"];
}
@end
