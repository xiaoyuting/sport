//
//  starDetaileVC.m
//  football
//
//  Created by 雨停 on 2017/8/10.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "starDetaileVC.h"
#import "ShareView.h"
#import "JSHAREService.h"
#import "playersModel.h"
@interface starDetaileVC ()<UIWebViewDelegate>
@property (nonatomic, strong) ShareView * shareView;
@property (nonatomic, strong) playersModel * model;
@end

@implementation starDetaileVC
-(id)init{
    if(self = [super init]){
        self.playerID = [NSString string];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendRequest];
    self.title =@"球星详情";
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    [self setNavRightItemTitle:nil andImage:Img(@"shearW")];
    self.webView.scrollView.scrollEnabled=NO;
    self.webView.autoresizingMask= NO;
   }
- (void)leftItemClick:(id)sender{
    [self absPopNav];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGRect frame = self.webView.frame;
    frame.size.width=KScreenWidth-40;
    frame.size.height=1;
    self.webView.frame= frame;
    frame.size.height= self.webView.scrollView.contentSize.height;
 
    self.webHeight.constant  =frame.size.height;
    self.webView.frame =frame;

}
-(void)rightItemClick:(id)sender{
    if(![ball getStringById:@"load" fromTable:@"person"]){
        [SVProgressHUD showErrorWithStatus:@"需先登录"];
        [SVProgressHUD dismissWithDelay:1.0f];
        LoginVC *loginVC = [[LoginVC alloc]init];
        NavigationVC * navVC  = [[NavigationVC alloc]initWithRootViewController:loginVC];
        [self presentViewController:navVC animated:YES completion:nil];
        return;
    }else{
        [self.shareView showWithContentType:JSHARELink];
    }
    

}
-(void)sendRequest{
    [self requestType:HttpRequestTypePost url:nil
           parameters:@{@"action" : @"getRecommendPlayers",
                        @"id"     :self.playerID                       }
         successBlock:^(BaseModel *response) {
             if([response.errorno  isEqualToString:@"0"]){
                 NSArray * arr = response.data.players;
                 self.model = arr[0];
                 [self.startPhoto sd_setImageWithURL:imgUrl(self.model.cover_url) placeholderImage:Img(@"start")];
                 self.starName.text = self.model.name;
                 self.starTeam.text = self.model.team_name;
                 NSMutableString *str = [NSMutableString  stringWithFormat:@"%@", self.model.introduce];
                 [self.webView loadHTMLString:[self webImageFitToDeviceSize:str] baseURL:nil];
             }
         } failureBlock:^(NSError *error) {
             
         }];
}
//常用
- (void)shareLinkWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    NSString *imageURL = self.model.cover_url;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
    message.mediaType = JSHAREImage;
    message.platform = platform;
    message.image = imageData;
    
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        
    }];

//    JSHAREMessage *message = [JSHAREMessage message];
//    message.mediaType = JSHARELink;
//    message.url = @"";
//    message.text =self.starName.text;
//    message.title = self.starTeam.text;
//    message.platform = platform;
//    NSString *imageURL = self.model.cover_url;
//    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
//    
//    message.image = imageData;
//    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
//        
//        NSLog(@"分享回调");
//        
//        
//    }];
}
- (ShareView *)shareView {
    if (!_shareView) {
        _shareView = [ShareView getFactoryShareViewWithCallBack:^(JSHAREPlatform platform, JSHAREMediaType type) {
            //常用
            [self shareLinkWithPlatform:platform];
            
            
        }];
        [self.view addSubview:self.shareView];
    }
    return _shareView;
}
@end
