//
//  XYBaseVC.m
//  CateTool
//
//  Created by 雨停 on 2016/12/18.
//  Copyright © 2016年 雨停. All rights reserved.
//

#import "XYBaseVC.h"
#import "Header.h"
#import "UIView+Frame.h"
#import "UIColor+XYColor.h"

#import "UIImage+anniGIF.h"
#import "RequestManager.h"
#import "SXButton.h"
#import "ABSSegmentCate.h"
#import "navi.h"
#import "ZKUDID.h"
#import "CusMD5.h"
NSString *const kName = @"Alun Chen";
@interface XYBaseVC ()
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UIView *placeholderView;
@property (nonatomic, strong) UIImageView *navBarHairlineImageView;



@end

@implementation XYBaseVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dictionary:(NSDictionary *)dic {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    self.navBarHairlineImageView  = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
  
  
    
}

-(void)setLine{
    UIImageView  * lineBottom = [[UIImageView   alloc]initWithFrame:CGRectMake(0, 43.5, KScreenWidth, 0.5)];
    lineBottom.backgroundColor = [UIColor colorWithHexString:@"#D9D9D9"];
    [self.view addSubview:lineBottom];
}
-(void)setNavi{
    self.navi = [[NSBundle mainBundle]loadNibNamed:@"Niav" owner:self options:nil].lastObject;
    self.navi .frame  =CGRectMake(0, 0, KScreenWidth, 64);
    self.navi.backgroundColor = mainColor;
    [self.navi.leftBtn addTarget:self action:@selector(leftFoundation) forControlEvents:UIControlEventTouchUpInside];
    [self.navi.rightBtn addTarget:self action:@selector(rightFoundation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navi];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     }
-(void)leftFoundation{
    
}
-(void)rightFoundation{
    
}
-(void)setNaivTitle:(NSString *)title{
    self.navi.title.text =title;
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   // self.navigationController.navigationBar.hidden=YES;
    /* if (self.navigationController) {
         self.navBarHairlineImageView.hidden = YES;
//        [self.navigationController.navigationBar setBackgroundImage: Img(@"new")                                                      forBarMetrics:UIBarMetricsDefault];
//        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }*/
}

//视图将要消失时取消隐藏
- (void)viewWillDisappear:(BOOL)animated
{
     [super viewWillDisappear:animated];
    //self.navigationController.navigationBar.hidden =NO;
   
}

- (void)setData {
    
}

- (void)setSubviews {
    
}
-(ABSSegmentCate    *)setSegframe:(CGRect)rect titleArr:(NSArray *)arr space:(CGFloat)space{
   

    ABSSegmentCate * segmentedControl = [[ABSSegmentCate alloc] initWithFrame:rect titleArray:arr];
    // _segmentedControl.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.1];
    // segmentedControl.segmentedControlLineStyle = LLSegmentedControlStyleUnderline;
    if(arr.count<=4){
        segmentedControl.segmentedControlTitleSpacingStyle = LLSegmentedControlTitleSpacingStyleWidthFixed;
        segmentedControl.titleWidth = (KScreenWidth-space) /arr.count;
    }else{
        segmentedControl.segmentedControlTitleSpacingStyle = LLSegmentedControlTitleSpacingStyleWidthAutoFit;
    }
    // lineWidthEqualToTextWidth 设置为YES, lineWidth 属性则不需设置
    segmentedControl.lineWidthEqualToTextWidth = YES;
    segmentedControl.textColor = [UIColor darkTextColor];
    segmentedControl.selectedTextColor = mainColor;
    segmentedControl.font = [UIFont systemFontOfSize:14];
    segmentedControl.selectedFont = [UIFont systemFontOfSize:14];
    segmentedControl.lineColor = mainColor;
    segmentedControl.lineHeight = 2.f;
    // segmentedControlTitleSpacingStyle 设置为 LLSegmentedControlTitleSpacingStyleSpacingFixed
    // 则不需要设置 titleWidth 属性
    segmentedControl.titleSpacing = 30;
    segmentedControl.defaultSelectedIndex = 0;
    // 分割线设置
    // _segmentedControl.showSplitLine = YES;
    segmentedControl.splitLineSize = CGSizeMake(1, 25);
    return segmentedControl;
    
}
- (void)absPushViewController:(XYBaseVC *) controller animated:(BOOL) animated {
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:animated];
}

- (void)absRootPushViewController:(XYBaseVC *) controller animated:(BOOL) animated {
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController popToRootViewControllerAnimated:animated];
}

