//
//  BackPassVC.m
//  football
//
//  Created by 雨停 on 2017/7/12.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "BackPassVC.h"
#import "loginField.h"
#import "LogoTextField.h"
#import "inforVC.h"
#import "NSString+ABSAdd.h"
#import "JCButton.h"
@interface BackPassVC ()<UITextFieldDelegate>
@property  (nonatomic,strong)LogoTextField   * phoneNum;
@property  (nonatomic,strong)loginField   * cheakNum;
@property  (nonatomic,strong)loginField  * pass;
@property  (nonatomic,strong)loginField  * passRepeat;
@property  (nonatomic,strong)UIButton    * push;
@property  (nonatomic,strong)JCButton * pinBtn;

@end

@implementation BackPassVC

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
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.title =@"找回密码";
    
    self.phoneNum = [[LogoTextField alloc]initWithFrame:CGRectMake(46, 64+30, KScreenWidth-92, 44)];
    self.phoneNum.tittle.text = @"中国 +86";
    self.phoneNum.field.placeholder = @"手机号";
    self.phoneNum.field.delegate =self;
    self.phoneNum.field.keyboardType = UIKeyboardTypeNumberPad;
   // [self.phoneNum.btn addTarget:self action:@selector(getCheak:) forControlEvents:UIControlEventTouchUpInside];
    [self.phoneNum addSubview:self.pinBtn];
    self.phoneNum.field.tag = 0;
    [self.view addSubview:self.phoneNum];
    self.cheakNum = [[loginField  alloc]initWithFrame:CGRectMake(46, self.phoneNum.bottom+46, KScreenWidth-92, 36)];
    self.cheakNum.field.placeholder = @"验证码";
    self.cheakNum.field.delegate = self;
    self.cheakNum.field.keyboardType = UIKeyboardTypeNumberPad;
    self.cheakNum.field.tag = 1;
    [self.view addSubview:self.cheakNum];
    
    self.pass = [[loginField  alloc]initWithFrame:CGRectMake(48, self.cheakNum.bottom+46, KScreenWidth-96, 34)];
    [self.view addSubview:self.pass];
    self.pass.field.placeholder  = @"密码6-16位";
    self.pass.field.delegate =self;
    self.pass.field.tag = 2;
    self.pass.field.secureTextEntry = YES;
    self.passRepeat = [[loginField  alloc]initWithFrame:CGRectMake(48, self.pass.bottom+46, KScreenWidth-96, 34)];
    self.pass.field.delegate =self;
    self.pass.field.tag = 3;
    [self.view addSubview:self.passRepeat];
    self.passRepeat.field.placeholder  = @"重复密码";
    self.passRepeat.field.secureTextEntry = YES;

    self.push  =[XYUIKit buttonWithBackgroundColor:mainColor titleColor:[UIColor whiteColor] title:@"下一步" fontSize:16];
    [self.push  addTarget:self action:@selector(getCheak:) forControlEvents:UIControlEventTouchUpInside];
    self.push .frame = CGRectMake(48, self.passRepeat.bottom +14, KScreenWidth-96, 46);
    self.push .layer.cornerRadius = 4;
    self.push.tag =1;
    _push.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
    _push.userInteractionEnabled = NO;
    [self.view addSubview:self.push];
    
    
    
}

-(void)getCheak:(UIButton *)sender{
    if(sender.tag ==1){
        if ([NSString isMobileNumber:self.phoneNum.field.text] && [NSString isIdentityNumber:self.cheakNum.field.text]) {
            
            
            if(![self.pass.field.text isEqualToString:self.passRepeat.field.text]){
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"两次密码不相同"
                                                               message:@""
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            if(self.pass.field.text.length<6){
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"密码不能小于6位"
                                                               message:@""
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
             [self sendRequestCheak];
        } else {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"手机号或验证码不正确！"
                                                           message:@""
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [alert show];
        }

    }else{
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
 
    }
    
}
-(void)sendRequestCheak{
    
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{@"action"       : @"forget",
                        @"mobile"       : _phoneNum.field.text,
                        @"vericode"     : _cheakNum.field.text,
                        @"password"     : _pass.field.text,
                        @"repassword"   : _passRepeat.field.text,
                    

                        }
         successBlock:^(BaseModel *response) {
             if([response.errorno isEqualToString:@"0"]){
                 [self.navigationController popViewControllerAnimated:YES];
                 
                 // [store putString:_phoneNum.field.text withId:@"phoneNum" intoTable:@"person"];
             }
         } failureBlock:^(NSError *error) {
             
         }];
}

-(void)sendRequestNum{
    
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{@"action":@"sendSmsCode",
                        @"mobile":_phoneNum.field.text,
                        @"use_type":@"forget"
                        
                        }
         successBlock:^(BaseModel *response) {
             if([response.errorno isEqualToString:@"0"]){
                // [store putString:_phoneNum.field.text withId:@"phoneNum" intoTable:@"person"];
             }
         } failureBlock:^(NSError *error) {
             
         }];
}

