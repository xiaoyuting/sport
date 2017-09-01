//
//  matchVideoVC.m
//  football
//
//  Created by 雨停 on 2017/8/16.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "matchVideoVC.h"
#import "sampleVideoCell.h"
#import "WMPlayer.h"
#import "AppDelegate.h"
#import "ShareView.h"
#import "JSHAREService.h"
#import "detailModel.h"
#import "matchViewModel.h"
@interface matchVideoVC ()<UITableViewDelegate,UITableViewDataSource,WMPlayerDelegate>
{
    WMPlayer  *wmPlayer;
    CGRect     playerFrame;
    BOOL isHiddenStatusBar;//记录状态的隐藏显示
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tabViewH;

@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (nonatomic,strong)UIImageView    * head;
@property (nonatomic,strong)UILabel        * Htitle;
@property (nonatomic,strong)UILabel        * HDtitle;
@property (nonatomic,strong)UILabel        * Htime;
@property (nonatomic,strong)UILabel        * Hnum;
@property (nonatomic,strong)UILabel        * Hpromot;
@property (nonatomic, strong) ShareView * shareView;
@property (nonatomic,strong)NSMutableArray  * arr;
@property (nonatomic,copy) NSString  * url;
@property (nonatomic,copy) NSString  * titleLab;
@property (nonatomic,copy) NSString  * timeLab;

@end

@implementation matchVideoVC
-(id)init{
    if(self = [super init]){
        self.URLString = [[NSString alloc]init];
    }
    return self;
}
-(void)sendRequest{
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{
                        @"action":@"getVideoDetail",
                        @"video_id":@"1"
}
         successBlock:^(BaseModel *response) {
             if([response.errorno isEqualToString:@"0"]){
                 detailModel * detail = response.data.detail;
                 self.Htitle.text  = detail.name;
                 self.titleLab =   detail.name;
                 self.HDtitle.text = detail.ctime;
                 self.URLString = detail.fileurl;
                 self.url=detail.fileurl ;
                 wmPlayer.URLString = self.URLString;
                 [wmPlayer play];
                 [self.arr addObjectsFromArray:response.data.other];
                 [self.tabView reloadData];
             }
             
         } failureBlock:^(NSError *error) {
             
         }];
}
- (void)viewDidLoad {
    [self sendRequest];
    self.automaticallyAdjustsScrollViewInsets =YES;
    [super viewDidLoad];
    self.arr = [NSMutableArray array];
    [self setPlayVideo];
    //测试代码
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"测试" message:@"关闭播放器" preferredStyle:UIAlertControllerStyleAlert];
//        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            
//        }]];
//        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            if (self.presentingViewController) {
//                
//                [self dismissViewControllerAnimated:YES completion:^{
//                    
//                }];
//            }else{
//                if (wmPlayer.isFullscreen) {//由于是push出来的，所以如果在全屏状态下，先转为非全屏（也就是人像模式Portrait）
//                    
//                    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
//                    [self toOrientation:UIInterfaceOrientationPortrait];
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [self.navigationController popViewControllerAnimated:YES];
//                    });
//                    
//                }else{
//                    [self.navigationController popViewControllerAnimated:YES];
//                }
//            }
//            
//        }]];
//        [self presentViewController:alertVC animated:YES completion:^{
//        }];
//    });
    
    self.tabView.autoresizingMask = NO;
    self.tabViewH.constant = kScaleHeight(250);
    self.tabView.tableHeaderView = [self headView];
    [self.tabView registerClass:[sampleVideoCell class] forCellReuseIdentifier:NSStringFromClass([sampleVideoCell class])];
}
-(void)setPlayVideo{
    playerFrame = CGRectMake(0, 64, KScreenWidth,  kScaleHeight(250) );
    
    wmPlayer = [[WMPlayer alloc]init];
    //wmPlayer = [[WMPlayer alloc]initWithFrame:playerFrame];
    
    wmPlayer.delegate = self;
    //wmPlayer.URLString = self.URLString;
    wmPlayer.titleLabel.text = self.title;
    wmPlayer.closeBtn.hidden = YES;
    
    [self.view addSubview:wmPlayer];
    
    [wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.equalTo(@(playerFrame.size.height));
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backView:(UIButton *)sender {
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        //present方式
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
//    if (self.presentingViewController) {
//          [self dismissViewControllerAnimated:YES completion:^{
//        
//        }];
//    }else{
//        [self.navigationController popViewControllerAnimated:YES];
//        
//    }

   // [self absPopNav];
}
- (IBAction)collect:(UIButton *)sender {
    if(sender.tag ==0){
        [sender setImage:Img(@"colC.png") forState:UIControlStateNormal];
        sender.tag=1;
    }else{
        [sender setImage:Img(@"no_colC.png") forState:UIControlStateNormal];
        sender.tag=0;
    }

}
- (IBAction)shear:(UIButton *)sender {
    [self.shareView showWithContentType:JSHARELink];
}




//常用
- (void)shareLinkWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    
    message.mediaType = JSHARELink;
    message.url = self.url;
    message.text = self.titleLab;
    message.title = @"数苗足球";
    message.platform = platform;
    NSString *imageURL = nil;//self.model.cover;
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 109;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self releaseWMPlayer];
    matchViewModel * model = self.arr[indexPath.row];
    NSLog(@"%@",model.fileurl);
    //self.URLString = model.fileurl;
    self.Htitle.text = model.name;
    self.titleLab  =model.name;
    [self setPlayVideo];
    [wmPlayer play];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    sampleVideoCell *cell = nil;
    cell = [tableView   dequeueReusableCellWithIdentifier:NSStringFromClass([sampleVideoCell class])];
    cell.model=self.arr[indexPath.row];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
}
-(UIView * )headView{
    UIView * head  = [[UIView alloc]initWithFrame:CGRectMake(0, 0,KScreenWidth, 128)];

   
    
    self.Htitle  = [[UILabel alloc]initWithFrame:CGRectMake(15, 8, KScreenWidth-30, 24)];
    [head addSubview:self.Htitle];
    
    self.HDtitle = [XYUIKit labelWithTextColor:KGrayColor numberOfLines:0 text:@"" fontSize:13];
    self.HDtitle .frame  = CGRectMake(15, 38, KScreenWidth-30, 18);
    [head addSubview:self.HDtitle];
    
    self.Htime = [XYUIKit labelWithTextColor:KGrayColor numberOfLines:0 text:@"" fontSize:13];
    self.Htime .frame  = CGRectMake(15,  62, KScreenWidth-100, 18);
    [head addSubview:self.Htime];
    self.Hnum = [XYUIKit labelWithTextColor:KGrayColor numberOfLines:0 text:@"" fontSize:13];
    self.Hnum .frame  = CGRectMake(KScreenWidth-80, 62,70 , 18);
    [head addSubview:self.Hnum];
    self.Hpromot = [XYUIKit labelWithTextColor:KGrayColor numberOfLines:0 text:@"相关视频" fontSize:21];
    self.Hpromot.font = FontBold(21);
    self.Hpromot .frame  = CGRectMake(15,  94,KScreenWidth-30 , 32);
    [head addSubview:self.Hpromot];
    
       return  head;
}

