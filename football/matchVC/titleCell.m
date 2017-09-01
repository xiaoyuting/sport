//
//  titleCell.m
//  football
//
//  Created by 雨停 on 2017/7/31.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "titleCell.h"

@implementation titleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.title   = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.contentView.frame.size.width-20, self.contentView.frame.size.height)];
        self.title.font =FontSize(13);
        [self.contentView addSubview:self.title];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
