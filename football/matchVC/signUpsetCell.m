//
//  signUpsetCell.m
//  football
//
//  Created by 雨停 on 2017/7/25.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "signUpsetCell.h"
#import "SDAutoLayout.h"
@implementation signUpsetCell

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
        [self setSubview ];
    }
    
    return self;
}

-(void)setSubview{
    
    UIView * vc =self.contentView;
    self.title = [[UILabel alloc]init];
    self.detile= [[UILabel alloc]init];
    self.detile.textColor = [UIColor lightGrayColor];
    self.img =  [[UIImageView alloc]init];
   // self.img.image =Img(@"Arrow");
    self.img.backgroundColor =mainColor;
    
    [vc sd_addSubviews:@[self.title,self.img,self.detile]];
    self.title.sd_layout
    .leftSpaceToView(vc, 16)
    .topSpaceToView(vc, 10)
    .heightIs(24);
    [self.title setSingleLineAutoResizeWithMaxWidth:180];
    
    
    self.img.sd_layout
    .rightSpaceToView(vc, 16)
    .heightIs(18)
    .widthIs (18)
    .centerYEqualToView(self.title);
    
    self.detile.sd_layout
    .rightSpaceToView(self.img, 12)
    .centerYEqualToView(self.title);
    [self.detile setSingleLineAutoResizeWithMaxWidth:180];
    
    }
-(void)setDic:(NSDictionary *)dic{
    _dic= dic;
  
    self.title.text =[_dic objectForKey:@"title"];
    self.detile.text = [_dic objectForKey:@"detaile"];
}
@end
