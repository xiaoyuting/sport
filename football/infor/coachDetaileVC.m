//
//  coachDetaileVC.m
//  football
//
//  Created by 雨停 on 2017/8/10.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "coachDetaileVC.h"
#import "ShareView.h"
#import "JSHAREService.h"
#import "detailModel.h"
#import "youthCell.h"
#import "SDAutoLayout.h"
#import "CollecCoachCell.h"
#import "coachesModel.h"
#import "classDetaileVC.h"
#import "coursesModel.h"
@interface coachDetaileVC ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) ShareView * shareView;
@property (nonatomic,strong)  detailModel  * detailModel;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayer;
@property (nonatomic,assign)  CGRect   newFrame;
@property (nonatomic,strong)  NSMutableArray     * course;
@property (nonatomic,strong) NSMutableArray      * arr;
@end

@implementation coachDetaileVC
-(id)init{
    if(self == [super init]){
        self.coachID =[NSString string];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubView];
    [self sendRequest];
}
-(void)setSubView{
    self.webView.autoresizingMask= NO;
    self.webView.scrollView.scrollEnabled=NO;
    self.webView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.viewwebBottom.autoresizingMask= NO;
    self.tabView.autoresizingMask =NO;
    self.collView.autoresizingMask =NO;
    self.course = [NSMutableArray    array];
    self.arr    = [NSMutableArray array];
    [self.tabView  registerClass:[youthCell class] forCellReuseIdentifier:NSStringFromClass([youthCell class])];
    self.flowLayer = [[UICollectionViewFlowLayout alloc]init];
    [self.flowLayer setScrollDirection:UICollectionViewScrollDirectionHorizontal  ];
    [self.collView setCollectionViewLayout:self.flowLayer];
    [self.collView registerClass:[CollecCoachCell class] forCellWithReuseIdentifier:@"cell"];
    
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tabHeight.constant =164*self.course.count;
    return self.course.count;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    classDetaileVC * Detaile = [[classDetaileVC alloc]init];
    coursesModel  * model  =self.course[indexPath.row];
    Detaile.infoID = model.id;
    [self absPushViewController:Detaile animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Class currentClass = [youthCell class];
    youthCell * cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.coachmodel = self.course[indexPath.row];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    NSLog(@"%f",[tableView cellHeightForIndexPath:indexPath model:self.course[indexPath.row] keyPath:@"coachmodel" cellClass:[youthCell class] contentViewWidth:[self cellContentViewWith]]);
    return [tableView cellHeightForIndexPath:indexPath model:self.course[indexPath.row] keyPath:@"coachmodel" cellClass:[youthCell class] contentViewWidth:[self cellContentViewWith]]-56;
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




//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
    return self.arr.count;
}

//设置元素内容
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =@"cell";
    CollecCoachCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.model =  self.arr[indexPath.row];
    return cell;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{  //top, left, bottom, right;
    UIEdgeInsets top = {0,20,0,20};
    return top;
}
/** 头部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    
    return CGSizeMake(0, 0);
}

/** 顶部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    
    return CGSizeMake(0, 0);
}

//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"%f",(kDeviceHeight-88-49)/4.0);
    return CGSizeMake((KScreenWidth-50)/2.0,(KScreenWidth-50)/2.0+8.5+52);//w+8.5+24
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    coachesModel * model = self.arr[indexPath.row];
    self.coachID = model.id;
    [self sendRequest];
    self.scrollerView.contentOffset = CGPointMake(0, 0);
    
}









-(void)webViewDidFinishLoad:(UIWebView *)webView{
   _newFrame = self.webView.frame;
   _newFrame.size.width=KScreenWidth-40;
   _newFrame.size.height=1;
    self.webView.frame=_newFrame;
   _newFrame.size.height= self.webView.scrollView.contentSize.height;
    self.webView.frame =_newFrame;
   
    if(_newFrame.size.height<100){
                    self.viewwebBottom.alpha =0;
                    self.viewwebBottomHeight.constant =5;
                    self.webHeight.constant  =_newFrame.size.height;
        [self.showBtn setTitle:@"收起" forState:UIControlStateNormal];
        [self.showBtn setTitleColor:KGrayColor forState:UIControlStateNormal];
        self.showBtn.tag=1;
                }else if(_newFrame.size.height>100){
                    self.webHeight.constant  =100;
                    self.viewwebBottom.alpha =1;
                    [self.showBtn setTitle:@"显示全部" forState:UIControlStateNormal];
                    [self.showBtn setTitleColor:mainColor forState:UIControlStateNormal];
                    self.showBtn.tag=0;
                    self.viewwebBottomHeight.constant =56;
                }

    

//    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
//     _newFrame = webView.frame;
//    _newFrame.size.height = actualSize.height;
//    _webView.frame = _newFrame;
//    NSLog(@"actualSize.height===%f",actualSize.height);
//        if(_newFrame.size.height<100){
//            self.viewwebBottom.hidden =YES;
//            self.viewwebBottomHeight.constant =0;
//            self.webHeight.constant  =_newFrame.size.height;
//        }else if(_newFrame.size.height>100){
//         
//        }
   }

-(void)sendRequest{
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{  @"action" : @"getCoachDetail",
                          @"id" : self.coachID
                          }
         successBlock:^(BaseModel *response) {
             if([response.errorno isEqualToString:@"0"]){
                 [self.course removeAllObjects];
                 [self.arr removeAllObjects];
                 self.detailModel = response.data.detail;
                 [self.cocahPhoto sd_setImageWithURL:imgUrl(self.detailModel.header_url) placeholderImage:Img(@"coach")];
                 self.coachName.text  = self.detailModel.name;
                 self.coachTeam.text = self.detailModel.team_name;
                 NSMutableString *str = [NSMutableString  stringWithFormat:@"%@", self.detailModel.introduce];
                 [self.webView loadHTMLString:[self webImageFitToDeviceSize:str] baseURL:nil];
                 [self.course addObjectsFromArray:response.data.course];
                 [self.tabView reloadData];
                 [self.arr addObjectsFromArray:response.data.other_coach];
                 if(self.arr.count!=0){
                     self.collHeight.constant =(KScreenWidth-50)/2.0+8.5+52+10;
                 }
                 [self.collView reloadData];
             }
             
         } failureBlock:^(NSError *error) {
             
         }];
 
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    }





-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;

}
- (IBAction)leaveBack:(UIButton *)sender {
    [self absPopNav];
}
- (IBAction)colloct:(UIButton *)sender {
    if(sender.tag ==0){
        [sender setImage:Img(@"colC.png") forState:UIControlStateNormal];
        sender.tag=1;
    }else{
        [sender setImage:Img(@"no_colC.png") forState:UIControlStateNormal];
        sender.tag=0;
    }

}
- (IBAction)shear:(UIButton *)sender {
    if(![ball getStringById:@"load" fromTable:@"person"]){
        [SVProgressHUD showErrorWithStatus:@"需先登录"];
        [SVProgressHUD dismissWithDelay:1.0f];
        LoginVC *loginVC = [[LoginVC alloc]init];
        NavigationVC * navVC  = [[NavigationVC alloc]initWithRootViewController:loginVC];
        [self presentViewController:navVC animated:YES completion:nil];        return;
    }else{
        [self.shareView showWithContentType:JSHARELink];
    }
    


}
- (IBAction)showText:(UIButton *)sender {
    if (sender.tag==0){
        self.webHeight.constant  =_newFrame.size.height;
        [sender setTitle:@"收起" forState:UIControlStateNormal];
        [sender setTitleColor:KGrayColor forState:UIControlStateNormal];
        sender.tag=1;
    }else{
        self.webHeight.constant  =100;
        [sender setTitle:@"显示全部" forState:UIControlStateNormal];
        [sender setTitleColor:mainColor forState:UIControlStateNormal];
        sender.tag=0;
    }
}
//常用
- (void)shareLinkWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    
    message.mediaType = JSHARELink;
    message.url = @"";
    message.text = self.coachName.text;
    message.title = self.coachTeam.text;
    message.platform = platform;
    NSString *imageURL =self.detailModel.header_url ;
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

@end
