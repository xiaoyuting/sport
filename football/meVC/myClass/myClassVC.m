//
//  myClassVC.m
//  football
//
//  Created by 雨停 on 2017/7/14.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "myClassVC.h"
#import "ABSSegmentCate.h"
#import "sampleVideoCell.h"
#import "myClassCell.h"
@interface myClassVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)ABSSegmentCate  * seg;
@property (strong, nonatomic) UIScrollView *contentScrView;
@property (nonatomic,strong)UITableView    * leftTab;
@property (nonatomic,strong)UITableView    * rightTab;
@end

@implementation myClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
}
-(void)setSubview{
    self.title =@"我的课程";
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    [self setLine];
    NSArray * dataArray = @[@"青训课程",@"在线教案"];
    self.seg = [self setSegframe:CGRectMake(80, 0, KScreenWidth, 44) titleArr:dataArray space:160];
    [self.view addSubview:self.seg];
    
    CGFloat const kScrollViewHeight =KScreenHeight -44-64;
    self.contentScrView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, KScreenWidth, kScrollViewHeight)];
    [self.view addSubview: self.contentScrView];
    self.contentScrView.contentSize = CGSizeMake(KScreenWidth * dataArray.count, kScrollViewHeight);
    self.contentScrView.delegate = self;
    self.contentScrView.pagingEnabled = YES;
    for (int i = 0; i < dataArray.count; i ++) {
        CGFloat left = i * KScreenWidth;
        
        UITableView * tab = [[UITableView alloc]initWithFrame:CGRectMake(left, 0, KScreenWidth, kScrollViewHeight) style:UITableViewStylePlain];
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        tab.tag= i;
        tab.delegate = self;
       tab.dataSource = self;
        [self showPlaceholderViewWithImage:Img(@"myclass_no") message:@"没有记录" buttonTitle:nil centerOffsetY:0 onSuperView:tab];
        [self.contentScrView addSubview:tab];
        if(i==0){
            [tab registerNib:[UINib nibWithNibName:@"myClassCell" bundle:nil] forCellReuseIdentifier:@"myclasscell"];
            self.leftTab = tab;
        }else{
           [tab registerClass:[sampleVideoCell class ] forCellReuseIdentifier:NSStringFromClass([sampleVideoCell   class])];
            
            self.rightTab = tab;
        }
    }
    
    [_seg  segmentedControlSelectedWithBlock:^(ABSSegmentCate *segmentedControl, NSInteger selectedIndex) {
        NSLog(@"selectedIndex : %zd", selectedIndex);
        
        [self.contentScrView setContentOffset:CGPointMake(selectedIndex *KScreenWidth, 0) animated:YES];
    }];

}
#pragma mark - scrollView protocol methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if([scrollView isEqual:self.contentScrView]){
        NSInteger const kPageIndex = scrollView.contentOffset.x / KScreenWidth;
        // [self.segmentedControl segmentedControlSetSelectedIndexWithSelectedBlock:kPageIndex];
        // 重设选中位置
        [self.seg segmentedControlSetSelectedIndex:kPageIndex];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([tableView isEqual:self.leftTab]){
        return 0;
    }else{
        return 0;}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([tableView isEqual:self.leftTab]){
        
        myClassCell * cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:@"myclasscell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model =nil;
        return cell;
        
    }else {
   
        Class currentClass = [sampleVideoCell  class];
        sampleVideoCell  * cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.modelVideo =@"";
        return cell;
        
    }
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    //    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.leftTab){
        return 594;
    }
    return 100;
    
   }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)leftItemClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
