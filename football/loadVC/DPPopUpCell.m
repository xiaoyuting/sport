//
//  DPPopUpCell.m
//  KSDatePickerDemo
//
//  Created by IOS on 16/7/22.
//  Copyright © 2016年 孔. All rights reserved.
//

#import "DPPopUpCell.h"
#import "UIColor+DPUIColor.h"
static const float RealSrceenHight =  667.0;
static const float RealSrceenWidth =  375.0;
#define AdaptationH(x) x/RealSrceenHight*[[UIScreen mainScreen]bounds].size.height
#define AdaptationW(x) x/RealSrceenWidth*[[UIScreen mainScreen]bounds].size.width
#define AdapationLabelFont(n) n*([[UIScreen mainScreen]bounds].size.width/375.0f)
@implementation DPPopUpCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //self.backgroundColor =[UIColor orangeColor];
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(3))];
        lineView.backgroundColor=mainColor  ;
        [self.contentView addSubview:lineView];
        self.myTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,AdaptationH(3) , AdaptationW(270), AdaptationH(42))];
        self.myTitleLabel.textColor=mainColor;
        //self.myTitleLabel.backgroundColor=mainColor;
        self.myTitleLabel.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:self.myTitleLabel];
        
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
