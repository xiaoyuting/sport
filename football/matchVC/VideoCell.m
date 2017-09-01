//
//  VideoCell.m
//  WMVideoPlayer
//
//  Created by zhengwenming on 16/1/17.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "VideoCell.h"

#import "UIImageView+WebCache.h"
#import "rowsViewModel.h"
@implementation VideoCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setModel:(rowsViewModel *)model{
    _model =model;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel.text = model.activityName;
    self.descriptionLabel.text =  [NSString stringWithFormat:@"%@|%@",model.startTime,model.descrip];
    [self.backgroundIV sd_setImageWithURL:[NSURL URLWithString:model.coverImgUrl] placeholderImage:[UIImage imageNamed:@"logo"]];
     self.tagImg .image  = Img(@"playing");
    

}
- (IBAction)shearBtn:(UIButton *)sender {
    if(self.shearBlock){
        self.shearBlock(sender);
    }
}
@end
