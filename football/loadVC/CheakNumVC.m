//
//  CheakNumVC.m
//  football
//
//  Created by 雨停 on 2017/7/12.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "CheakNumVC.h"
#import "loginField.h"
#import "LogoTextField.h"
#import "RegistVC.h"
#import "NSString+ABSAdd.h"
#import "JCButton.h"
@interface CheakNumVC ()<UITextFieldDelegate>
@property  (nonatomic,strong)loginField      * cheakNum;
@property  (nonatomic,strong)LogoTextField   * phoneNum;
@property  (nonatomic,strong)UIButton        * nextBtn;
@property  (nonatomic,strong)UIButton        * agreement;
@property  (nonatomic,strong)UILabel         * pormort;
@property  (nonatomic,strong)JCButton        * pinBtn;
@end

@implementation CheakNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setSubview{
    [self setNavLeftItemTitle:@"返回" andImage:nil ];
    
    self.title =@"请验证您的手机号";
    
    self.phoneNum = [[LogoTextField alloc]initWithFrame:CGRectMake(46, 67+64, KScreenWidth-92, 44)];
    self.phoneNum.tittle.text = @"中国 +86";
    self.phoneNum.field.placeholder = @"手机号";
    self.phoneNum.field.delegate  = self;
     _phoneNum.field.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNum.field.tag=0;

  //  [self.phoneNum.btn addTarget:self action:@selector(getCheakNum:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.phoneNum];
    [self.phoneNum addSubview:self.pinBtn];
    self.cheakNum = [[loginField  alloc]initWithFrame:CGRectMake(46, self.phoneNum.bottom+46, KScreenWidth-92, 36)];
    self.cheakNum.field.placeholder = @"验证码";
    self.cheakNum.field.delegate    = self;
     self.cheakNum.field.keyboardType = UIKeyboardTypeNumberPad;
    self.cheakNum.field.tag =1;
 
    [self.view addSubview:self.cheakNum];
    
    self.nextBtn  =[XYUIKit buttonWithBackgroundColor:[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1] titleColor:[UIColor whiteColor] title:@"下一步" fontSize:16];
//    [self.nextBtn  addTarget: self action:@selector(nextFoundation ) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn.frame = CGRectMake(47, self.cheakNum.bottom +29, KScreenWidth-94, 46);
    self.nextBtn.layer.cornerRadius = 4;
    [self.view addSubview:self.nextBtn];
    [self.nextBtn addTarget:self action:@selector(getCheakNum:) forControlEvents:UIControlEventTouchUpInside];
    self.nextBtn .userInteractionEnabled = NO;
    self.pormort  = [XYUIKit labelWithTextColor:[UIColor lightGrayColor] numberOfLines:1 text:@"轻按上面的“下一步”，即表示你同意" fontSize:13];
    self.pormort.textAlignment = NSTextAlignmentCenter;
    self.pormort.frame = CGRectMake(0, self.nextBtn.bottom+16, KScreenWidth, 19);
    [self.view addSubview:self.pormort];
    
    self.agreement = [XYUIKit buttonWithBackgroundColor:[UIColor clearColor] titleColor:[UIColor blackColor] title:@"《数苗足球软件许可及服务协议》" fontSize:13];
    self.agreement.frame =CGRectMake(0, self.pormort.bottom, KScreenWidth, 19);
    [self.view addSubview:self.agreement];
    
    
}
//self.btn= [[ TimerButton alloc]initWithFrame:CGRectMake(self.field.right, 0, 60, 36)];
//self.btn.layer.cornerRadius = 4;
//[self addSubview:self.btn];
- (JCButton *)pinBtn {
    if (!_pinBtn) {
        CGRect frame = CGRectMake(self.phoneNum.field.right+10, 0,60,36);
        
        _pinBtn =[[JCButton   alloc]initWithFrame:frame];
        _pinBtn.layer.cornerRadius = 4;
        [_pinBtn setTitle:@"验证" forState:UIControlStateNormal];
        if(self.phoneNum.field.text.length!=0){
            _pinBtn.backgroundColor=mainColor;
            _pinBtn.userInteractionEnabled =YES;
        }else{
            _pinBtn.userInteractionEnabled =NO;
            
            [_pinBtn setBackgroundColor:[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1]];
        }
        [_pinBtn addTarget:self action:@selector(getCheakNum:) forControlEvents:UIControlEventTouchUpInside];
        _pinBtn.titleLabel.font = FontSize(13);
        [_pinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_pinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    }
    return _pinBtn;
}

-(void)nextFoundation{
    RegistVC  * reg = [[RegistVC alloc]init];
    [self.navigationController   pushViewController:reg animated:YES];
}
-(void)leftItemClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.phoneNum.field) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        //so easy
        else if (self.phoneNum.field.text.length >= 11) {
            self.phoneNum.field.text = [textField.text substringToIndex:11];
            return NO;
        }
        
    }
     if (textField == self.cheakNum.field) {
     //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
     if (range.length == 1 && string.length == 0) {
     return YES;
     }
     //so easy
     else if (self.cheakNum.field.text.length >= 6) {
     self.cheakNum.field.text = [textField.text substringToIndex:6];
     return NO;
     }
     
     }
    
    
    if(textField.tag==1){
        if (![string isEqualToString:@""])
        {
            if(_phoneNum.field.text.length>0){
                _nextBtn.backgroundColor=mainColor;
                _nextBtn.userInteractionEnabled =YES;
                
            }
        }
        if ([string isEqualToString:@""] && range.location == 0 && range.length == 1)
        {
            _nextBtn.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
            _nextBtn.userInteractionEnabled =NO;
            
        }
    }
        if(textField.tag==0){
            if (![string isEqualToString:@""])
            {
                self.pinBtn.backgroundColor = mainColor;
                self.pinBtn .userInteractionEnabled =YES;

                if(_cheakNum.field.text.length>0){
                    _nextBtn.backgroundColor=mainColor;
                    _nextBtn.userInteractionEnabled =YES;
                                    }
            }
            if ([string isEqualToString:@""] && range.location == 0 && range.length == 1)
            {
                _nextBtn.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
                _nextBtn.userInteractionEnabled =NO;
                _pinBtn.backgroundColor = [UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
                _pinBtn .userInteractionEnabled =NO;

            }
        }
 
        
    
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if(textField.tag==0){
        _nextBtn.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
        _nextBtn.userInteractionEnabled =NO;
        _pinBtn.backgroundColor = [UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
        _pinBtn .userInteractionEnabled =NO;
        
    }else if (textField.tag==1){
        _nextBtn.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
        _nextBtn.userInteractionEnabled =NO;
    }
    
    
    return YES;
}

-(void)getCheakNum:(UIButton * )sender{
    if(sender ==_pinBtn){
    if ([NSString isMobileNumber:self.phoneNum.field.text]) {
        _pinBtn.enabled = NO;
        [_pinBtn startWithSecond:60];
        [_pinBtn didChangBlock:^NSString *(JCButton *countDownButton,int second) {
            NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
            return title;
        }];
        
        [_pinBtn didFinshBlock:^NSString *(JCButton *countDownBtn, int second) {
            countDownBtn.enabled = YES;
            
            return @"验证";
        }];

        [self sendRequestNum];
    } else {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"请输入正确的手机号码！"
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        [alert show];
    }
    }else{
        if ([NSString isMobileNumber:self.phoneNum.field.text] && [NSString isIdentityNumber:self.cheakNum.field.text]) {
           
          [self sendRequestCheak];
        } else {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"手机号或验证码不正确！"
                                                           message:@""
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [alert show];
        }
 
    }
    

}
-(void)sendRequestCheak{
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{
                        @"action":@"verifySmsCode",
                        @"mobile":_phoneNum.field.text,
                        @"vericode":_cheakNum.field.text,
                        @"use_type":@"register"
              
                        }
         successBlock:^(BaseModel *response) {
             if([response.errorno isEqualToString:@"0"]){
                 [self nextFoundation];
             }
             
         } failureBlock:^(NSError *error) {
             
         }];
}
-(void)sendRequestNum{
    
   [self requestType:HttpRequestTypePost
                 url:nil
          parameters:@{@"action":@"sendSmsCode",
                       @"mobile":_phoneNum.field.text,
                       @"use_type":@"register"
                       }
        successBlock:^(BaseModel *response) {
            if([response.errorno isEqualToString:@"0"]){
                [ball putString:_phoneNum.field.text withId:@"phoneNum" intoTable:@"person"];
            }
          } failureBlock:^(NSError *error) {
              
          }];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.pinBtn stop];
    }
@end
