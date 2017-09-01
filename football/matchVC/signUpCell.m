//
//  signUpCell.m
//  football
//
//  Created by 雨停 on 2017/7/25.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "signUpCell.h"
#import "SDAutoLayout.h"
@implementation signUpCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setSubview];
    }
    return self;
}
-(void)setSubview{
    UIView * vc =self.contentView;
    self.title = [[UILabel alloc]init];
    self.detile= [[UILabel alloc]init];
    self.detile.textColor = [UIColor lightGrayColor];
    self.imgR =  [[UIImageView alloc]init];
    self.imgR.image =Img(@"Arrow");
    self.price =  [XYUIKit labelWithTextColor:KmainRed numberOfLines:0 text:nil fontSize:13];
    self.countprice = [XYUIKit labelWithTextColor:KmainRed numberOfLines:0 text:nil fontSize:13];
    
    [vc sd_addSubviews:@[self.title,self.price,self.imgR,self.detile,self.countprice]];
    self.title.sd_layout
    .leftSpaceToView(vc, 16)
    .topSpaceToView(vc, 10)
    .heightIs(24);
    [self.title setSingleLineAutoResizeWithMaxWidth:180];
    
    self.price.sd_layout
    .leftSpaceToView(self.title, 11)
    .centerYEqualToView(self.title)
    .heightIs(18);
    [self.price setSingleLineAutoResizeWithMaxWidth:80];
    
    self.imgR.sd_layout
    .rightSpaceToView(vc, 16)
    .heightIs(13)
    .widthIs(8)
    .centerYEqualToView(self.title);
    
    self.detile.sd_layout
    .rightSpaceToView(self.imgR, 12)
    .centerYEqualToView(self.title)
    .leftSpaceToView(self.price, 5)
    .heightIs(13);
    
    //[self.detile setSingleLineAutoResizeWithMaxWidth:180];
    
    self.countprice.sd_layout
    .rightSpaceToView(vc, 23)
    .centerYEqualToView(self.title);
    [self.countprice setSingleLineAutoResizeWithMaxWidth:180];
    //[vc  setupAutoHeightWithBottomView:self.title bottomMargin:10];

}
@end
