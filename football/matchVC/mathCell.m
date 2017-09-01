//
//  mathCell.m
//  football
//
//  Created by 雨停 on 2017/6/29.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "mathCell.h"
#import "SDAutoLayout.h"
#import "XYUIKit.h"
#import "matchleftcellModel.h"

@implementation mathCell{
    UIImageView * _head;
    UIImageView * _pic ;
    UILabel     * _tag ;
    UILabel     * _title ;
    UILabel     * _timeadreess;
    UIImageView * _line;
    UILabel     * _price;
    UILabel     * _originalprice;
    UILabel     * _num;
    UIButton    * _btn;
    UILabel     * _match;
    UILabel     * _personnum;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ( self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self setSubView];
    }
    
    return  self ;
    
}

-(void)setSubView{
    UIImageView  * head = [[UIImageView alloc]init];

    head.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    _head = head;
    
    UIImageView  * pic = [[UIImageView alloc]init];
    pic.layer.masksToBounds=YES;
    pic.contentMode =UIViewContentModeScaleAspectFill;
    _pic = pic ;
    
    UILabel      * tag = [XYUIKit labelWithBackgroundColor:[UIColor greenColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter numberOfLines:1 text:nil fontSize:13];
    tag.layer.masksToBounds = YES ;
    tag.layer.cornerRadius =10;
    tag.backgroundColor = mainColor;
    _tag = tag;

    UILabel      * title = [XYUIKit labelWithTextColor:[UIColor blackColor] numberOfLines:0 text:nil fontSize:16];
    _title  = title;
    
    UILabel      * timeadreess = [XYUIKit labelTextColor:[UIColor grayColor] fontSize:13];
    _timeadreess  = timeadreess;
    
    UIImageView  * line = [[UIImageView alloc]init] ;
    line.backgroundColor = [UIColor colorWithHexString:@"#D9D9D9"];
    _line = line;
    
    UILabel * match = [XYUIKit labelWithTextColor:mainColor numberOfLines:1 text:nil fontSize:12];
    match.layer.borderWidth=1;
    match.layer.cornerRadius = 2;
    match.layer.borderColor=mainColor.CGColor;
    _match =match;
    UILabel *  personnum = [XYUIKit labelWithTextColor:mainColor numberOfLines:1 text:nil fontSize:12];
    personnum.layer.borderWidth=1;
    personnum.layer.cornerRadius = 2;
    personnum.layer.borderColor=mainColor.CGColor;
    _personnum = personnum;
    UILabel      * price = [XYUIKit labelTextColor:[UIColor redColor] fontSize:17];
    price.font =[UIFont fontWithName:@"ingFangSC-Semibold" size:17];
    _price  = price;
    
    UILabel *originalprice = [XYUIKit labelTextColor:[UIColor grayColor] fontSize:12];
    _originalprice   = originalprice;
    
    UILabel      * num = [XYUIKit labelTextColor:[UIColor grayColor] fontSize:13];
    _num = num ;
    
    UIButton     * btn = [XYUIKit buttonWithBackgroundColor:[UIColor clearColor] titleColor:mainColor title:nil fontSize:13];

    btn.layer.borderWidth = 1;
    btn.layer.borderColor = mainColor.CGColor ;
    _btn = btn ;
    _btn.userInteractionEnabled=NO;
    [btn addTarget:self action:@selector(selectFoundation) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView sd_addSubviews:@[head,pic,tag,title,timeadreess,match,personnum,line,price,originalprice ,num,btn]];
    UIView *vc = self.contentView;
    _head.sd_layout
    .topSpaceToView(vc, 0)
    .leftSpaceToView(vc, 0)
    .rightSpaceToView(vc, 0)
    .heightIs(5);
    
    _pic.sd_layout
    .topSpaceToView(_head, 10)
    .leftSpaceToView(vc, 10)
    .rightSpaceToView(vc, 10)
    .heightIs(kScaleHeight(170));
   
    _tag.sd_layout
    .topSpaceToView(head, 18)
    .rightSpaceToView(vc, 18)
    .heightIs(22.5)
    .widthIs(60);
    
   // [_tag setSingleLineAutoResizeWithMaxWidth:120];
    
    _title.sd_layout
    .topSpaceToView(_pic, 10)
    .leftSpaceToView(vc, 25)
    .rightSpaceToView(vc, 25)
    .autoHeightRatio(0);
    
    _timeadreess.sd_layout
    .topSpaceToView(_title, 4)
    .leftSpaceToView(vc, 25)
    .rightSpaceToView(vc, 25)
    .heightIs(18);
    
    _match.sd_layout
    .leftSpaceToView(vc, 25)
    .heightIs(20)
    .topSpaceToView(_timeadreess, 9);
    [_match setSingleLineAutoResizeWithMaxWidth:180];
    
    _personnum.sd_layout
    .leftSpaceToView(_match, 10)
    .heightIs(20)
    .topSpaceToView(_timeadreess, 9);
    [_personnum setSingleLineAutoResizeWithMaxWidth:180];
    
    _line.sd_layout
    .topSpaceToView(_match, 10)
    .leftSpaceToView(vc, 0)
    .rightSpaceToView(vc, 0)
    .heightIs(0.5);
    
    _price.sd_layout
    .topSpaceToView(_line, 10)
    .leftSpaceToView(vc, 25)
    .heightIs(24);
    [_price setSingleLineAutoResizeWithMaxWidth:100];
    
    _originalprice.sd_layout
    .leftSpaceToView(_price, 10)
    .centerYEqualToView(_price)
    .heightIs(20);
    [_originalprice setSingleLineAutoResizeWithMaxWidth:50];
    
    _btn.sd_layout
    .centerYEqualToView(_price)
    .rightSpaceToView(vc, 15);
    
    // 设置button根据文字size自适应
    [_btn setupAutoSizeWithHorizontalPadding:10 buttonHeight:25];
    
    _num.sd_layout
    .centerYEqualToView(_btn)
    .rightSpaceToView(_btn, 10)
    .heightIs(20);
    [_num setSingleLineAutoResizeWithMaxWidth:100];
    [self setupAutoHeightWithBottomView:_num bottomMargin:10];
    
}
-(void)selectFoundation{
    if(self.cheak){
        self.cheak(_btn);
    }
    
}
-(void)setModel:(youthModel *)model{
    _model = model;
    _pic.image = [UIImage imageNamed:@"cat2.jpeg"];
    _tag.text = @"报名中";
    _title.text = @"这里是赛事标题最多两行，以写成自动适配";
    _timeadreess.text = @"2017-05-28至2017-05-29|上海体育馆";
    _match.text =@" U16 ";
    _personnum.text = @" 11人 ";
    _price.text  = @"¥299.0";
    //_originalprice.text = @"¥666.0";
    [_btn setTitle:@"我要报名" forState:UIControlStateNormal];
    _num.text = @"还剩6个名额";
    
}
- (void)setDic:(NSMutableDictionary *)dic{
    _dic =dic;
    matchleftcellModel *model = [matchleftcellModel yy_modelWithDictionary:dic];
   
    [_pic sd_setImageWithURL: [NSURL URLWithString:model.cover] placeholderImage:nil];
    _tag.text = model.status;
    _title.text = model.name;   //@"这里是赛事标题最多两行，以写成自动适配";
    _timeadreess.text =  [NSString stringWithFormat:@"%@至%@|%@",model.start_time,model.end_time,model.address];  //@"2017-05-28至2017-05-29|上海体育馆";
    _match.text = [NSString stringWithFormat:@" %@ ",model.level];//@" U16 ";
    _personnum.text = [NSString stringWithFormat:@" %@ ",model.type];//@" 11人 ";
    _price.text  =[NSString stringWithFormat:@"¥%@",model.sell_price];
    //_originalprice.text = @"¥666.0";
    [_btn setTitle:@"我要报名" forState:UIControlStateNormal];
    _num.text = [NSString   stringWithFormat:@"还剩%@个名额",model.surplus] ;
    if([model.status isEqualToString:@"报名中"]){
        _tag.backgroundColor = mainColor ;
    }else if([model.status isEqualToString:@"进行中"]){
         _tag.backgroundColor = KRgb(0.35, 0.78, 0.98) ;
    }else{
        _tag.backgroundColor = RGBColor(204, 204, 204) ;
    }
   if(![model.status isEqualToString:@"报名中"]){
       _num.hidden=YES;
       _price.hidden=YES;
       [_btn setTitle:@"查看详情" forState:UIControlStateNormal];
       _btn.layer.borderColor =KGrayColor.CGColor ;
       [_btn setTitleColor:KGrayColor forState:UIControlStateNormal];

   }
//    if ([model.status intValue]==1){
//        _tag.text =@"报名中";
//        _tag.backgroundColor = mainColor ;
//
//    }else {
//         _tag.backgroundColor = RGBColor(204, 204, 204) ;
//        
//        if([model.status intValue]==2){
//        _tag.text =@"进行中";
//        _tag.backgroundColor = KRgb(0.35, 0.78, 0.98) ;
//
//    }else if([model.status intValue]==3){
//        _tag.text =@"已结束";
//    }else if([model.status intValue]==4){
//        _tag.text =@"已报满";
//    }else if([model.status intValue]==5){
//        _tag.text =@"已报名";
//    }
//        _num.hidden=YES;
//        _price.hidden=YES;
//        [_btn setTitle:@"查看详情" forState:UIControlStateNormal];
//        _btn.layer.borderColor =KGrayColor.CGColor ;
//        [_btn setTitleColor:KGrayColor forState:UIControlStateNormal];
//    }
}
@end