- (void)showPlaceholderViewWithImage:(UIImage *)image
                             message:(NSString *)message
                         buttonTitle:(NSString *)title
                       centerOffsetY:(CGFloat)centerOffsetY
                         onSuperView:(UIView *)superView {
    
    self.placeholderView = [self setPlaceholderViewWithImage:image
                                                     message:message
                                                 buttonTitle:title
                                               centerOffsetY:centerOffsetY];
    self.placeholderView.hidden = NO;
    [superView addSubview:self.placeholderView];
}

- (UIView *)setPlaceholderViewWithImage:(UIImage *)image
                                message:(NSString *)message
                            buttonTitle:(NSString *)title
                          centerOffsetY:(CGFloat)centerOffsetY {
    
    UIView *placeholderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,KScreenWidth, 250)];
    //centerOffsetY = centerOffsetY ? centerOffsetY : 64;
    placeholderView.center = CGPointMake(self.view.center.x, self.view.center.y-centerOffsetY);
    
    CGFloat imageVX = (placeholderView.frame.size.width - image.size.width)/2;
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(imageVX, 20, image.size.width, image.size.height)];
    imageV.image = image;
    [placeholderView addSubview:imageV];
    
    CGFloat msgLabW = 240;
    CGFloat msgLabX = (placeholderView.frame.size.width - msgLabW)/2;
    UILabel *msgLab = [[UILabel alloc]initWithFrame:CGRectMake(msgLabX, imageV.bottom + 5, msgLabW, 48)];
    msgLab.text = message;
    msgLab.font =  FontSize(14);
    msgLab.numberOfLines = 0;
    msgLab.textAlignment = NSTextAlignmentCenter;
    //msgLab.textColor =gary153;
    [placeholderView addSubview:msgLab];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(msgLabX, msgLab.bottom + 15, msgLabW, 50)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    [button setBackgroundColor:mainColor ];
    button.titleLabel.font =  FontBold(16);
    [button addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    button.hidden = title.length ? NO : YES;
    [placeholderView addSubview:button];
    placeholderView.hidden = YES;
    self.placeholderView = placeholderView;
    return self.placeholderView;
}

- (void)updatePlaceholderView {
    
    if (self.placeholderView.hidden == NO) {
        [self.placeholderView removeFromSuperview];
    }
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (NSMutableString *)webImageFitToDeviceSize:(NSMutableString *)strContent
{
    [strContent appendString:@"<html>"];
    [strContent appendString:@"<head>"];
    [strContent appendString:@"<meta charset=\"utf-8\">"];
    [strContent appendString:@"<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width*0.9,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\" />"];
    [strContent appendString:@"<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />"];
    [strContent appendString:@"<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />"];
    [strContent appendString:@"<meta name=\"black\" name=\"apple-mobile-web-app-status-bar-style\" />"];
    [strContent appendString:@"<style>img{width:100%;}</style>"];
    [strContent appendString:@"<style>table{width:100%;}</style>"];
    [strContent appendString:@"<title>webview</title>"];
    return strContent;
}

- (void)playBtnClick {
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:NO];
   
}

- (void)setNavLeftItemTitle:(NSString *)str andImage:(UIImage *)image {
//    if ([self.navigationController.viewControllers count] ==1){
        if ([str isEqualToString:@""] || !str)
        {
            UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
            self.navigationItem.leftBarButtonItem = leftItem;
        }
        else if(str&&image ){
            SXButton  * btn= [SXButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(-10, 0, 80, 20);
            [btn setTitle:str  forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"zhankai"] forState:UIControlStateNormal];
            UIBarButtonItem *LeftBarButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
            self.navigationItem.leftBarButtonItem =LeftBarButton;
            [btn addTarget:self action:@selector(location:) forControlEvents:UIControlEventTouchUpInside];
        }else if([str isEqualToString:@"返回"]){
            //创建一个UIButton
            UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 24)];
            backButton.adjustsImageWhenHighlighted = NO;
            //设置UIButton的图像
            [backButton setTitle:@"返回" forState:UIControlStateNormal];
            backButton.titleLabel.font = FontSize(15);
            backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
            backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            
            [backButton setImage:[UIImage imageNamed:@"Back Arrow Blue"] forState:UIControlStateNormal];
            //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
            [backButton addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
            //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
            //覆盖返回按键
            self.navigationItem.leftBarButtonItem = backItem;
        }
        else
        {
            UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
            self.navigationItem.leftBarButtonItem = leftItem;
        }
    }