-(void)viewWillAppear:(BOOL)animated{
    AppDelegate * appdelegate   = (AppDelegate *) [UIApplication sharedApplication].delegate;
    appdelegate . allowRotation = YES;
    //获取设备旋转方向的通知,即使关闭了自动旋转,一样可以监测到设备的旋转方向
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];

    self.navigationController.navigationBar.hidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    AppDelegate * appdelegate   = (AppDelegate *) [UIApplication sharedApplication].delegate;
    appdelegate . allowRotation = NO;
    self.navigationController.navigationBar.hidden=NO;
    
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //对于present出来的控制器，要主动的更新一个约束，让wmPlayer全屏，更安全
    if (wmPlayer.isFullscreen==NO) {
        [wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.height));
            make.height.equalTo(@([UIScreen mainScreen].bounds.size.width));
            make.center.equalTo(wmPlayer.superview);
        }];
        wmPlayer.isFullscreen = YES;
        self.enablePanGesture = NO;
    }
    return UIInterfaceOrientationLandscapeRight;
}
///播放器事件
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    if (wmplayer.isFullscreen) {
        
        //强制翻转屏幕，Home键在下边。
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
        //刷新
        [UIViewController attemptRotationToDeviceOrientation];
        
        [wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).with.offset(64);
            make.left.equalTo(self.view).with.offset(0);
            make.right.equalTo(self.view).with.offset(0);
            make.height.equalTo(@(playerFrame.size.height));
        }];
        wmPlayer.isFullscreen = NO;
        self.enablePanGesture = YES;
    }else{
        [self releaseWMPlayer];
        if (self.presentingViewController) {
          //  [self dismissViewControllerAnimated:YES completion:^{
                
           // }];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
}
///播放暂停
-(void)wmplayer:(WMPlayer *)wmplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn{
    NSLog(@"clickedPlayOrPauseButton");
}
///全屏按钮
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (wmPlayer.isFullscreen==YES) {//全屏
        //强制翻转屏幕，Home键在下边。
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
          wmPlayer.closeBtn.hidden = NO;
        wmPlayer.isFullscreen = NO;
        self.enablePanGesture = YES;
        
    }else{//非全屏
          wmPlayer.closeBtn.hidden = YES;
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
        [self toOrientation:UIInterfaceOrientationLandscapeRight];
        wmPlayer.isFullscreen = YES;
        self.enablePanGesture = NO;
    }
}
///单击播放器
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    
}
///双击播放器
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"didDoubleTaped");
}
///播放状态
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidFailedPlay");
}
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    //    NSLog(@"wmplayerDidReadyToPlay");
}
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    NSLog(@"wmplayerDidFinishedPlay");
}
//操作栏隐藏或者显示都会调用此方法
-(void)wmplayer:(WMPlayer *)wmplayer isHiddenTopAndBottomView:(BOOL)isHidden{
    isHiddenStatusBar = isHidden;
    [self setNeedsStatusBarAppearanceUpdate];
}
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange:(NSNotification *)notification{
    if (wmPlayer==nil||wmPlayer.superview==nil){
        return;
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
            wmPlayer.isFullscreen = NO;
            self.enablePanGesture = NO;
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            [self toOrientation:UIInterfaceOrientationPortrait];
            wmPlayer.isFullscreen = NO;
            self.enablePanGesture = YES;
            
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            [self toOrientation:UIInterfaceOrientationLandscapeLeft];
            wmPlayer.isFullscreen = YES;
            self.enablePanGesture = NO;
            
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            [self toOrientation:UIInterfaceOrientationLandscapeRight];
            wmPlayer.isFullscreen = YES;
            self.enablePanGesture = NO;
        }
            break;
        default:
            break;
    }
}

//点击进入,退出全屏,或者监测到屏幕旋转去调用的方法
-(void)toOrientation:(UIInterfaceOrientation)orientation{
    if (orientation ==UIInterfaceOrientationPortrait) {//
          wmPlayer.closeBtn.hidden = YES;
        [wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).with.offset(64);
            make.left.equalTo(self.view).with.offset(0);
            make.right.equalTo(self.view).with.offset(0);
            make.height.equalTo(@(playerFrame.size.height));
        }];
    }else{
          wmPlayer.closeBtn.hidden = NO;
        [wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
            make.height.equalTo(@([UIScreen mainScreen].bounds.size.height));
            make.center.equalTo(wmPlayer.superview);
        }];
    }
}


- (void)releaseWMPlayer
{
    //堵塞主线程
    //    [wmPlayer.player.currentItem cancelPendingSeeks];
    //    [wmPlayer.player.currentItem.asset cancelLoading];
    [wmPlayer pause];
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [wmPlayer.autoDismissTimer invalidate];
    wmPlayer.autoDismissTimer = nil;
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
    wmPlayer = nil;
}
- (void)dealloc
{
    [self releaseWMPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"DetailViewController deallco");
}

@end
