//
//  sampleCell.m
//  football
//
//  Created by 雨停 on 2017/7/25.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "sampleCell.h"
#import "SDAutoLayout.h"
@implementation sampleCell

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
    UIView *vc  = self.contentView;
    self.title = [XYUIKit labelTextColor:KBlackColor fontSize:17];
    self.detaile  = [XYUIKit labelTextColor:KGrayColor fontSize:13];
    self.imgcheak = [[UIImageView alloc]init];
    self.imgcheak.image = Img(@"nocheak");
    self.imgcheak.frame =CGRectMake(KScreenWidth-39.5, 20.5, 25, 25);
    [vc addSubview:self.imgcheak];
    self.pricedetaile = [XYUIKit labelTextColor:KmainRed fontSize:12];
    
    self.pricedetaile.font =Font(@"PingFangSC-Regular", 12);
    self.pricedetaile.textAlignment =NSTextAlignmentRight;
    self.pricedetaile.frame = CGRectMake(KScreenWidth-137, 23, 80, 18);
    [vc sd_addSubviews:@[self.title,self.detaile]];
    self.title.sd_layout
    .leftSpaceToView(vc, 16)
    .topSpaceToView(vc, 10)
    .heightIs(24);
    
    [self.title setSingleLineAutoResizeWithMaxWidth:180];
    
    self.detaile.sd_layout
    .leftSpaceToView(vc, 16)
    .topSpaceToView(self.title, 0)
    .heightIs(18);
    
    [self.detaile setSingleLineAutoResizeWithMaxWidth:180];
    
    
}
@end
