//
//  inforleftCollectionCell.m
//  football
//
//  Created by 雨停 on 2017/6/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "inforleftCollectionCell.h"

#import "coursesModel.h"
@implementation inforleftCollectionCell
{
    UIImageView * pic;
    UILabel * title;
    UILabel * price;
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setSubview];
    }
    return self;
        }
-(void)setSubview{
    pic  = [[UIImageView alloc]init];
    pic.layer.cornerRadius = 2;
    pic.layer.masksToBounds =YES;
    [self.contentView addSubview:pic];
    CGFloat w  =self.contentView.frame.size.width;
    pic.frame =CGRectMake(0, 0, w, w);
 
    title  = [XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLines:0 text:@"推荐青训课程" fontSize:15];
    title.frame = CGRectMake(0, w+7,w, 48);
    [self.contentView addSubview:title];
    
    price = [XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor redColor] textAlignment:NSTextAlignmentLeft numberOfLines:1 text:@"¥360.0" fontSize:13];
    price.frame =  CGRectMake(0, w+7+48, w, 18);

    [self.contentView addSubview:price];
}
-(void)setModel:(coursesModel *)model{
    _model=model;
    [pic sd_setImageWithURL:imgUrl(model.cover_url) placeholderImage:Img(@"lesson")];
    title.text = model.title;
    price.text = [NSString stringWithFormat:@"¥%@/年",model.sell_price];
    
}
@end
