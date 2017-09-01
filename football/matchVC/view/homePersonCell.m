//
//  homePersonCell.m
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "homePersonCell.h"
#import "homePersonModel.h"
@implementation homePersonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(homePersonModel *)model{
    _model = model;
    [_pic sd_setImageWithURL:imgUrl(model.header_url) placeholderImage:nil];
    _name.text = model.name;
    _team.text = model.title ;
    if([model.type isEqualToString:@"0"]){
        self.numLab.text =[NSString stringWithFormat:@"%@号", model.number];
        self.pizition .text = model.position;
    }
    
}
@end