//}
-(void)location :(id)sender{
}
- (void)setNavRightItemTitle:(NSString *)str andImage:(UIImage *)image
{
    if ([str isEqualToString:@""] || !str)
    {
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
       else
    {
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        [rightItem setTintColor:[UIColor whiteColor]];
        [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

- (void)rightItemClick:(id)sender {
    
}

- (void)leftItemClick:(id)sender{
    
}

- (void)setBackBarButtonItem {
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc] init];
    UIButton *btnleftView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    btnleftView.imageEdgeInsets =UIEdgeInsetsMake(0, -30, 0, 0);
    
    if ([self.navigationController.viewControllers count] > 1) {
        
        [btnleftView setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [btnleftView setContentMode:UIViewContentModeScaleAspectFit];
        [backItem  setCustomView:btnleftView];
        [btnleftView addTarget:self action:@selector(absPopNav) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = backItem;
        
    }
}

- (void)absPopNav {
    BOOL animated = YES;
    
    if (self.navigationController.viewControllers.count == 2) {
        animated = NO;
    }
    [self.navigationController popViewControllerAnimated:animated];
}

-(void)loadNewData {
    
}

-(void)loadMoreData {
    
}

//- (void)startLoading {
//    self.view.userInteractionEnabled =NO;
//    CGFloat navH = self.navigationController.navigationBar.hidden ? 64 : 0;;
//    UIView *loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 120)];
//    loadingView.center = CGPointMake(self.view.center.x, self.view.center.y-64+navH);
//    loadingView.backgroundColor = [UIColor clearColor];
//    
//    CGFloat imgVWidth = 60.f;
//    CGFloat imgVX     = (120-imgVWidth)/2.f;
//    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"]];
//    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(imgVX, imgVX, imgVWidth, imgVWidth)];
//    imageV.image = [UIImage sd_animatGIFWithData:gif];
//    [loadingView addSubview:imageV];
//    [self.view addSubview:loadingView];
//    self.loadingView = loadingView;
//
//}
- (void)startLoading {
   
   // CGFloat navH = self.navigationController.navigationBar.hidden ? 64 : 0;;
    UIView *loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64)];
 
    loadingView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.2];
    loadingView.backgroundColor = [UIColor clearColor];
    
    CGFloat imgVWidth = 45.f;
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"]];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imgVWidth, imgVWidth)];
    imageV.center=CGPointMake(loadingView.center.x, loadingView.center.y-64);
    imageV.image = [UIImage sd_animatGIFWithData:gif];
    [loadingView addSubview:imageV];
   [self.view addSubview:loadingView];
    
    self.loadingView = loadingView;
    
}

- (void)endLoading {
   // self.view.userInteractionEnabled = YES;
    self.loadingView.hidden = YES;
}

- (void)updateLoading {
    if (self.loadingView.hidden == NO) {
        [self endLoading];
        [self startLoading];
    } else {
        self.loadingView.hidden = NO;
        [self endLoading];
        [self startLoading];
    }
}

- (BOOL)isLogin {
    if([ball getStringById:@"load" fromTable:@"person"]){
         return YES;
    }
//    ABSUserModel *user = [ABSUserSession getUserModel];
//    if (user.Auth || user.PSP_CODE) {
//        return YES;
//    }
    LoginVC *loginVC = [[LoginVC alloc]init];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self presentViewController:loginVC animated:YES completion:nil];
   return NO;
}




- (float)getTextWidth:(float)textHeight text:(NSString *)text font:(UIFont *)font {
    if (!text.length) {
        return 0;
    }
    float origin = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, textHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.width;
    return ceilf(origin);
}

