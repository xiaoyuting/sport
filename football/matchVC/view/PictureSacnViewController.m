//
//  PictureSacnViewController.m
//  Nursery
//
//  Created by chenp on 16/10/19.
//  Copyright © 2016年 chenp. All rights reserved.
//

#import "PictureSacnViewController.h"

#import "PicScrollView.h"


#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

@interface PictureSacnViewController ()<UIScrollViewDelegate>
{
    UIScrollView *mainScrollView;
    int currenPage;
    UILabel *numLabel;
}

@end

@implementation PictureSacnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    currenPage=self.currenpage;
    
    [self initMainScrollView];
    
    [self initTopView];
    
    [self initSubScrollView];
}

//头部
-(void)initTopView
{
    numLabel=[[UILabel alloc] initWithFrame:CGRectMake(screen_width-120, 20+4.5, 100, 21)];
    numLabel.text=[NSString stringWithFormat:@"%d/%ld",currenPage,self.picArray.count];
    numLabel.textColor=[UIColor whiteColor];
    numLabel.font=[UIFont systemFontOfSize:15];
    numLabel.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:numLabel];
}

-(void)initMainScrollView
{
    mainScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    mainScrollView.showsVerticalScrollIndicator=NO;
    mainScrollView.showsHorizontalScrollIndicator=NO;
    mainScrollView.bounces=NO;
    mainScrollView.delegate=self;
    mainScrollView.pagingEnabled=YES;
    mainScrollView.contentSize=CGSizeMake(screen_width*self.picArray.count, screen_height-60);
    [self.view addSubview:mainScrollView];
}


-(void)initSubScrollView
{
    for(int i=0;i<self.picArray.count;i++){
        PicScrollView *picscrollView=[[PicScrollView alloc] initWithFrame:CGRectMake(screen_width*i, 0, screen_width, mainScrollView.frame.size.height)];
        picscrollView.tag=10+i;
        picscrollView.picDic=[NSMutableDictionary dictionaryWithDictionary:self.picArray[i]];
        [mainScrollView addSubview:picscrollView];
        [picscrollView initImageView];
        
        picscrollView.tapBlock=^(){
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
        //长按保存
        picscrollView.longBlock=^(){
            
        };
        
        
        //自行添加label显示文字，这里不处理
        
    }
    
    [mainScrollView scrollRectToVisible:CGRectMake(screen_width*(currenPage-1), 60, screen_width, screen_height-60) animated:YES];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point=scrollView.contentOffset;
    if(currenPage==point.x/screen_width){//左滑
        PicScrollView *picscrollView =(PicScrollView *)[mainScrollView viewWithTag:currenPage-1+10];
        [picscrollView initImageView];
        [picscrollView initImageView];//暂时还不清楚为什么要执行两次才不出错
    }else if (currenPage-2==point.x/screen_width){//右滑
        PicScrollView *picscrollView =(PicScrollView *)[mainScrollView viewWithTag:currenPage-1+10];
        [picscrollView initImageView];
        [picscrollView initImageView];
    }
    
    currenPage=point.x/screen_width+1;
    numLabel.text=[NSString stringWithFormat:@"%d/%ld",currenPage,self.picArray.count];
}

// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    if(error != NULL){
        NSLog(@"保存失败");
    }else{
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
