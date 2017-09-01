//
//  leftYouthCell.m
//  football
//
//  Created by 雨停 on 2017/6/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "leftYouthCell.h"
#import "SDAutoLayout.h"
#import "XYUIKit.h"
#import "youthModel.h"
#import "newsModel.h"
@implementation leftYouthCell
{
    UIImageView  * _pic ;
    UILabel      * _title;
    UILabel      * _detaile;
    UILabel      * _timeraddress;
    UIImageView  * _line;
    
    UILabel      * _num;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *pic = [UIImageView new];
        
        _pic = pic;
        UILabel * title  = [XYUIKit labelTextColor:[UIColor blackColor] fontSize:17 ];
        _title = title;
        UILabel  *detaitle = [XYUIKit labelTextColor:[UIColor grayColor] fontSize:13];
        
        _detaile = detaitle;
        UILabel * timeraddress = [XYUIKit labelTextColor:[UIColor grayColor] fontSize:13];
        
        _timeraddress = timeraddress ;
        UIImageView *line = [[UIImageView alloc]init];
        line.image = Img(@"line2");
        _line = line;
        UILabel * num = [XYUIKit labelTextColor:[UIColor grayColor] fontSize:13];
        num.textAlignment  = NSTextAlignmentRight;
        _num = num;
        
        //        _titleLabel = [UILabel new];
        //        [self.contentView addSubview:_titleLabel];
        //        _titleLabel.textColor = [UIColor darkGrayColor];
        //        _titleLabel.font = [UIFont systemFontOfSize:15];
        //        _titleLabel.numberOfLines = 0;
        //
        //        _imageView = [UIImageView new];
        //        [self.contentView addSubview:_imageView];
        //        _imageView.layer.borderColor = [UIColor grayColor].CGColor;
        //        _imageView.layer.borderWidth = 1;
        
        
        //        CGFloat margin = 15;
        //        UIView *contentView = self.contentView;
        //
        //        _titleLabel.sd_layout
        //        .leftSpaceToView(contentView, margin)
        //        .topSpaceToView(contentView, margin)
        //        .rightSpaceToView(contentView, 120)
        //        .autoHeightRatio(0);
        //
        //        _imageView.sd_layout
        //        .topEqualToView(_titleLabel)
        //        .leftSpaceToView(_titleLabel, margin)
        //        .rightSpaceToView(contentView, margin)
        //        .heightIs(60);
        
        // 当你不确定哪个view在自动布局之后会排布在cell最下方的时候可以调用次方法将所有可能在最下方的view都传过去
        // [self setupAutoHeightWithBottomViewsArray:@[_titleLabel, _imageView] bottomMargin:margin];
        
        [self.contentView sd_addSubviews:@[pic, title, detaitle, timeraddress ,line,num]];
        
        
        
        _pic.sd_layout
        .widthIs(110)
        .heightIs(110)
        .topSpaceToView(self.contentView, 16)
        .leftSpaceToView(self.contentView, 16);
        
        _title.sd_layout
        .topEqualToView(_pic)
        .leftSpaceToView(_pic, 15)
        .rightSpaceToView(self.contentView, 15)
        //.heightRatioToView(_pic, 0.4);
        .autoHeightRatio(0);
        
        _detaile.sd_layout
        .topSpaceToView(_title, 4)
        .leftSpaceToView(_pic, 15)
        .rightSpaceToView(self.contentView, 15)
        .autoHeightRatio(0);
        
        _num.sd_layout
        .rightSpaceToView(self.contentView, 10)
        .heightIs(18)
        .bottomEqualToView(_pic)
        ;
        
        _timeraddress.sd_layout
        .bottomEqualToView(_pic)
        .leftSpaceToView(_pic, 15)
        .rightSpaceToView(self.contentView, 10)
        .heightIs(18);
        
        _line.sd_layout
        .topSpaceToView(_pic, 15)
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        
               //        _view4.sd_layout
        //        .leftEqualToView(_view2)
        //        .topSpaceToView(_view2, 10)
        //        .heightIs(30)
        //        .widthRatioToView(_view1, 0.7);
        //
        //        _view5.sd_layout
        //        .leftSpaceToView(_view4, 10)
        //        .rightSpaceToView(self.contentView, 10)
        //        .bottomSpaceToView(self.contentView, 10)
        //        .heightRatioToView(_view4, 1);
        
        
        //***********************高度自适应cell设置步骤************************
        [self setupAutoHeightWithBottomViewsArray:@[ _pic, _title, _detaile, _timeraddress ,_line,_num] bottomMargin:0];
        // [self setupAutoHeightWithBottomView:_view4 bottomMargin:10];
        
    }
    return self;
}
- (void)setModel:(youthModel *)model
{
    _model = model;
    _pic .backgroundColor =mainColor;
    _title.text =@"运动标题";
  _pic .image = Img(@"Consultation");
    _timeraddress.text = @"2017-05-28";
    _num.text  = @"阅读:983";
   
}
-(void)setModelcenter:(newsModel *)modelcenter{
    

    _modelcenter= modelcenter;
    _title.text =modelcenter.title;//modelcenter.cate_name;
    [_pic sd_setImageWithURL:imgUrl(modelcenter.cover_url) placeholderImage:nil];
    _detaile.text = modelcenter.descrip;
    _timeraddress.text = [NSString stringWithFormat:@"%@|%@", modelcenter.ctime,modelcenter.cate_name];
    _num.text  =  [NSString stringWithFormat:@"阅读:%@",modelcenter.hits];
}
-(void)setModelright:(youthModel *)modelright{
    _modelright  = modelright;
    _title.text =@"新闻标题";
   _pic .image = Img(@"Consultation");

    _detaile.text = @"新闻内容详情介绍";
    _timeraddress.text = @"2017-05-28";
    _num.text  = @"阅读:983";
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
