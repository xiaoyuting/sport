//
//  myVipCell.m
//  football
//
//  Created by 雨停 on 2017/7/18.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "myVipCell.h"

@implementation myVipCell{
    UIImageView  * _icon;
    UILabel      * _title;
    UILabel      * _detailTitle;
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
        _icon  = [[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 36, 36)];
        _icon . image = Img (@"myvip");
        [self . contentView addSubview:_icon];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+9, 9.5, 200, 24)];
        _title.text = @"在线青训教程全免费";
        [self . contentView addSubview:_title];
        
        _detailTitle = [[UILabel alloc]initWithFrame:CGRectMake(_icon.right+9, _title.bottom, 200, 18)];
        _detailTitle.text = @"手机端无限视屏教程";
        _detailTitle.font = FontSize(13);
        [self . contentView addSubview:_detailTitle];

        self.layer.borderWidth= 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
    }
    
    return self;
}
@end
