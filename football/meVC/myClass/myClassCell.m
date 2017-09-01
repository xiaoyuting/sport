//
//  myClassCell.m
//  football
//
//  Created by 雨停 on 2017/8/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "myClassCell.h"

@implementation myClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(NSString *)model{
    _model =model;
    self.endurance.currentScore =2;
    self.speed.currentScore =1;
    self.technology.currentScore =3;
    self.cooperation.currentScore =4;
    self.explosive.currentScore =3;
}
@end
