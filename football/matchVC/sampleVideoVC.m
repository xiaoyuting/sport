//
//  sampleVideoVC.m
//  football
//
//  Created by 雨停 on 2017/7/25.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "sampleVideoVC.h"
#import "sampleCell.h"
#import "SDAutoLayout.h"
@interface sampleVideoVC ()<UITableViewDelegate,UITableViewDataSource>
@property  (nonatomic,strong)UITableView * tab;
@property (nonatomic ,assign)NSIndexPath *index;
@end

@implementation sampleVideoVC

- (void)viewDidLoad {
     self.index  =[NSIndexPath indexPathForRow:0 inSection:1];
    [super viewDidLoad];
    [self setSubview];
   
}
-(void)setSubview{
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self setNavLeftItemTitle:@"返回" andImage:nil];
     self.title =@"购买定制视屏";
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenHeight, KScreenHeight) style:UITableViewStyleGrouped];
    self.tab.delegate   = self;
    self.tab.dataSource = self;
    [self.tab registerClass:[sampleCell class] forCellReuseIdentifier:NSStringFromClass([sampleCell class])];
    [self.view addSubview:self.tab];
    self.tab.tableHeaderView =[self headView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section==0){
        return 2;
    }else if(section==1){
          return 1;
    }
    return 0;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    sampleCell *cell =nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([sampleCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title.text =@"定制视屏套餐";
    cell.detaile.text =@"定制视屏说明";
    cell.pricedetaile.text =@"¥199";
    if(indexPath ==self.index){
        cell.imgcheak.image = Img(@"cheak");
    }else{
        cell.imgcheak.image = Img(@"nocheak");
    }
    return  cell;
    
}


-(void)leftItemClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(UIView *)headView{
    UIView * head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, kScaleHeight(211))];
   
    UIButton * btn = [[UIButton alloc]initWithFrame:head.frame];
    [btn setImage:Img(@"playV") forState:UIControlStateNormal];
    [btn setBackgroundImage:Img(@"cat2.jpeg") forState:UIControlStateNormal];
    [head addSubview:btn];
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(16, 16, 65, 22.5)];
    img.image =Img(@"sample");
    [head addSubview:img];
    return head;
}
/*-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    sampleCell*cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.imgcheak.image =Img(@"cheak");
  
    }
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    sampleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.imgcheak.image = Img(@"nocheak");
    }*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.index  =indexPath;
    [self.tab reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}
@end
