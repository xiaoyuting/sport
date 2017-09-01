//
//  orderVC.m
//  football
//
//  Created by 雨停 on 2017/7/25.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "orderVC.h"
#import "paySelectStyle.h"
@interface orderVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrHeight;
@property (weak, nonatomic) IBOutlet UIImageView *alpayImg;
@property (weak, nonatomic) IBOutlet UIImageView *wxImg;
@property (weak, nonatomic) IBOutlet UIImageView *otherImg;
@property (nonatomic,assign) int    paytag;

@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation orderVC
-(id)init{
    if(self = [super init]){
        self.price = [[NSString alloc]init];
    }
    return self;
}
- (IBAction)orderPayStyle:(UIButton *)sender {
    if(sender.tag==0){
        self.alpayImg.image = Img(@"cheak");
        self.wxImg.image    = Img(@"nocheak");
        self.otherImg.image = Img(@"nocheak");
        self.paytag=1;
    }else if(sender.tag==1){
        self.alpayImg.image = Img(@"nocheak");
        self.wxImg.image    = Img(@"cheak");
        self.otherImg.image = Img(@"nocheak");
       self.paytag=2;
        
    }else if(sender.tag==2){
        self.alpayImg.image =  Img(@"nocheak");
        self.wxImg.image    =  Img(@"nocheak");
        self.otherImg.image =  Img(@"cheak");
        self.paytag=3;
    }
}

- (void)viewDidLoad {
    self.paytag=1;
    [super viewDidLoad];
    self.money.text = self.price;
    [self setSubview];
    // Do any additional setup after loading the view from its nib.
}
-(void)setSubview{
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.title =@"订单确认";
}
-(void)leftItemClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)paySelectWXorAlipay:(UIButton *)sender {
    // paySelectStyle * style = [[paySelectStyle alloc]init];
    if(self.paytag==1){
         //[style doAlipayPayAppID:nil Price:nil orderNum:nil orderTime:nil PrivateKey:nil Body:nil subJect:nil];
    }else if(self.paytag ==2){
       // [style getWeChatPayWithOrderName:@"测试数据" price:@"1"];
    }
   
   
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    self.scrHeight.constant =KScreenHeight-64-44;
}
- (void)viewWillAppear:(BOOL)animated
{
   
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderalPayResult:) name:@"aliPay" object:nil];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"WXPay" object:nil];
}

#pragma mark 移除通知
- (void)viewWillDisappear:(BOOL)animated
{
   
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 事件
- (void)getOrderPayResult:(NSNotification *)notification
{
    NSLog(@"userInfo: %@",notification.userInfo);
    
    if ([notification.object isEqualToString:@"0"])
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if([notification.object isEqualToString:@"-2"])
    {
        [self alert:@"提示" msg:@"用户取消了支付"];
    }
    else
    {
        [self alert:@"提示" msg:@"支付失败"];
    }
}
- (void)getOrderalPayResult:(NSNotification *)notification
{
    NSLog(@"userInfo: %@",notification.userInfo);
    
    if ([notification.object isEqualToString:@"9000"])
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"支付成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        [self alert:@"提示" msg:@"支付失败"];
    }
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}

@end
