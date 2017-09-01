//
//  starCollectionCell.m
//  football
//
//  Created by 雨停 on 2017/6/30.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "starCollectionCell.h"
#import "XYUIKit.h"
@implementation starCollectionCell
{
    UIImageView  * photo;
    UILabel      * tag;
    UILabel      * name;
    UILabel      * team;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.contentView.layer.cornerRadius   = 5;
        self.contentView.layer.borderWidth    = 1;
        self.contentView.layer.masksToBounds  =YES;
        photo = [[UIImageView alloc]initWithFrame:CGRectMake(20,40, 40, 40)];
        photo.layer.cornerRadius = 20;
        photo.layer.masksToBounds = YES;
        photo.layer.borderWidth =1;
        photo.image = [UIImage imageNamed:@"cat.jpeg"];
        [self.contentView addSubview: photo];
        tag = [XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor grayColor] textAlignment:NSTextAlignmentCenter numberOfLines:1 text:@"091期" fontSize:13];
        
        
        
        tag.frame = CGRectMake(self.contentView.frame.size.width-80, 0, 80, 40);
        tag.layer.borderWidth =1;
        [self.contentView addSubview: tag];
        
        name  = [XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLines:1 text:@"球星名字" fontSize:14];
        name.frame  = CGRectMake(70,40,200, 20);
        [self.contentView addSubview:name];
        
        team  = [XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLines:1 text:@"球星所在球队" fontSize:14];
        team.frame  = CGRectMake(70,60 , 200, 20);
        
        [self.contentView addSubview:team];
    }
    return self;
}
@end
