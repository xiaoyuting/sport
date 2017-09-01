//
//  sampleVideoCell.m
//  football
//
//  Created by 雨停 on 2017/7/26.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "sampleVideoCell.h"
#import "SDAutoLayout.h"
#import "matchViewModel.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation sampleVideoCell
{
    UIButton     * _pic;
    UILabel      * _title;
    UILabel      * _timer;
    //UIImageView  * _line;
    UILabel      * _num;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         UIButton *pic = [UIButton new];
        
        
        _pic = pic;
        UILabel * title  = [XYUIKit labelTextColor:[UIColor blackColor] fontSize:17 ];
        _title = title;
        
        
        UILabel * timer  = [XYUIKit labelTextColor:[UIColor grayColor] fontSize:13];
        
        _timer = timer  ;
        // UIImageView *line = [[UIImageView alloc]init];
        //line.backgroundColor = [UIColor grayColor];
        //_line = line;
        UILabel * num = [XYUIKit labelTextColor:[UIColor grayColor] fontSize:13];
        num.textAlignment  = NSTextAlignmentRight;
        _num = num;
         [self.contentView sd_addSubviews:@[pic, title, timer ,num]];
        
        
        
        _pic.sd_layout
        .widthIs(117)
        .heightIs(77)
        .topSpaceToView(self.contentView, 16)
        .leftSpaceToView(self.contentView, 16);
        
        _title.sd_layout
        .topEqualToView(_pic)
        .leftSpaceToView(_pic, 16)
        .rightSpaceToView(self.contentView, 16)
        //.heightRatioToView(_pic, 0.4);
        .autoHeightRatio(0);
        
        _timer.sd_layout
        .bottomEqualToView(_pic)
        .leftSpaceToView(_pic, 16)
        .heightIs(18);
        [_timer setSingleLineAutoResizeWithMaxWidth:100];
        _num.sd_layout
        .rightSpaceToView(self.contentView, 16)
        .heightIs(18)
        .bottomEqualToView(_pic)
        ;
        [_num setSingleLineAutoResizeWithMaxWidth:100];
        
        
        
        
        
        
        //***********************高度自适应cell设置步骤************************
        //[self setupAutoHeightWithBottomViewsArray:@[ _pic, _title, _timer ,_num] bottomMargin:0];
        // [self setupAutoHeightWithBottomView:_view4 bottomMargin:10];
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(matchViewModel *)model{
    _model  = model;
    _title.text =model.name;
    NSURL *videoURl = [NSURL fileURLWithPath:model.fileurl];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURl options:nil];
    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generate.appliesPreferredTrackTransform = YES;
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
    UIImage *img = [[UIImage alloc] initWithCGImage:imgRef];
    NSLog(@"%@",img);
    //[videoFrame setImage:img];
//    MPMoviePlayerController *iosMPMovie = [[MPMoviePlayerController alloc]initWithContentURL:imgUrl(model.fileurl)];
//    iosMPMovie.shouldAutoplay = NO;
//    UIImage *thumbnail = [iosMPMovie thumbnailImageAtTime:0.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
   // [_pic setBackgroundImage:img forState:UIControlStateNormal];
    
    [_pic setBackgroundImage:Img(@"logoNO") forState:UIControlStateNormal];
    _pic.userInteractionEnabled=NO;
    [_pic setImage:Img(@"playV") forState:UIControlStateNormal];
    _pic.imageEdgeInsets = UIEdgeInsetsMake(18, 38, 18, 38);
   
   // _timer.text = @"2017-05-28";
  //  _num.text  = @"阅读:983";
}

-(void)setModelVideo:(NSString *)modelVideo{
    _modelVideo =modelVideo;
    _title.text =@"wqewqewqew";
    
    [_pic setImage:Img(@"playV") forState:UIControlStateNormal];
    _pic.imageEdgeInsets = UIEdgeInsetsMake(18, 38, 18, 38);
    
     _timer.text = @"2017-05-28";
      _num.text  = @"阅读:983";

}

@end
