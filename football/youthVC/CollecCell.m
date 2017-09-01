//
//  CollecCell.m
//  football
//
//  Created by 雨停 on 2017/6/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "CollecCell.h"
#import "Masonry.h"
#import "SDAutoLayout.h"
#import "XYUIKit.h"
#import "onlineVcModel.h"
@implementation CollecCell{
    UILabel  * title;
    UILabel  * num;
    UILabel  * detatile;
    UILabel  * time;
    UIImageView * backImg;
    UIImageView * centerImg;
    UIButton    * btn;
}
-(instancetype)initWithFrame:(CGRect)frame {
    if(self= [super initWithFrame:frame]){
        [self setView];
    }
    return self;
}
-(void)setView{
  
    UIView *vc = self.contentView;
    backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, vc.frame.size.width, vc.frame.size.width)];
    //backImg.backgroundColor = mainColor;
 

    [vc addSubview: backImg];
    
    centerImg  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    centerImg.center = backImg.center;
    centerImg.image = Img(@"playV");
    [backImg addSubview: centerImg];
    time =[XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:KWhiteColor textAlignment:NSTextAlignmentCenter numberOfLines:1 text:nil fontSize:12];
    time.layer.cornerRadius = 8;
    time.layer.masksToBounds =YES;
    time.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
    time.frame = CGRectMake(8, vc.frame.size.width-8-16, 50, 16);
    [backImg addSubview: time];
    backImg.contentMode = UIViewContentModeScaleAspectFill;
    backImg.layer.masksToBounds =YES;
    btn = [[UIButton alloc]initWithFrame:CGRectMake(vc.frame.size.width-44, 0, 44, 44)];
    [btn setImage:Img(@"collect")  forState:UIControlStateNormal];
    [backImg addSubview:btn];
    title = [XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:KBlackColor textAlignment:NSTextAlignmentLeft numberOfLines:1 text:nil fontSize:17];
    title.frame = CGRectMake(0, vc.frame.size.width+4, vc.frame.size.width, 24);
    [vc addSubview: title];
    
    detatile  = [XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:KGrayColor textAlignment:NSTextAlignmentLeft numberOfLines:1 text:nil fontSize:13];
    detatile.frame = CGRectMake(0, vc.frame.size.width+4+24, vc.frame.size.width, 18);
    [vc addSubview:detatile];
    
}
-(void)setModel:(onlineVcModel *)model{
    _model=model;

    [backImg sd_setImageWithURL:imgUrl(model.cover) placeholderImage:Img(@"lesson")];
    title.text = model.video_title;
    num.text =model.term;
    //detatile.text = @"共10个教学小视频";
    time.text  = [NSString stringWithFormat:@"%@小时",model.hours] ;
}
@end
