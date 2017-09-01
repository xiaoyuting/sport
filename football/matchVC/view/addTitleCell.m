//
//  addTitleCell.m
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "addTitleCell.h"
#import "SDAutoLayout.h"
@implementation addTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setsubview];
    }
    return self;
}
- (void)setsubview{
    self.name = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KBlackColor textAlignment:NSTextAlignmentLeft numberOfLines:0 text:nil fontSize:17];
    self.detaile = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KGrayColor textAlignment:NSTextAlignmentRight numberOfLines:0 text:nil fontSize:17];
    self.line  = [[UIImageView alloc]init];
    self.line.image =Img(@"line2");
    [self.contentView sd_addSubviews:@[self.name,self.detaile,self.line]];
    self.name.sd_layout
    .leftSpaceToView(self.contentView, 16)
    .centerYEqualToView(self.contentView)
    .heightIs(24);
    
    [self.name setSingleLineAutoResizeWithMaxWidth:150];
    
    self.detaile.sd_layout
    .rightSpaceToView(self.contentView, 36)
    .leftSpaceToView(self.contentView, 5)
    .heightIs(24)
    .centerYEqualToView(self.contentView);
    self.line.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .bottomSpaceToView(self.contentView,0)
    .heightIs(1);
}
@end
