//
//  leftCollecStarCell.m
//  football
//
//  Created by 雨停 on 2017/6/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "leftCollecStarCell.h"
#import "XYUIKit.h"
#import "playersModel.h"
@implementation leftCollecStarCell
{
    UIImageView  * photo;
    UIImageView  * tag;
    UILabel      * name;
    UILabel      * team;
    UILabel      * num;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor =[UIColor colorWithHexString:@"F9F9F9"];
        CGFloat w = self.contentView.frame.size.width;
        photo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,w ,w*209.67/375.0)];
        photo.contentMode = UIViewContentModeScaleAspectFill;
        photo.layer.cornerRadius = 5;
        photo.layer.masksToBounds  =YES;
        photo.layer.borderWidth = 12;
        photo.layer.borderColor =KWhiteColor.CGColor;
        //photo.image = Img(@"start");
        [self.contentView addSubview: photo];
        tag =  [[UIImageView alloc]init];
        [photo addSubview: tag];
        tag.image = Img(@"starTag");
        tag.frame = CGRectMake(photo.frame.size.width-56, 12, 44, 60);
        
        num =[XYUIKit labelWithBackgroundColor:KClearColor textColor:KWhiteColor textAlignment:NSTextAlignmentCenter numberOfLines:0 text:nil fontSize:17];
        num.frame  = CGRectMake(0, 4, 44, 18);
        num.font  = FontBold(17);
        [tag addSubview: num];
        
        
        UILabel * qi =[XYUIKit labelWithBackgroundColor:KClearColor textColor:KWhiteColor textAlignment:NSTextAlignmentCenter numberOfLines:0 text:@"期" fontSize:17];
        qi.frame  = CGRectMake(0, 25, 44, 18);
        [tag addSubview: qi];

        
        name  = [XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLines:1 text:@"球星名字" fontSize:24];
        name.frame  = CGRectMake(0,photo.bottom+9   , self.contentView.frame.size.width, 20);
        [self.contentView addSubview:name];
        
        team  = [XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLines:1 text:@"球星所在球队" fontSize:13];
        team.frame  = CGRectMake(0,name.bottom+5, self.contentView.frame.size.width, 18);

        [self.contentView addSubview:team];
    }
    return self;
}
-(void)setModel:(playersModel *)model {
    _model  = model;
    [photo sd_setImageWithURL:imgUrl(model.cover_url) placeholderImage:Img(@"start")];
    num.text =model.stage;
    name.text =model.name;
    team.text = model.team_name;
}

@end
