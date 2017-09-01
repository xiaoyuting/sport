//
//  shooterCell.m
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "shooterCell.h"

@implementation shooterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDicC:(NSDictionary *)dicC{
    _dicC= dicC;
    [self.playerImg sd_setImageWithURL:imgUrl([_dicC objectForKey:@"header"]) placeholderImage:nil];
    self.soccerNum.text = [dicC objectForKey:@"goal"];
    self.teamName.text = [dicC objectForKey:@"team_name"];
    self.playname.text = [dicC objectForKey:@"member_name"];
}
-(void)setDicR:(NSDictionary *)dicR{
    _dicR= dicR;
    [self.playerImg sd_setImageWithURL:imgUrl([_dicC objectForKey:@"header"]) placeholderImage:nil];
    self.soccerNum.text = [dicR objectForKey:@"assists"];
    self.teamName.text = [dicR objectForKey:@"team_name"];
    self.playname.text = [dicR objectForKey:@"member_name"];
}

@end
