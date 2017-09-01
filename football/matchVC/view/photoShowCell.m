//
//  photoShowCell.m
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "photoShowCell.h"
#import "picModel.h"
@implementation photoShowCell
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setSubview];
    }
    return self;
}
-(void)setSubview{
   self.img = [[UIImageView alloc]
             initWithFrame:self.contentView.frame];
    //self.contentView.layer.borderWidth=0.5;
    self.img.contentMode =UIViewContentModeScaleAspectFill;
    self.img.layer.masksToBounds =YES;
    [self.contentView addSubview:self.img];
    
}

-(void)setModel:(picModel *)model{
    _model=model;
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.fileurl] placeholderImage:Img(@"logoNO")];
}
@end
