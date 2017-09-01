//
//  RegistVC.m
//  football
//
//  Created by 雨停 on 2017/7/12.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "RegistVC.h"
#import "loginField.h"
#import "loadInfoSetVC.h"
@interface RegistVC ()<UITextFieldDelegate>
@property  (nonatomic,strong)loginField  * name;
@property  (nonatomic,strong)loginField  * pass;
@property  (nonatomic,strong)loginField  * passRepeat;
@property  (nonatomic,strong)UIButton    * push;
@end

@implementation RegistVC

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
    self.title =@"注册";
    self.name = [[loginField alloc]initWithFrame:CGRectMake(48, 67+64, KScreenWidth-96, 34)];
    [self.view addSubview:self.name];
    self.name.field.placeholder  = @"用户名2-15位,且不能纯数字";
    self.name.field.delegate = self;
    self.name.field.tag = 0;
    self.pass = [[loginField  alloc]initWithFrame:CGRectMake(48, self.name.bottom+46, KScreenWidth-96, 34)];
    [self.view addSubview:self.pass];
    self.pass.field.placeholder  = @"密码6-16位";
    self.pass.field.delegate    =  self;
    self.pass.field.secureTextEntry = YES;
 
    self.pass.field.tag = 1;
    self.passRepeat = [[loginField  alloc]initWithFrame:CGRectMake(48, self.pass.bottom+46, KScreenWidth-96, 34)];
    [self.view addSubview:self.passRepeat];
    self.passRepeat.field.placeholder  = @"重复密码";
    self.passRepeat.field.secureTextEntry=YES;
    self.passRepeat.field.delegate    = self;
    self.passRepeat.field.tag = 2;

    self.push  =[XYUIKit buttonWithBackgroundColor:RGBAColor(60,185,99,0.5) titleColor:[UIColor whiteColor] title:@"注册" fontSize:16];
    
    [self.push addTarget:self action:@selector(pushInfo) forControlEvents:UIControlEventTouchUpInside];
    self.push.frame = CGRectMake(53, self.passRepeat.bottom +45, KScreenWidth-106, 46);
    self.push.layer.cornerRadius = 4;
    [self.view addSubview:self.push];
    _push.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
    _push.userInteractionEnabled = NO;
   
}
-(void)pushInfo{
    if([RegistVC judgePassWordLegal:_name.field.text ]){
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"用户名2—15位，且不能纯数字"
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        if(![self.pass.field.text isEqualToString:self.passRepeat.field.text]){
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"两次输入密码不同"
                                                           message:@""
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
             [alert show];
            return;
        }

        if(self.pass.field.text.length<6 ){
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"密码最少6位"
                                                           message:@""
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
       
    [self requestType:HttpRequestTypePost
                  url:nil parameters:@{
                                       @"action" : @"register",
                                       @"mobile" :[ball getStringById:@"phoneNum" fromTable:@"person"], 
                                       @"username" :_name.field.text ,
                                       @"password" :_pass.field.text,
                                       @"repassword" : _passRepeat.field.text
                                 
                                       }
         successBlock:^(BaseModel *response) {
             if([response.errorno   isEqualToString:@"0"]){
                
                 loadInfoSetVC * setVC = [[loadInfoSetVC alloc]init];
                 [self.navigationController   pushViewController:setVC animated:YES];

             }
        
    } failureBlock:^(NSError *error) {
        
        
    }];
    }
    
}
-(void)leftItemClick:(id)sender{
    [self.navigationController   popViewControllerAnimated:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.name.field) {
        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
        //so easy
        else if (self.name.field.text.length >= 15) {
            self.name.field.text = [textField.text substringToIndex:11];
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
            if(_name.field.text.length>0&&_passRepeat.field.text.length>0){
                _push.backgroundColor=mainColor;
                _push.userInteractionEnabled =YES;
            }
        }
        if ([string isEqualToString:@""] && range.location == 0 && range.length == 1)
        {
            _push.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
            _push.userInteractionEnabled =NO;
            
        }}
        if(textField.tag==0){
            if (![string isEqualToString:@""])
            {
                if(_pass.field.text.length>0&&_passRepeat.field.text.length>0){
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
            if(_pass.field.text.length>0&&_name.field.text.length>0){
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
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if(textField.tag==0){
        _push.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
        _push.userInteractionEnabled =NO;
        }else if (textField.tag==1){
        _push.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
        _push.userInteractionEnabled =NO;
    }else if (textField.tag==2){
        _push.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
        _push.userInteractionEnabled =NO;
    }
    
    
    return YES;
}
+(BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 2){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        //NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{2,15}$";
        NSString * regex = @"[0-9]*";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}
- (BOOL) deptNumInputShouldNumber:(NSString *)str
{
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}


@end
