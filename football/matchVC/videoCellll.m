//
//  videoCell.m
//  football
//
//  Created by 雨停 on 2017/6/29.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "videoCellll.h"
#import "SDAutoLayout.h"
#import "XYUIKit.h"
#import "Header.h"
@implementation videoCellll{
    UIImageView  * _head;
    UILabel      * _from;
    UIImageView  * _tag;
    UIImageView  * _center;
    UIImageView  * _pic ;
    UILabel      * _title;
    UILabel      * _time;
    UIButton     * _btn;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setSubview];
    }
    return self;
}
-(void)setSubview{
    UIImageView  * head = [[UIImageView alloc]init];
    
    head.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    _head = head;
    UIImageView    * pic  = [[UIImageView alloc]init];
    _pic  = pic;
    
    UILabel        * title = [XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft numberOfLines:0 text:nil fontSize:17];
    _title    = title;
    
    UILabel        * time  = [XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:KGrayColor textAlignment:NSTextAlignmentLeft numberOfLines:1 text:nil fontSize:13];
    _time   = time ;
    
    UIButton       * btn = [[UIButton alloc]init];
   
    _btn  = btn;
    [_btn setImage:Img(@"shear") forState:UIControlStateNormal];
    [self.contentView sd_addSubviews:@[head,pic,title,time,btn]];
    UIView * vc  = self.contentView;
    _head.sd_layout
    .topSpaceToView(vc, 0)
    .leftSpaceToView(vc, 0)
    .rightSpaceToView(vc, 0)
    .heightIs(5);
    _pic.sd_layout
    .topSpaceToView(_head, 0)
    .widthIs(KScreenWidth)
    .heightIs(kScaleWidth(211));
    
    _title.sd_layout
    .topSpaceToView(_pic, 10)
    .leftSpaceToView(vc, 10)
    .rightSpaceToView(vc, 10)
    .autoHeightRatio(0);
    
    _time.sd_layout
    .topSpaceToView(_title, 8)
    .leftSpaceToView(vc, 16)
    .heightIs(20);
    [_time setSingleLineAutoResizeWithMaxWidth:200];

    
    _btn.sd_layout
    .rightSpaceToView(vc, 10)
    .centerYEqualToView(_time)
    .widthIs(30)
    .heightIs(30);
    
    [self setupAutoHeightWithBottomView:_btn bottomMargin:10];
    _tag = [[UIImageView alloc]initWithFrame:CGRectMake(16, 16, 65, 22.5)];
    _tag.image =Img(@"playing");
    [_pic addSubview:_tag];
    _center=   [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 94, 94)];
    _center.image = Img(@"playV");
    _center.center =_pic.center;
    [_pic addSubview:_center];
    _from = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KWhiteColor textAlignment:NSTextAlignmentRight numberOfLines:0 text:nil fontSize:13];
    _from.frame =CGRectMake(_pic.frame.size.width-118, 21, 100, 18);
    [_pic addSubview:_from];
}

-(void)setModel:(youthModel *)model{
    _model = model ;
    _pic.image = [UIImage imageNamed:@"cat2.jpeg"];
    _title .text = @"这里是直播标题，这里是直播标题，这里是直播标题，这里是直播标题";
    _time . text = @"2017-05-28|上海南站";
    _from . text = @"来源：花椒";
}

@end