-(void)nextFoundation{
   // NSNotification * notification = [NSNotification notificationWithName:@"backMeVC" object:nil];
    //[[NSNotificationCenter defaultCenter] postNotification:notification];
     [self dismissViewControllerAnimated:NO completion:nil];
   // [self.navigationController popToRootViewControllerAnimated:NO];

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
    
    if(textField ==self.cheakNum.field){
        if(range.length==1&&string.length==0){
            return YES;
        }else if(self.cheakNum.field.text.length>6){
            self.cheakNum.field.text = [textField.text substringFromIndex:6];
            
            return NO;
        }
    }
    if (textField == self.pass.field) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        //so easy
        else if (self.pass.field.text.length >= 16) {
            self.pass.field.text = [textField.text substringToIndex:6];
            return NO;
        }
        
    }
    if (textField == self.passRepeat.field) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        //so easy
        else if (self.passRepeat.field.text.length >= 16) {
            self.passRepeat.field.text = [textField.text substringToIndex:6];
            return NO;
        }
        
    }
    
    
    if(textField.tag==1){
        if (![string isEqualToString:@""])
        {
            if(_phoneNum.field.text.length>0&&_passRepeat.field.text.length>0&&_pass.field.text.length>0){
                _push.backgroundColor=mainColor;
                _push.userInteractionEnabled =YES;
            }
        }
        if ([string isEqualToString:@""] && range.location == 0 && range.length == 1)
        {
            _push.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
            _push.userInteractionEnabled =NO;
            
        }
    }
        if(textField.tag==0){
            if (![string isEqualToString:@""])
            {
                self.pinBtn.backgroundColor = mainColor;
                self.pinBtn .userInteractionEnabled =YES;
                if(_pass.field.text.length>0&&_passRepeat.field.text.length>0&&_cheakNum.field.text.length>0){
                    _push.backgroundColor=mainColor;
                    _push.userInteractionEnabled =YES;
                    
                }
            }
            if ([string isEqualToString:@""] && range.location == 0 && range.length == 1)
            {
                _push.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
                _push.userInteractionEnabled =NO;
            }
        }
    
    if(textField.tag==2){
        if (![string isEqualToString:@""])
        {
            if(_passRepeat.field.text.length>0&&_phoneNum.field.text.length>0&&_cheakNum.field.text.length>0){
                _push.backgroundColor=mainColor;
                _push.userInteractionEnabled =YES;
                
            }
        }
        if ([string isEqualToString:@""] && range.location == 0 && range.length == 1)
        {
            _push.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
            _push.userInteractionEnabled =NO;
        }
    }

    if(textField.tag==3){
        if (![string isEqualToString:@""])
        {
            if(_pass.field.text.length>0&&_phoneNum.field.text.length>0&&_cheakNum.field.text.length>0){
                _push.backgroundColor=mainColor;
                _push.userInteractionEnabled =YES;
                
            }
        }
        if ([string isEqualToString:@""] && range.location == 0 && range.length == 1)
        {
            _push.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
            _push.userInteractionEnabled =NO;
        }
    }

    
    return YES;
}

- (JCButton *)pinBtn {
    if (!_pinBtn) {
        CGRect frame = CGRectMake(self.phoneNum.field.right+10, 0,60,36);
        
        _pinBtn =[[JCButton alloc]initWithFrame:frame];
        [_pinBtn setTitle:@"验证" forState:UIControlStateNormal];
        _pinBtn.layer.cornerRadius = 4;
        if(self.phoneNum.field.text.length!=0){
            _pinBtn.backgroundColor=mainColor;
            _pinBtn.userInteractionEnabled =YES;
        }else{
            _pinBtn.userInteractionEnabled =NO;
            
            [_pinBtn setBackgroundColor:[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1]];
        }

        [_pinBtn addTarget:self action:@selector(getCheak:) forControlEvents:UIControlEventTouchUpInside];
        _pinBtn.titleLabel.font = FontSize(13);
        [_pinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_pinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    }
    return _pinBtn;
}



- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if(textField.tag==0){
        self.pinBtn.backgroundColor =[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
        self.pinBtn .userInteractionEnabled =NO;
        _push.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
        _push.userInteractionEnabled =NO;
    }else if (textField.tag==1){
        _push.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
        _push.userInteractionEnabled =NO;
    }else if (textField.tag==2){
        _push.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
        _push.userInteractionEnabled =NO;
    }
    else if (textField.tag==3){
        _push.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
        _push.userInteractionEnabled =NO;
    }
    
    
    return YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.pinBtn stop];
}

@end
