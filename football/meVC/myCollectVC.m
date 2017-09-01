//
//  myCollectVC.m
//  football
//
//  Created by 雨停 on 2017/7/14.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "myCollectVC.h"
#import "ABSSegmentCate.h"
#import "youthCell.h"
#import "SDAutoLayout.h"
@interface myCollectVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property  (nonatomic,strong)ABSSegmentCate  * segmentedControl;
@property  (strong, nonatomic) UIScrollView  * contentScrView;
@property  (strong ,nonatomic) UIView        * videBottom;
@property  (nonatomic,strong)  UITableView    * tabview;

@end

@implementation myCollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setSubview{
    self.title =@"我的收藏";
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    [self setNavRightItemTitle:@"编辑" andImage:nil];
    [self setLine];
    
    NSArray * dataArray = @[@"青训课程",@"在线教案",@"比赛",@"资讯",@"教练"];
    self.segmentedControl = [self setSegframe:CGRectMake(0, 0,KScreenWidth, 44) titleArr:dataArray space:0];
    [self.view addSubview: self.segmentedControl];
    
    CGFloat const kScrollViewHeight =KScreenHeight -44-64;
    
    UIButton  * btn = [XYUIKit buttonWithBackgroundColor:mainColor titleColor:KWhiteColor title:@"全选" fontSize:17];
    btn.frame =CGRectMake(0, kScrollViewHeight, 0.5*KScreenWidth, 44);
    btn.tag = 1;
    [btn addTarget:self action:@selector(getChoice:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    UIButton  * btnr = [XYUIKit buttonWithBackgroundColor:KRedColor titleColor:KWhiteColor title:@"删除" fontSize:17];
    btnr.frame =CGRectMake( 0.5*KScreenWidth, kScrollViewHeight, 0.5*KScreenWidth, 44);
    btnr.tag = 2;
    [btnr addTarget:self action:@selector(getChoice:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnr];
    self.contentScrView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, KScreenWidth, kScrollViewHeight)];
    [self.view addSubview: self.contentScrView];
    self.contentScrView.contentSize = CGSizeMake(KScreenWidth * dataArray.count, kScrollViewHeight);
    self.contentScrView.delegate = self;
    self.contentScrView.pagingEnabled = YES;
    
    
    for (int i = 0; i < dataArray.count; i ++) {
        CGFloat left = i * KScreenWidth;
        UITableView * tab = [[UITableView alloc]initWithFrame:CGRectMake(left, 0, KScreenWidth, kScrollViewHeight) style:UITableViewStylePlain];
        tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        // [self showPlaceholderViewWithImage:Img(@"collect_no") message:@"没有记录" buttonTitle:nil centerOffsetY:0 onSuperView:tab];
        
        tab.tag = i;
        
        [self.contentScrView addSubview:tab];
        if(i==0){
            tab.delegate   = self;
            tab.dataSource = self;
            [tab registerClass:[youthCell class ] forCellReuseIdentifier:NSStringFromClass([youthCell  class])];
            tab.allowsMultipleSelectionDuringEditing = YES;
            
            self.tabview    = tab;
            // }else{
            // [tab registerClass:[videoCell class ] forCellReuseIdentifier:NSStringFromClass([videoCell  class])];
            
            
        }
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Class currentClass = [youthCell class];
    youthCell * cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.youthmodelleft = nil;
    //[cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    int index = indexPath.row % 5;
    //    NSString *str = _textArray[index];
    
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    return [tableView cellHeightForIndexPath:indexPath model:@"" keyPath:@"youthmodelleft" cellClass:[youthCell class] contentViewWidth:[self cellContentViewWith]];
}
-(void)rightItemClick:(id)sender{
    
    if (self.tabview.editing) {
        
        [self setNavRightItemTitle:@"编辑" andImage:nil];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            CGFloat const kScrollViewHeight =KScreenHeight -44-64;
            self.contentScrView .frame  =CGRectMake(0, 44, KScreenWidth, kScrollViewHeight);
            CGRect frame = self.tabview.frame;
            frame.size.height =kScrollViewHeight;
            self.tabview.frame=frame;
            // self.contentScrView.contentSize.height = CGSizeMake(KScreenWidth * dataArray.count, kScrollViewHeight);
        }];
        
    } else {
        
        [self setNavRightItemTitle:@"取消" andImage:nil];
        
        CGFloat const kScrollViewHeight =KScreenHeight -44-64-50;
        self.contentScrView .frame  =CGRectMake(0, 44, KScreenWidth, kScrollViewHeight);
        CGRect frame = self.tabview.frame;
        frame.size.height =kScrollViewHeight;
        self.tabview.frame=frame;
        [UIView animateWithDuration:0.5 animations:^{
            
            
            
        }];
    }
    [self.tabview setEditing:!self.tabview.editing animated:YES];
    
}

-(void)leftItemClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)getChoice:(UIButton *)sender{
    if(sender.tag==1){
        for (int row=0; row<10; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [self.tabview selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }else{
        NSMutableArray *deleteArray = [NSMutableArray array];
        for (NSIndexPath *indexPath in self.tabview .indexPathsForSelectedRows) {
            //[deleteArray addObject:self.viewModel.dataArray[indexPath.row]];
        }
        
        //NSMutableArray *currentArray = self.viewModel.dataArray;
        // [currentArray removeObjectsInArray:deleteArray];
        // self.viewModel.dataArray = currentArray;
        
        [self.tabview deleteRowsAtIndexPaths:self.tabview.indexPathsForSelectedRows withRowAnimation:UITableViewRowAnimationLeft];//删除对应数据的cell
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            
            
            [self.tabview reloadData];
        });
        
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // [self.dateArray removeObjectAtIndex:indexPath.row];
        [self.tabview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}
@end

