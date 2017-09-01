//
//  meCell.m
//  football
//
//  Created by 雨停 on 2017/6/29.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "meCell.h"
#import "SDAutoLayout.h"
#import "XYUIKit.h"
@implementation meCell{
    UIImageView   * _icon;
    UILabel       * _title;
    UILabel       * _detaile;
    UIImageView   * _pomort;

}
@synthesize _line;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
    [self setSubView];
    }
    return self;
}
-(void)setSubView{
    UIImageView  * icon = [[UIImageView alloc]init];
   // icon.layer.cornerRadius =35.5;
   // _icon.clipsToBounds=YES;
   // _icon.contentMode = UIViewContentModeScaleAspectFit;
    _icon  = icon;
    
    UILabel      * title = [XYUIKit labelTextColor:[UIColor blackColor] fontSize:16];
    _title  = title;
    
    UILabel      * detaile = [XYUIKit labelWithBackgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentRight numberOfLines:1 text:nil fontSize:13];
    _detaile  = detaile;
    
    UIImageView  * pomort = [[UIImageView alloc]init];
    _pomort  = pomort ;
    _pomort .image = Img(@"Arrow");
    UIImageView  * line = [[UIImageView alloc]init];
    line .backgroundColor = [UIColor colorWithHexString:@"#D8D8D8"];
    _line  = line;
    
    [self.contentView sd_addSubviews:@[icon,title,detaile,pomort,line]];
    UIView * vc = self.contentView;
    _icon.sd_layout
    .topSpaceToView(vc, 7)
    .leftSpaceToView(vc, 20)
    .heightIs(25)
    .widthIs(24);
    
    _title.sd_layout
    .leftSpaceToView(_icon, 14)
    .centerYEqualToView(_icon)
    .heightIs(24)
    .widthIs(100);
    
    _pomort.sd_layout
    .rightSpaceToView(vc, 13)
    .centerYEqualToView(_icon)
    .heightIs(13)
    .widthIs(8);
    
    _detaile.sd_layout
    .rightSpaceToView(_pomort, 10)
    .centerYEqualToView(_icon)
    .heightIs(20)
    .widthIs(180);
    
    _line.sd_layout
    .leftSpaceToView(vc , 60)
    .rightSpaceToView(vc, 0)
    .bottomSpaceToView(vc, 0)
    .heightIs(0.5);
   // [self setupAutoHeightWithBottomView:_line bottomMargin:10];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(youthModel *)model{
    _model = model;
    _icon.image = [UIImage imageNamed:@"cat.jpeg"];
    _title .text   = @"我的课程";
   // _detaile.text  = @"青训课程标题";
    
    
    
    
}
-(void)setDic:(NSDictionary *)dic{
    _dic =dic;
    _icon.image     = [UIImage imageNamed:[dic objectForKey:@"img"]];
    _title .text    = [dic objectForKey:@"title"];
    _detaile .text  = [dic objectForKey:@"detaile"];
}
@end
