//
//  LCActivityViewController+UI.m
//  LCPlayerSDKConsumerDemo
//
//  Created by CC on 15/12/4.
//  Copyright © 2015年 CC. All rights reserved.
//

#import "LCActivityViewController+UI.h"
#import "LECActivityPlayerControl.h"
#import "AppDelegate.h"
#import "ShareView.h"
#import "JSHAREService.h"


@interface LCActivityViewController_UI ()<LECPlayerControlDelegate>

@property (nonatomic, strong) LECActivityPlayerControl * control;
@property (nonatomic, strong) UIView * lcPlayerView;
@property (nonatomic, strong) ShareView * shareView;
@property (nonatomic ,strong) NSArray   * shearArr;
@end

@implementation LCActivityViewController_UI
- (IBAction)shear:(UIButton *)sender {
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
//常用
- (void)shareLinkWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    
    message.mediaType = JSHARELink;
    message.url =[self.shearArr[0] objectForKey:@"live_url"];
    
    message.text = [self.shearArr[0] objectForKey:@"activityName"];
    message.title = [self.shearArr[0] objectForKey:@"description"];
    message.platform = platform;
    NSString *imageURL = [self.shearArr[0] objectForKey:@"coverImgUrl"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
    message.image = imageData;
    [JSHAREService share:message handler:^(JSHAREState state, NSError *error) {
        
        NSLog(@"分享回调");
        }];
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
- (void)viewDidLoad {
    [super viewDidLoad];
   // [self setSubview];
    [self senrequest];
    _control = [[LECActivityPlayerControl alloc] init];
//    // 在开启设备陀螺仪状态下是否允许自动转屏
    _control.enableGravitySensor = YES;
    // 设置在全屏状态下是否隐藏状态栏
    _control.hiddenStatusBarWhenFullScreen = YES;
    
    // 设置隐藏返回按钮，Defaule is NO
    _control.hiddenBackButton = NO;
    // 设置隐藏标题，Defaule is NO
    _control.hiddenMediaTitle = NO;
//     若后台设置logo则无需在本地设置
//    _control.loadingLogoImage = [UIImage imageNamed:@"logoTest@2x"];
    _control.delegate = self;
    _lcPlayerView = [_control createPlayerWithOwner:self frame:CGRectMake(0, 64, self.view.frame.size.width, 250)];
    _lcPlayerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [_control registerActivityLivePlayerWithId:self.activityId option:nil completed:^(BOOL success) {
        
    }];
    [self.view addSubview:_lcPlayerView];
}
-(void)setSubview{
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.title = @"直播详情";
    [self setNavRightItemTitle:nil andImage:Img(@"shearW")];
}
-(void)leftItemClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

//废弃播放器
- (void)dealloc{
    if (_control) {
        [_control destroyPlayer];
    }
}

#pragma mark - 设置是否自动转屏
- (BOOL)shouldAutorotate
{
    return _control.autoRotation;
}


#pragma mark - 转屏处理逻辑
- (void)viewWillLayoutSubviews
{
    CGRect frame = [_control shouldRotateToOrientation:(UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation];
   
    if (!CGRectIsEmpty(frame))
    {
        _lcPlayerView.frame = frame;
    }
}

#pragma mark - LECPlayerControlDelegate
- (void)lecPlayerControlDidClickBackBtn:(LECPlayerControl *)playerControl
{
    if (_control) {
        [_control destroyPlayer];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)lecPlayerControlDidCutView:(LECPlayerControl *)playerControl cutImage:(UIImage *)cutImge{
    UIImageWriteToSavedPhotosAlbum(cutImge, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [self showTips:msg];
}


// 获取状态栏状态
- (BOOL)prefersStatusBarHidden
{
    return _control.statusBarHiddenState;
}

#pragma mark - 按钮事件
- (IBAction)clickToBack:(id)sender
{
    //销毁播放器
    [_control destroyPlayer];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)senrequest{
    
    appInfoModel * model = [appInfoModel yy_modelWithDictionary:[ball getObjectById:@"urlInfo" fromTable:@"person"]];
    NSDictionary  * dic =@{
                           @"client_id"    : model.app_key,
                           @"state"        : model.seed_secret,
                           @"access_token" : model.access_token,
                         
                           @"action" : @"getLetvLiveList",
                           @"activity_id" : self.activityId,
                           };
        [RequestManager requestWithType:HttpRequestTypePost
                          urlString:model.source_url
                         parameters:dic
                       successBlock:^(id response){
                           NSLog(@"%@",response);
                           if([response objectForKey:@"data"]){
                               NSDictionary * data = [response objectForKey:@"data"];
                               if([data objectForKey:@"schedule"]){
                                   self.shearArr  = [data objectForKey:@"rows"];
                                   NSDictionary * dic = [data objectForKey:@"schedule"];
                                   self.leftteam.text = [dic objectForKey:@"home_team"];
                                   [self.leftImg sd_setImageWithURL:imgUrl( [dic objectForKey:@"home_logo"]) placeholderImage:nil];
                                   self.rightname.text = [dic objectForKey:@"away_team"];
                                   [self.rightImg sd_setImageWithURL:imgUrl([dic objectForKey:@"away_logo"]) placeholderImage:nil];
                                   self.name.text = [dic objectForKey:@"round"];
                                   self.time.text = [dic objectForKey:@"start_time"];
                                   
                               }
                            
                           }else{
                               
                                        }
                       }failureBlock:^(NSError *error) {
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];

}
-(void)viewWillAppear:(BOOL)animated  {
    AppDelegate * appdelegate   = (AppDelegate *) [UIApplication sharedApplication].delegate;
    appdelegate . allowRotation = YES;
    self.navigationController.navigationBar .hidden =YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    AppDelegate * appdelegate   = (AppDelegate *) [UIApplication sharedApplication].delegate;
    appdelegate . allowRotation = NO;
    self.navigationController .navigationBar .hidden =NO;
}
@end
