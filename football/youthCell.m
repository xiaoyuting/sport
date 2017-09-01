//
//  youthCell.m
//  football
//
//  Created by 雨停 on 2017/6/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "youthCell.h"
#import "SDAutoLayout.h"
#import "coursesModel.h"

@implementation youthCell
{
    UIImageView   * _top;
    UIImageView  * _pic ;
    UILabel      * _title;
    UILabel      * _detaile;
    UILabel      * _timeraddress;
    UIImageView  * _line;
    UIImageView  * _photo;
    UILabel      * _name;
    UILabel      * _vip;
    UILabel      * _num;
    UIButton     * _btn;
    UIImageView  * _bottom;
    UILabel      * _stylenum;
    UILabel      * _price;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView * top = [UIImageView new];
        top.backgroundColor =[UIColor colorWithHexString:@"#F9F9F9"];

        _top =top;
        UIImageView *pic = [UIImageView new];
        
        pic.contentMode = UIViewContentModeScaleAspectFill;
        pic.layer.masksToBounds =YES;
        _pic = pic;
        UILabel * title  = [[UILabel alloc]init];
        _title = title;
        //UILabel  *detaitle = [[UILabel alloc]init];
        //_detaile = detaitle;
        UILabel * timeraddress = [[UILabel alloc]init];
        timeraddress.font = [UIFont systemFontOfSize:12];
        _timeraddress = timeraddress ;
        UIImageView *line = [[UIImageView alloc]init];
        line.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _line = line;
        UIImageView *photo  = [[UIImageView alloc]init];
 
        photo.layer.masksToBounds =YES;
        photo.layer.cornerRadius=15;
        
        _photo.image = [UIImage imageNamed:@"cocoaPic"];
        _photo = photo;
        UILabel *stylenum  =[XYUIKit labelWithTextColor:mainColor numberOfLines:0 text:nil fontSize:13];
       
        stylenum.layer.borderColor = mainColor.CGColor;
        stylenum.layer.borderWidth = 1;
        _stylenum    = stylenum;
        UILabel * name = [[UILabel alloc]init];
        _name = name;
        UILabel * vip = [[UILabel alloc]init];
        vip.font = [UIFont systemFontOfSize:12];
        _vip = vip;
        UILabel * num = [[UILabel alloc]init];
        num.font =FontSize(13);
        num.textAlignment = NSTextAlignmentRight;
        num.textColor =KGrayColor;
        _num = num;
        UIButton * btn  = [[UIButton alloc]init];
        [btn setTitleColor:mainColor forState:UIControlStateNormal];
        btn.layer.borderWidth =1;
        btn.layer.borderColor = mainColor.CGColor;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
     
        _btn = btn;
        UIImageView *bottom = [[UIImageView alloc]init];
        bottom.backgroundColor =[UIColor colorWithHexString:@"#f9f9f9"];
        _bottom = bottom;
        UILabel * price = [XYUIKit labelWithTextColor:KmainRed numberOfLines:0 text:nil fontSize:13];
        price.font =FontBold(13);
        price.textAlignment =NSTextAlignmentRight;
        _price =price;
   
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
        
        [self.contentView sd_addSubviews:@[top,pic, title, stylenum,price,timeraddress ,line, photo,name,vip,num,btn,bottom]];
        
        
        top.sd_layout
        .topSpaceToView(self.contentView, 0)
        .heightIs(10)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView);
        
        _pic.sd_layout
        .widthIs(120)
        .heightIs(120)
        .topSpaceToView(_top, 16)
        .leftSpaceToView(self.contentView, 16);
        
        _title.sd_layout
        .topEqualToView(_pic)
        .leftSpaceToView(_pic, 16)
        .rightSpaceToView(self.contentView, 10)
        //.heightRatioToView(_pic, 0.4);
        .autoHeightRatio(0);
        
       // _detaile.sd_layout
       // .topSpaceToView(_title, 10)
       // .leftSpaceToView(_pic, 10)
       // .rightSpaceToView(self.contentView, 10)
       // .autoHeightRatio(0);
        _stylenum.sd_layout
        .leftSpaceToView(_pic, 16)
        .bottomEqualToView(_pic)
        .heightIs(18);
        [_stylenum setSingleLineAutoResizeWithMaxWidth:100];
        
        _price.sd_layout
        .leftSpaceToView(_stylenum, 0)
        .rightSpaceToView(self.contentView, 16)
        .heightIs(18)
        .centerYEqualToView(_stylenum);
        
        _timeraddress.sd_layout
        .topSpaceToView(_title, 0)
        .leftSpaceToView(_pic, 16)
        .rightSpaceToView(self.contentView, 10)
        .autoHeightRatio(0);
        
        _line.sd_layout
        .topSpaceToView(_pic, 16)
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(1);
       
        _photo.sd_layout
        .leftSpaceToView(self.contentView, 16)
        .topSpaceToView(_line , 16)
        .widthIs(30)
        .heightIs(30);
        
        _name.sd_layout
        .leftSpaceToView(_photo, 10)
        .centerYEqualToView(_photo)
        .heightIs(20)
        .widthIs(80);
        
       /* _vip.sd_layout
        .leftSpaceToView(_photo, 10)
        .bottomEqualToView(_photo)
        .heightIs(20)
        .widthIs(40);*/
        
        _bottom.sd_layout
        .topSpaceToView(_photo, 10)
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(1);
        
        _btn.sd_layout
        .rightSpaceToView(self.contentView, 10)
        .centerYEqualToView(_photo);
        [_btn setupAutoSizeWithHorizontalPadding:5 buttonHeight:25];
        
        _num.sd_layout
        .centerYEqualToView(_photo)
        .rightSpaceToView(_btn, 10)
        .heightIs(20)
        .widthIs(100);
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
        [self setupAutoHeightWithBottomViewsArray:@[ _pic, _title, _stylenum, _price,_timeraddress ,_line, _photo,_name,_vip,_num,_btn,_bottom] bottomMargin:0];
       // [self setupAutoHeightWithBottomView:_view4 bottomMargin:10];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setYouthmodelleft:(coursesModel *)youthmodelleft{
    _youthmodelleft = youthmodelleft;
   // [_pic sd_setImageWithURL:imgUrl(youthmodelleft.cover_url) placeholderImage:Img(@"lesson")];
    
    _photo.image = [UIImage imageNamed:@"cocoaPic"];
   // _title.text =youthmodelleft.title;
    _detaile.text = @"运动内容详情介绍";
    _stylenum.text =@" U16 ";
    _timeraddress.text = @"2017-05-28|上海虹口足球场";
    _name.text = @"姓名";
    _vip.text = @"国家级";
    _num.text = @"还有6个名额";
   // _price.text =[NSString stringWithFormat:@"¥%@/年",youthmodelleft.sell_price];//@"¥1999/年";
    [_btn setTitle:@"我要报名" forState:UIControlStateNormal];
}

