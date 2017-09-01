//
//  paySelectVC.m
//  football
//
//  Created by 雨停 on 2017/8/29.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "paySelectVC.h"
#import "paySelectStyle.h"
#import "TimeLabel.h"
@interface paySelectVC ()
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet TimeLabel *time;

@property (weak, nonatomic) IBOutlet UIImageView *alCheakImg;
@property (weak, nonatomic) IBOutlet UIImageView *wxChearImg;
@property (nonatomic ,  assign)int  paySelect;
@end

@implementation paySelectVC
-(id)init{
    if(self == [super init]){
        self.type =[NSString string];
        self.typeID =  [NSString string];
        self.typePrice = [NSString string];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
}
-(void)setSubview{
    self.paySelect=1;
    self.title = @"订单确认";
    [self  setNavLeftItemTitle:@"返回" andImage:nil];
    self.time.hour = 0;
    self.time.minute = 30;
    self.time.second = 00;
    self.price.text =  [NSString stringWithFormat:@"¥%@",self.typePrice];
    self.view.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
    
}
-(void)leftItemClick:(id)sender{
    [self absPopNav];
}
- (IBAction)alCheak:(UIButton *)sender {
    self.paySelect=1;
    self.alCheakImg.image = Img(@"cheak.png");
    self.wxChearImg.image = Img(@"nocheak.png");
}
- (IBAction)wxCheak:(UIButton *)sender {
    self.paySelect=2;
    self.alCheakImg.image = Img(@"nocheak.png");
    self.wxChearImg.image = Img(@"cheak.png");

}
- (IBAction)payGO:(UIButton *)sender {
    if([self.time.text isEqualToString:@"00:00"]){
        Toast(@"订单有效时间已过请重新下单");
        return;
    }
    if( self.paySelect==1){
        [self sendRequestPay];
    }else{
        [self sendRequestWX];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendRequestPay{
    [self requestType:HttpRequestTypePost url:nil
           parameters:@{@"action"    : @"aliPay",
                        @"total"     : self.typePrice,//self.model.sell_price,//支付金额
                        @"type"      : self.type, //1青训报名2赛事报名2在线教案3会员购买

                        @"product_id": self.typeID//赛事id或教案id
}
         successBlock:^(BaseModel *response) {
             if([response.errorno isEqualToString:@"0"]){
                [paySelectStyle alipayOrder:response.data.order];
             }
         } failureBlock:^(NSError *error) {
             
         }];
    
    
}
-(void)sendRequestWX{
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{@"action"    :@"wxPay",
                        @"total"     :self.typePrice,//支付金额
                        @"type"      :self.type, //1青训报名2赛事报名2在线教案3会员购买
                        @"product_id":self.typeID//产品id
}
         successBlock:^(BaseModel *response) {
            
             [paySelectStyle  WxpayappID:response.data.appid
                               partnerID:response.data.partnerid
                                noncestr:response.data.noncestr
                                 package:response.data.package
                               timestamp:response.data.timestamp
                                prepayid:response.data.prepayid
                                    sign:response.data.sign];
             
         } failureBlock:^(NSError *error) {
             
         }];
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
        if([self.type isEqualToString:@"3"]){
             [ball putString:@"1" withId:@"member" intoTable:@"person"];
        }
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
        
        if([self.type isEqualToString:@"3"]){
            [ball putString:@"1" withId:@"member" intoTable:@"person"];
        }
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
