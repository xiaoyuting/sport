//
//  PicScrollView.m
//  Nursery
//
//  Created by chenp on 16/10/19.
//  Copyright © 2016年 chenp. All rights reserved.
//

#import "PicScrollView.h"


#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

@implementation PicScrollView



-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame]){
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        self.delegate=self;
        self.backgroundColor=[UIColor blackColor];
        self.minimumZoomScale=1.0;
        self.maximumZoomScale=3.0;
    }
    
    return self;
}

-(void)initImageView
{
    for(UIView *view in self.subviews){
        if([view isKindOfClass:[UIImageView class]]){
            [view removeFromSuperview];
        }
    }
    
    
    _imageView = [[UIImageView alloc]init];
    [self addSubview:_imageView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_imageView addGestureRecognizer:tap];
    
    _imageView.userInteractionEnabled=YES;//使_imageView上的控件有点击事件
    
    
    if([self.picDic[@"islocal"] isEqualToString:@"1"]){
        _imageView.image=self.picDic[@"picString"];
        self.initialImage=_imageView.image;
    }else{
        [_imageView sd_setImageWithURL:[NSURL URLWithString:self.picDic[@"picString"]] placeholderImage:[UIImage imageNamed:@"logoNO"]];
        self.initialImage=_imageView.image;
    }
    
    [self getRectfixMinImageView:_imageView];
    
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction)];
    [_imageView addGestureRecognizer:longPress];
    
}

-(void)tapAction
{
    self.tapBlock();
}

-(void)longPressAction
{
    self.longBlock();
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    [self reloadFrame];
    return _imageView;
}

-(void)reloadFrame{
    CGRect frame = _imageView.frame;
    self.contentSize = frame.size;
    if(_imageView.frame.size.width>=screen_width){
        frame.origin.x = 0;
    }else{
        frame.origin.x = screen_width/2-_imageView.frame.size.width/2;
    }
    
    if(_imageView.frame.size.height>=screen_height){
        frame.origin.y = 0;
    }else{
        frame.origin.y = screen_height/2 - _imageView.frame.size.height/2;
    }
    [UIView animateWithDuration:0.2 animations:^{
        _imageView.frame = frame;
    } completion:nil];
    
}
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    [self reloadFrame];
}


-(void)getRectfixMinImageView:(UIImageView*)imgview
{
    UIImage *img = imgview.image;
    CGFloat imgWidth = img.size.width;
    CGFloat imgHeight = img.size.height;
    CGFloat kScale = img.size.height / img.size.width;
    imgWidth = screen_width;
    imgHeight = imgWidth * kScale;
    if(imgHeight>screen_height){
        imgHeight=screen_height;
        imgWidth=img.size.width/img.size.height*imgHeight;
    }
    
    CGFloat marginY = (screen_height - imgHeight)/2;
    CGFloat marginX=(screen_width-imgWidth)/2;
    
    CGRect frame = CGRectMake(marginX, marginY, imgWidth, imgHeight);
    
    _imageView.frame=frame;
    
    self.contentSize = _imageView.frame.size;
}




@end
