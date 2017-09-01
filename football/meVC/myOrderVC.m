//
//  myOrderVC.m
//  football
//
//  Created by 雨停 on 2017/7/14.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "myOrderVC.h"
#import "ABSSegmentCate.h"
#import "myOrderCell.h"
@interface myOrderVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property  (nonatomic,strong)ABSSegmentCate  * segmentedControl;
@property  (strong, nonatomic) UIScrollView  * contentScrView;

@end

@implementation myOrderVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
}

-(void)setSubview{
    self.title =@"我的订单";
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    NSArray * dataArray = @[@"全部",@"待付款",@"已完成"];
    [self setLine];
    self.segmentedControl = [self setSegframe:CGRectMake(0, 0, KScreenWidth, 44) titleArr:dataArray space:0];
    
    [self.view addSubview: self.segmentedControl];
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
        [self showPlaceholderViewWithImage:nil message:@"没有记录" buttonTitle:nil centerOffsetY:0 onSuperView:tab];
         tab.delegate   = self;
         tab.dataSource = self;
        tab.tag = i;
        [self.contentScrView addSubview:tab];
      
            [tab registerNib:[UINib nibWithNibName:@"myOrderCell" bundle:nil] forCellReuseIdentifier:@"order"];
        
    }
    
    [_segmentedControl  segmentedControlSelectedWithBlock:^(ABSSegmentCate *segmentedControl, NSInteger selectedIndex) {
        NSLog(@"selectedIndex : %zd", selectedIndex);
        
        [self.contentScrView setContentOffset:CGPointMake(selectedIndex * KScreenWidth, 0) animated:YES];
    }];
    
}
#pragma mark - scrollView protocol methods
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if([scrollView isEqual:self.contentScrView]){
        NSInteger const kPageIndex = scrollView.contentOffset.x / KScreenWidth;
        [self.segmentedControl segmentedControlSetSelectedIndexWithSelectedBlock:kPageIndex];
        // 重设选中位置
        [self.segmentedControl segmentedControlSetSelectedIndex:kPageIndex];}
}

-(void)leftItemClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 148;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myOrderCell * cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"order"];
    return cell;
}


@end
