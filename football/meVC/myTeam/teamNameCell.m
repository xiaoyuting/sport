//
//  teamNameCell.m
//  football
//
//  Created by 雨停 on 2017/8/1.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "teamNameCell.h"

@implementation teamNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDic:(NSDictionary *)dic{
    _dic=dic;
    self.teamName.text = [_dic objectForKey:@"name"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
