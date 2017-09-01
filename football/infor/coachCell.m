//
//  coachCell.m
//  football
//
//  Created by 雨停 on 2017/6/30.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "coachCell.h"
#import "XYUIKit.h"
#import "Header.h"
#import "coachesModel.h"
@implementation coachCell{
    UIImageView   * photo;
    UILabel       * title;
    UILabel       * detaile;
    UIImageView   * tag;
    UIImageView   * line;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setSubView];
    }
    return  self;
}
-(void)setSubView{
    photo  = [[UIImageView alloc]initWithFrame:CGRectMake(15, 16, 71, 71)];
    [self.contentView addSubview:photo];
    photo.layer.cornerRadius  = 35.5;
    photo.layer.masksToBounds = YES;
     photo.image = [UIImage imageNamed:@"coach"];
    title  =[XYUIKit labelTextColor:[UIColor blackColor] fontSize:17];
    title.frame = CGRectMake(106, 24,KScreenWidth-106-44, 24);
    [self.contentView addSubview:title];
    
    detaile = [XYUIKit labelTextColor:[UIColor grayColor] fontSize:13];
    detaile.frame = CGRectMake(106, 51,KScreenWidth-106-44, 18);
    [self.contentView addSubview:detaile];
    tag = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-44, 42, 20, 20)];
    [self.contentView addSubview:tag];
    line =[[UIImageView alloc]initWithFrame:CGRectMake(0, 102, KScreenWidth, 1)];
    line.image   = Img(@"line2");
    [self.contentView addSubview:line];
    
   
}
-(void)setModel:(coachesModel *)model{
    _model = model;
    
    [photo sd_setImageWithURL:imgUrl(model.header_url) placeholderImage:nil];
    title.text = model.name;
    detaile.text = model.team_name;
    tag.image = Img(@"collect");
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