- (float)getTextHeight:(float)textWidth text:(NSString *)text font:(UIFont *)font {
    if (!text.length) {
        return 0;
    }
    float origin = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.height;
    return ceilf(origin);
}
-(void)requestType:(HttpRequestType)type
               url:(NSString *)url
        parameters:(NSDictionary *)parm
      successBlock:(RequestSuccess)success failureBlock:(RequestFail)failure{
    [SVProgressHUD show];
  
    appInfoModel * model = [appInfoModel yy_modelWithDictionary:[ball getObjectById:@"urlInfo" fromTable:@"person"]];
    NSMutableDictionary  * dic =[NSMutableDictionary    dictionaryWithDictionary:parm];
    
   [ dic addEntriesFromDictionary:@{
                                   @"client_id" : model.app_key,
                                   @"state" : model.seed_secret,
                                   @"access_token" :model.access_token,
                                   }];
    
    [RequestManager requestWithType:type
                          urlString:model.source_url
                         parameters:dic
                       successBlock:^(id response) {
        if(success){
            [SVProgressHUD dismissWithDelay:1.0f];
            BaseModel * model = [BaseModel yy_modelWithDictionary:response];
            DLog(@"%@",model);
            DLog(@"%@",response);
            DLog(@"%@",model.errmsg);
            DLog(@"%@",model.message);
            if(![model.errorno isEqualToString:@"0"]){
                [SVProgressHUD showErrorWithStatus:model.errmsg];
                [SVProgressHUD dismissWithDelay:1.0f];
            }
            success(model);
            }
            
        }
        
     failureBlock:^(NSError *error) {
        if(failure){
                 [SVProgressHUD dismissWithDelay:1.0f];
             [SVProgressHUD showErrorWithStatus:@"请求失败"];
            failure(error);
        }
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
-(void)initAppinfo{
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"group1");
        [self getInfo];
    });
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        [self registToken];
        NSLog(@"group 2");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3];
        [self getToken];
        NSLog(@"group3");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"update UI");
    });
    
}
-(void)getInfo{
    [ZKUDID setDebug:YES];
    NSString *UDID = [ZKUDID value];
    NSLog(@"UDID: %@",UDID);
    NSString *strEnRes = [CusMD5 md5String:UDID];
    NSLog(@"strEnRes: %@",strEnRes);
    
    [RequestManager requestWithType:HttpRequestTypePost urlString:@"http://smapi.baibaobike.com/authed/oauth.html" parameters:@{@"imei":UDID,@"code":strEnRes}
                       successBlock:^(id response) {
                           NSLog(@"response==%@",response);
                           NSDictionary *dic = [response    objectForKey:@"data"];
                           
                           [ball  putObject:dic  withId:@"urlInfo" intoTable:@"person"];
                           
                           //  [ball getObjectById:@"urlInfo" fromTable:@"person"];
                           
                           
                       } failureBlock:^(NSError *error) {
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
}

-(void)registToken{
    appInfoModel * model = [appInfoModel yy_modelWithDictionary: [ball getObjectById:@"urlInfo" fromTable:@"person"]];
    [RequestManager requestWithType:HttpRequestTypePost
                          urlString:model.authorize_url parameters:@{
                                                                @"response_type":@"code",
                                                                      @"client_id":model.app_key,
                                                                      @"state"    :model.seed_secret
                                                                                                   }
                       successBlock:^(id response) {
                           NSLog(@"response==%@",response);
                           NSMutableDictionary *dic  = [NSMutableDictionary   dictionaryWithDictionary:[ball getObjectById:@"urlInfo" fromTable:@"person"]];
                           [dic setObject:[[response objectForKey:@"data"] objectForKey:@"authorize_code"]forKey:@"authorize_code"];
                           
                           [ball putObject:dic withId:@"urlInfo" intoTable:@"person"];
                       } failureBlock:^(NSError *error) {
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
    
    
}

-(void)getToken{
    appInfoModel * model = [appInfoModel yy_modelWithDictionary: [ball getObjectById:@"urlInfo" fromTable:@"person"]];
    [RequestManager requestWithType:HttpRequestTypePost urlString:model.token_url parameters:@{
                                                                                               
                                                                    @"client_id":model.app_key,
                                                                    @"state"    :model.seed_secret,
                                                                   @"grant_type":@"authorization_code",
                                                                @"client_secret":model.app_secret,
                                                                         @"code":model.authorize_code,
                                                                                               }
                       successBlock:^(id response) {
                           NSLog(@"response==%@",response);
                           NSMutableDictionary *dic  = [NSMutableDictionary   dictionaryWithDictionary:[ball getObjectById:@"urlInfo" fromTable:@"person"]];
                           [dic setObject:[[response objectForKey:@"data"] objectForKey:@"access_token"]forKey:@"access_token"];
                           [dic setObject:[[response objectForKey:@"data"] objectForKey:@"refresh_token"]forKey:@"refresh_token"];
                           [ball putObject:dic withId:@"urlInfo" intoTable:@"person"];
                           
                           
                           
                       } failureBlock:^(NSError *error) {
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
    
    
    
}

@end
