//
//  InfoSetCell.m
//  football
//
//  Created by 雨停 on 2017/7/13.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "InfoSetCell.h"

@implementation InfoSetCell

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
    
    self.title = [[UILabel alloc]init];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 24));
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(16);
        make.centerY.equalTo(self.contentView);
    }];
    self.img = [[UIImageView alloc]init];
    self.img.image =Img(@"Arrow");
    [self.contentView addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(8, 13));
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-16);
        make.centerY.equalTo(self.contentView);
    }];
   self. detile = [[UILabel alloc]init];
    self.detile.textAlignment   = NSTextAlignmentRight;
    self.detile.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.detile];
    
    [self.detile mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(KScreenWidth-12-20-116, 24));
        make.right.mas_equalTo(self.img.mas_right).with.offset(-12);
        make.centerY.equalTo(self.contentView);
    }];
}

//-(void)setModel:(youthModel *)model{
//    _model = model;
//    title .text  =model.title;
//    detile.text = model.detaile;
//    
//}
@end
