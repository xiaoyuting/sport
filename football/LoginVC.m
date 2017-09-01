//
//  ABSLoginVC.m
//  ABSHome
//
//  Created by ABS on 16/10/18.
//  Copyright © 2016年 ABS. All rights reserved.
//

#import "LoginVC.h"
#import "NSString+ABSAdd.h"
#import "loginField.h"
#import "NavigationVC.h"
#import "RegistVC.h"
#import "CheakNumVC.h"
#import "BackPassVC.h"
#import "LoginVC+rootTabVC.h"

@interface LoginVC ()<UITextFieldDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIButton    * loginBtn;



@property (nonatomic, assign) BOOL   imgStatue;
@property (nonatomic,strong) UIImageView    * logoImg;
@property (nonatomic,strong) loginField    * phoneNum;
@property (nonatomic,strong) loginField    * passNum;
@property (nonatomic,strong) UIButton      * forgetPass;
@property (nonatomic,strong) UIButton      * visitor;
@property (nonatomic,strong) UIButton      * regist;
@end

@implementation LoginVC




- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
        
}


- (void)setSubviews {
    self.imgStatue = YES;
    [self.view addSubview:self.exitBtn];
    WeakSelf(self);
    
    [self.view addSubview:self.logoImg];
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(166, 72));
        make.top.equalTo(weakself.view.mas_top).with.offset(93);
        make.centerX.equalTo(weakself.view);
    }];
    self.logoImg.image = Img(@"Group");

    [self.view addSubview:self.phoneNum];
    [self.view addSubview:self.passNum];
    [self.view addSubview:self.forgetPass];

    [self addServiceAgreementLabel];
    
    [self.view addSubview:self.loginBtn];
    
    [self.view addSubview:self.visitor];
    [self.view addSubview:self.regist];
}

 -(void)leftFoundation{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addServiceAgreementLabel {
    
 
       }

- (void)underLineTextClick {
    NSLog(@"协议界面");

}



//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    
//    if (textField == self.tf) {
//        //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
//        if (range.length == 1 && string.length == 0) {
//            return YES;
//        }
//        //so easy
//        else if (self.tf.text.length >= 6) {
//            self.tf.text = [textField.text substringToIndex:6];
//            return NO;
//        }
//        
//    }
//    return [self validateNumber:string];
//}
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
  /*  if (textField == self.passNum.field) {
                //这里的if时候为了获取删除操作,如果没有次if会造成当达到字数限制后删除键也不能使用的后果.
                if (range.length == 1 && string.length == 0) {
                    return YES;
                }
                //so easy
                else if (self.passNum.field.text.length >= 6) {
                    self.passNum.field.text = [textField.text substringToIndex:6];
                    return NO;
                }
                
            }
    */
    
    if(textField.tag==1){
    if (![string isEqualToString:@""])
    {
        if(_phoneNum.field.text.length>0){
        _loginBtn.backgroundColor=mainColor;
        _loginBtn.userInteractionEnabled =YES;
        }
    }
    if ([string isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
       _loginBtn.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
       _loginBtn.userInteractionEnabled =NO;
       
    }
        if(textField.tag==0){
            if (![string isEqualToString:@""])
            {
                if(_passNum.field.text.length>0){
                _loginBtn.backgroundColor=mainColor;
                _loginBtn.userInteractionEnabled =YES;

                }
            }
            if ([string isEqualToString:@""] && range.location == 0 && range.length == 1)
            {
                _loginBtn.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
                _loginBtn.userInteractionEnabled =NO;
            }
        }
//    }else if (textField.tag==1){
//        if (![string isEqualToString:@""])
//        {
//            _loginBtn.backgroundColor=mainColor;
//            _loginBtn.userInteractionEnabled =YES;
//            //self.breakVc.placholder .hidden = YES;
//        }
//        if ([string isEqualToString:@""] && range.location == 0 && range.length == 1)
//        {
//            _loginBtn.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
//            _loginBtn.userInteractionEnabled =NO;
//            
//           
//        }

    }
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if(textField.tag==0){
         _loginBtn.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
         _loginBtn.userInteractionEnabled =NO;
        
    }else if (textField.tag==1){
       _loginBtn.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
        _loginBtn.userInteractionEnabled =NO;
        }

    
    return YES;
}
-(UIImageView *)logoImg{
    if(!_logoImg){
        _logoImg = [[UIImageView  alloc]init];
        //_logoImg.layer.cornerRadius  = 40;
        //_logoImg.backgroundColor = [UIColor redColor];
    }
    return _logoImg;
}
-(UIButton * )exitBtn{
    if(!_exitBtn){
        _exitBtn = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-50, 20, 30, 30)];
        [_exitBtn addTarget:self action:@selector(outLogo ) forControlEvents:UIControlEventTouchUpInside];
        [_exitBtn setImage:Img(@"Icon") forState:UIControlStateNormal];
    }
    return _exitBtn;
}
-(void)outLogo{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(loginField*)phoneNum{
    if(!_phoneNum){
        _phoneNum = [[loginField  alloc]initWithFrame:CGRectMake(48,96+72+93, KScreenWidth-96, 34)];
        _phoneNum.field.placeholder = @"手机号码";
        _phoneNum.field.delegate  =self;
        _phoneNum.field.keyboardType = UIKeyboardTypeNumberPad;
        _phoneNum.field.tag = 0;
    }
    return _phoneNum;
}
-(loginField*)passNum{
    if(!_passNum){
        _passNum = [[loginField  alloc]initWithFrame:CGRectMake(48, _phoneNum.bottom+46,KScreenWidth-96, 34)];
        _passNum.field.placeholder = @"密码";
        _passNum.field.delegate  = self;
        _passNum.field.tag = 1;
        _passNum.field.secureTextEntry=YES;
    }
    return _passNum;
}

-(UIButton *)forgetPass{
    if(!_forgetPass){
        _forgetPass  = [XYUIKit buttonWithBackgroundColor:[UIColor clearColor] titleColor:[UIColor colorWithHexString:@"#3CB963"] title:@"忘记密码?" fontSize:14];
        _forgetPass.frame = CGRectMake(48, _passNum.bottom+11,KScreenWidth-96, 30);
        _forgetPass.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _forgetPass.tag = 0;
        [_forgetPass addTarget:self action:@selector(foundationButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _forgetPass;
}
-(UIButton *)visitor{
    if(!_visitor){
        _visitor = [XYUIKit buttonWithBackgroundColor:[UIColor clearColor] titleColor:[UIColor grayColor] title:@"游客登录" fontSize:16];
        _visitor .frame = CGRectMake(20, KScreenHeight -56, (KScreenWidth-40)/2.0, 24);
        _visitor.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _visitor.tag =1;
        [_visitor addTarget:self action:@selector(foundationButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _visitor;
}
-(UIButton *)regist{
    if(!_regist){
        _regist = [XYUIKit buttonWithBackgroundColor:[UIColor clearColor] titleColor:[UIColor grayColor] title:@"注册新账号" fontSize:16];
        _regist .frame = CGRectMake(20+(KScreenWidth-40)/2.0, KScreenHeight -56, (KScreenWidth-40)/2.0, 24);
        _regist.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _regist.tag = 2;
        [_regist addTarget:self action:@selector(foundationButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _regist;
}

- (void)pinBtnClick {
    
    if ([NSString isMobileNumber:self.phoneNum.field.text]) {
       
    } else {
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"请输入正确的手机号码！"
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [XYUIKit buttonWithBackgroundColor:mainColor titleColor:[UIColor whiteColor] title:@"登录" fontSize:18];
        _loginBtn.frame = CGRectMake(48, _passNum.bottom+83, KScreenWidth-96, 46);
        _loginBtn.layer.cornerRadius=4;
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
         _loginBtn.backgroundColor=[UIColor colorWithRed:0.8 green:0.81 blue:0.82 alpha:1];
        _loginBtn.userInteractionEnabled=NO;
    }
    return _loginBtn;
}

- (void)loginBtnClick {
   
   /* if(self.imgStatue==NO){
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"请同意用车服务条款！"
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        [alert show];
    }else{*/
        
    if ([NSString isMobileNumber:self.phoneNum.field.text] ) {
         [self sendRequest];
      
    } else {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"手机号不正确！"
                                                       message:@""
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil, nil];
        [alert show];
   // }
}
}


-(void)foundationButton:(UIButton * )sender{
    if(sender.tag==0){
        //忘记密码
        BackPassVC * backVC = [[BackPassVC alloc]init];
        //NavigationVC * navVC = [[NavigationVC alloc]initWithRootViewController:backVC];
        [self.navigationController pushViewController:backVC animated:YES];
    }else if(sender.tag==1){
        //游客
        [self setBaseVC];
    }else if(sender.tag==2){
        //注册
        CheakNumVC * cheakVC = [[CheakNumVC alloc]init];
        //NavigationVC * navVC = [[NavigationVC alloc]initWithRootViewController:cheakVC];
        [self.navigationController pushViewController:cheakVC animated:YES];
    }
}
-(void)sendRequest{
   
    [self requestType:HttpRequestTypePost
                  url:@""
           parameters:@{
                                                                            
                      
                         @"action"   : @"login",
                         @"mobile"   : _phoneNum.field.text,
                         @"password" : _passNum.field.text
  
                        }
         successBlock:^(BaseModel *response) {
             if([response.errorno  isEqualToString:@"0"]){
                  [ball putString:@"1" withId:@"load" intoTable:@"person"];
                  [ball putString:_phoneNum.field.text withId:@"phoneNum" intoTable:@"person"];
                 NSLog(@"%@",[ball getStringById:@"load" fromTable:@"person"]);
                 [self setBaseVC];
                  //[self dismissViewControllerAnimated:YES completion:nil];
             }
         } failureBlock:^(NSError *error) {
             
         }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [kNotificationCenter addObserver:self selector:@selector(getCheakStatus:) name:@"loadStatus" object:nil];
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden=YES;
    //监听通知
   
    
}

#pragma mark 移除通知
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden =NO;

  
}
#pragma mark - 事件
- (void)getCheakStatus:(NSNotification *)notification
{
    NSLog(@"userInfo: %@",notification.userInfo);
    NSLog(@"%@",notification.object);
    if([notification.object isEqualToString:@"0"]){
        self.visitor.userInteractionEnabled=NO;
    }
   // [self dismissViewControllerAnimated:NO completion:nil];
    
//[self alert:@"提示" msg:@"通知移除"];

}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alter show];
}
-(void)dealloc{
    //移除通知
   // [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
