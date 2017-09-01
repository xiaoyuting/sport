//
//  PicScrollView.h
//  Nursery
//
//  Created by chenp on 16/10/19.
//  Copyright © 2016年 chenp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicScrollView : UIScrollView<UIScrollViewDelegate>



@property (nonatomic,strong)NSMutableDictionary *picDic;//@"islocal" @"picString"

-(void)initImageView;

@property (nonatomic,copy)void (^tapBlock)() ;

@property (nonatomic,copy)void (^longBlock)() ;

@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,strong)UIImage *initialImage;

@end
