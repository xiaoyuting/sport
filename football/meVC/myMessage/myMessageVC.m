//
//  myMessageVC.m
//  football
//
//  Created by 雨停 on 2017/8/8.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "myMessageVC.h"
#import "myMessageCell.h"
#import "SDAutoLayout.h"
@interface myMessageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView   * tab;
@end

@implementation myMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
    [self showPlaceholderViewWithImage:Img(@"mes_no") message:@"没有消息" buttonTitle:nil centerOffsetY:0 onSuperView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setSubview{
    self.title =@"我的消息";
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.tab  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    self.tab.delegate =self;
    self.tab.dataSource =self;
    self.tab.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.tab registerClass:[myMessageCell class] forCellReuseIdentifier:NSStringFromClass([myMessageCell class])];
    [self.view addSubview:self.tab];
}
-(void)leftItemClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  0;
   }



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myMessageCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([myMessageCell class])];
    cell.model =nil;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    return [tableView cellHeightForIndexPath:indexPath model:@"wqewqewq" keyPath:@"model" cellClass:[myMessageCell class] contentViewWidth:[self cellContentViewWith]];
}


@end
