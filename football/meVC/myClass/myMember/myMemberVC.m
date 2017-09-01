//
//  myMemberVC.m
//  football
//
//  Created by 雨停 on 2017/7/17.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "myMemberVC.h"
#import "myVipCell.h"
#import "paySelectVC.h"
@interface myMemberVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView  * tab;
@end

@implementation myMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setNavi];
    [self setNaivTitle:@"我的会员"];
    [self.view addSubview:[self headView]];
    [self setSubview];
    [self setBottomView];
    // Do any additional setup after loading the view.
}
-(void)setSubview{
    self.tab = [[UITableView  alloc]initWithFrame:CGRectMake(0, kScaleHeight(227.0)+64, KScreenWidth, KScreenHeight-kScaleHeight(227.0)-64-70) style:UITableViewStylePlain];
    self.tab.delegate   = self;
    self.tab.dataSource = self;
    self.tab.separatorStyle  = UITableViewCellSelectionStyleNone;
    [self.tab registerClass:[myVipCell class] forCellReuseIdentifier:NSStringFromClass([myVipCell class])];
    self.tab.tableHeaderView = [self tabheadView];
    [self.view addSubview: self.tab];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    myVipCell * cell = nil;
    cell= [tableView    dequeueReusableCellWithIdentifier:NSStringFromClass([myVipCell class])];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.】
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden=YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden =NO;
}

-(void)leftFoundation{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIView * )headView{
    UIView * head  = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, kScaleHeight(227.0))];
    
    head.backgroundColor = mainColor;
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(16, 0, KScreenWidth-32, kScaleHeight(227.0)-16)];
    img.image = Img(@"mymebBac");
    [head addSubview:img];
    return head;
}

-(UIView *)tabheadView{
    UIView * tabheadview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 32)];
    
    UILabel * lab =[XYUIKit labelWithBackgroundColor:KClearColor textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft numberOfLines:1 text:@"会员特权" fontSize:13];
    lab.frame = CGRectMake(20, 0, KScreenWidth-20, 32);
    [tabheadview  addSubview:lab];
    return tabheadview ;
}
-(void)setBottomView{
    UILabel   * lab = [XYUIKit labelWithBackgroundColor:KClearColor textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentCenter numberOfLines:1 text:@"" fontSize:13];
    lab.frame = CGRectMake(0, KScreenHeight-70, KScreenWidth, 18);
    [self.view  addSubview: lab];
    
    UIButton  * btn = [XYUIKit buttonWithBackgroundColor:KRedColor titleColor:KWhiteColor titleHighlightColor:KClearColor title:@"购买会员(¥199/年)" fontSize:16];
    btn.frame = CGRectMake(0, KScreenHeight-44, KScreenWidth, 44);
    [btn addTarget:self action:@selector(pushinfo) forControlEvents:UIControlEventTouchUpInside];
    if([ball getStringById:@"member" fromTable:@"person"]){
        [btn setTitle:@"已是会员" forState:UIControlStateNormal];
        btn .userInteractionEnabled=NO;
    }
    [self.view addSubview:btn];
}
-(void)pushinfo{
    paySelectVC * pay = [[paySelectVC alloc]init];
    pay.type = @"3";
    pay.typeID = @"1";
    pay.typePrice = @"199";
    [self absPushViewController:pay animated:YES];
}
@end
