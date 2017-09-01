//
//  partInCell.m
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "partInCell.h"

@implementation partInCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDic:(NSDictionary *)dic{
    _dic=dic;
    self.teamPic.layer.cornerRadius=35;
    self.teamDetaile.text = [_dic objectForKey:@"description"];
    [self.teamPic sd_setImageWithURL:imgUrl([_dic objectForKey:@"logo"]) placeholderImage:nil];
    self.teamName.text = [_dic objectForKey:@"team_name"];
}
@end
