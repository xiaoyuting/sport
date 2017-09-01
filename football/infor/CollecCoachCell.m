//
//  CollecCoachCell.m
//  football
//
//  Created by 雨停 on 2017/6/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "CollecCoachCell.h"
#import "coachesModel.h"
@implementation CollecCoachCell
{
    UIImageView  * photo;
    UILabel      * name;
    UILabel      * team;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        CGFloat w  =self.contentView.frame.size.width;
        photo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, w, w)];

        photo.contentMode = UIViewContentModeScaleToFill;
        photo.clipsToBounds = YES;
        [self.contentView addSubview: photo];
        
        name  = [[UILabel alloc]initWithFrame:CGRectMake(0,w+8.5, self.contentView.frame.size.width, 24)];
        name.textAlignment = NSTextAlignmentLeft;
        name.font = [UIFont systemFontOfSize:17];
        name.text = @"教练名";
        [self.contentView addSubview:name];
        team  = [[UILabel alloc]initWithFrame:CGRectMake(0,w+8.5+24, self.contentView.frame.size.width, 28)];
        team.textAlignment = NSTextAlignmentLeft;
        
        team.font = [UIFont systemFontOfSize:13];
        team.text = @"球队名";
        [self.contentView addSubview:team];
    }
    return self;
}
-(void)setModel:(coachesModel *)model{
    _model=model;
    [photo sd_setImageWithURL:imgUrl(model.header_url) placeholderImage:Img(@"coach")];
    name.text = model.name;
    team.text = model.team_name;
}
@end
