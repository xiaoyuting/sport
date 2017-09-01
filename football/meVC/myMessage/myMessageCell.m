//
//  myMessageCell.m
//  football
//
//  Created by 雨停 on 2017/8/8.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "myMessageCell.h"
#import "SDAutoLayout.h"
@implementation myMessageCell{
    UIImageView  * _pic;
    UILabel      * _title;
    UILabel      * _detaile;
    UILabel      * _time;
    UIImageView  * _line;
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
        [self setSubView];
    }
   
    return self;
}
-(void)setSubView{
    _pic  = [[UIImageView alloc]init];
    _title = [[UILabel alloc]init];
    _detaile  = [[UILabel alloc]init];
    _time  = [[UILabel alloc]init];
    _line  = [[UIImageView alloc]init];
    _line.image = Img(@"line2");
     [self.contentView sd_addSubviews:@[_pic, _title, _detaile,_time,_line]];
    
    
    _pic.sd_layout
    .widthIs(44)
    .heightIs(44)
    .topSpaceToView(self.contentView, 24)
    .leftSpaceToView(self.contentView, 17);
    
    _title.sd_layout
    .centerYEqualToView(_pic)
    .leftSpaceToView(_pic, 14)
    .rightSpaceToView(self.contentView, 15)
   
    .autoHeightRatio(0);
    
    _detaile.sd_layout
    .topSpaceToView(_title, 18)
    .leftSpaceToView(_pic, 15)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    _time.sd_layout
    .topSpaceToView(_detaile, 8)
    .leftSpaceToView(_pic, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(18);
    _line.sd_layout
    .topSpaceToView(_time, 20)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(1);
    
    //***********************高度自适应cell设置步骤************************
    [self setupAutoHeightWithBottomViewsArray:@[ _pic, _title, _detaile, _time,_line] bottomMargin:4];
    
}
-(void)setModel:(commentsModel*)model{
    
    _model= model;
    _pic.layer.cornerRadius =22;
    _pic.layer.masksToBounds=YES;
    [_pic sd_setImageWithURL:imgUrl(model.header_url) placeholderImage:nil];
    _title.text  =model.username;
    _detaile.text = model.content;
    _time.text   = model.comment_time;
}
@end