- (void)setModel:(coursesModel *)model
{
    _model = model;
    [_pic sd_setImageWithURL:imgUrl(model.cover_url) placeholderImage:Img(@"lesson")];
    
    [_photo sd_setImageWithURL:imgUrl(model.coach_header) placeholderImage: [UIImage imageNamed:@"cocoaPic"]];
    _title.text =model.title;
 
    _stylenum.text = [NSString stringWithFormat:@" U%@ ",model.level];//@" U16 ";
    _timeraddress.text =[NSString stringWithFormat:@"%@|%@",model.start_time,model.address];
 
    _name.text = model.coach_name;
 
    if([model.status isEqualToString:@"1"]){
        _num.text =    [NSString stringWithFormat: @"还有%@个名额", model.surplus];
        [_btn setTitle:@"我要报名" forState:UIControlStateNormal];
    }else{
         _num.text=@"";
         [_btn setTitle:@"已报满" forState:UIControlStateNormal];
          _btn.layer.borderColor = KGrayColor.CGColor;
         [_btn setTitleColor:KGrayColor forState:UIControlStateNormal];
         _btn.userInteractionEnabled =NO;
    }
    
    _price.text =[NSString stringWithFormat:@"¥%@/年",model.sell_price];//@"¥1999/年";
   
   }
-(void)setCoachmodel:(coursesModel *)coachmodel{
    _coachmodel = coachmodel;
    [_pic sd_setImageWithURL:imgUrl(coachmodel.cover_url) placeholderImage:Img(@"lesson")];
    
   // _photo.image = [UIImage imageNamed:@"cocoaPic"];
    _title.text =coachmodel.title;
    
    _stylenum.text = [NSString stringWithFormat:@" U%@ ",coachmodel.level];//@" U16 ";
    _timeraddress.text =[NSString stringWithFormat:@"%@|%@",coachmodel.start_time,coachmodel.address];
    
    _name.hidden=YES;
    _num .hidden=YES;
    _btn .hidden=YES;
    _photo.hidden=YES;
    _price.text =[NSString stringWithFormat:@"¥%@/年",coachmodel.sell_price];
    

}
@end
