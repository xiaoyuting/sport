//
//  classDetaileVC.m
//  football
//
//  Created by 雨停 on 2017/8/23.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "classDetaileVC.h"
#import "detailModel.h"
#import "inforleftCollectionCell.h"
#import "coursesModel.h"
#import "ShareView.h"
#import "JSHAREService.h"
#import "paySelectStyle.h"
#import "paySelectVC.h"
@interface classDetaileVC ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *Snum;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIImageView *photoCoach;
@property (weak, nonatomic) IBOutlet UILabel *coachName;
@property (weak, nonatomic) IBOutlet UILabel *coachDetaile;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UILabel *schoolName;
@property (weak, nonatomic) IBOutlet UILabel *playerAge;
@property (weak, nonatomic) IBOutlet UILabel *playerTime;
@property (weak, nonatomic) IBOutlet UILabel *playerAddress;
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webviewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeWeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceWeight;
@property (weak, nonatomic) IBOutlet UIButton *puinfoBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *collView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collviewHeight;
@property (nonatomic, strong) NSMutableArray  * arr;
@property (nonatomic, strong) ShareView * shareView;
@property (nonatomic, strong)  detailModel  * model;
@end

@implementation classDetaileVC
-(id)init{
    if(self == [super init]){
        self.infoID= [NSString string];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
    [self sendRequest];
}
-(void)setSubview{
    self.photoCoach.layer.cornerRadius=35.5;
    self.photoCoach.layer.masksToBounds=YES;
    self.arr = [NSMutableArray array];
    self.webview.autoresizingMask=NO;
    self.puinfoBtn.autoresizingMask = NO;
    self.collView.autoresizingMask=NO;
    self.webview.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
    UICollectionViewFlowLayout*flowLayer = [[UICollectionViewFlowLayout alloc]init];
    [flowLayer setScrollDirection:UICollectionViewScrollDirectionHorizontal  ];
    [self.collView setCollectionViewLayout:flowLayer];
    [self.collView registerClass:[inforleftCollectionCell class] forCellWithReuseIdentifier:@"cell"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGRect frame = self.webview.frame;
    frame.size.width=KScreenWidth-40;
    frame.size.height=1;
    self.webview.frame= frame;
    frame.size.height= self.webview.scrollView.contentSize.height;
    
    self.webviewHeight.constant  =frame.size.height;
    self.webview.frame =frame;
    
}
- (IBAction)backVC:(UIButton *)sender {
    [self absPopNav];
}
- (IBAction)shearinfo:(UIButton *)sender {
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
- (IBAction)pushOrder:(UIButton *)sender {
    paySelectVC * pay = [[paySelectVC alloc]init];
    pay.type = @"1";
    pay.typeID = self.infoID;
    pay.typePrice = self.model.sell_price;
    [self absPushViewController:pay animated:YES];
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
//    
//    message.mediaType = JSHARELink;
//    message.url = @"";
//    message.text = self.titleLab.text;
//    message.title = self.timeLab.text;
//    message.platform = platform;
//    NSString *imageURL =self.model.cover_url;
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


- (IBAction)collect:(UIButton *)sender {
   
}
-(void)sendRequest{
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{@"action" : @"getQxCourseDetail",
                        @"id" : self.infoID   }
         successBlock:^(BaseModel *response) {
             if([response.errorno isEqualToString:@"0"]){
                 [self.arr removeAllObjects];
             self. model = response.data.detail;
                 [self.pic sd_setImageWithURL:imgUrl(self.model.cover_url) placeholderImage:Img(@"")];
                 [self.photoCoach sd_setImageWithURL:imgUrl(self.model.coach_header) placeholderImage:Img(@"")];
                 self.titleLab.text =self.model.title;
                 self.timeLab.text = [NSString stringWithFormat:@"%@|%@",self.model.start_time,self.model.address];
                 self.coachName.text = self.model.coach_name;
                 self.coachDetaile.text =self. model.coach_team;
                 self.typeLab.text = [NSString stringWithFormat: @"U%@",self.model.level];
                 self.typeLab.autoresizingMask =NO;
                 self.typeLab.layer.borderWidth=1;
                 self.typeLab.layer.borderColor = mainColor.CGColor;
                 self.typeWeight.constant =[self getTextWidth:18 text:[NSString stringWithFormat: @"U%@",self.model.level] font:[UIFont systemFontOfSize:13]]+5;
                 if([self.model.status isEqualToString:@"3"]){
                     self.Snum.hidden=YES;
                     self.priceLab.hidden=YES;
                     self.puinfoBtn.hidden=YES;
                     self.btnHeight.constant  =0;
                     
                }else{
                    self.Snum.text = [NSString stringWithFormat:@"还剩%@个名额",self.model.surplus];
                     self.priceLab.text = [NSString stringWithFormat:@"¥%@年",self.model.sell_price];
                    self.priceLab.autoresizingMask= NO;
                    self.priceWeight.constant   = [self getTextWidth:24 text:[NSString stringWithFormat:@"¥%@年",self.model.sell_price] font:[UIFont systemFontOfSize:17]]+5;
                     [self.puinfoBtn setTitle:[NSString stringWithFormat:@"我要报名(¥%@/年)",self.model.sell_price] forState:UIControlStateNormal];
                }
                 
                 self.schoolName.text = self.model.content ;
                 self.playerAge.text  = self.model.recruit_students;
                 self.playerTime.text = self.model.schedules;
                 [self.webview   loadHTMLString:self.model.content baseURL:nil];
                 [self.arr addObjectsFromArray:response.data.other_course];
                 if(self.arr.count!=0){
                     self.collviewHeight.constant =(KScreenWidth-50)/2.0+83;
                     
                 }else{
                     self.collviewHeight.constant =0;
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
    inforleftCollectionCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
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
    return CGSizeMake((KScreenWidth-50)/2.0,(KScreenWidth-50)/2.0+73);//w+8.5+24
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    coursesModel * model = self.arr[indexPath.row];
    self.infoID= model.id;
    [self sendRequest];
    self.scrollerView.contentOffset = CGPointMake(0, 0);
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
    
}

@end
