//
//  matchDetailVC.m
//  football
//
//  Created by 雨停 on 2017/7/26.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "matchDetailVC.h"
#import "sampleVideoCell.h"
#import "meCell.h"
#import "SDAutoLayout.h"
#import "sampleMatchCell.h"
#import "signupVC.h"
#import "zhiBoVC.h"
#import "dataAnalysisVC.h"
#import "ScheduleVC.h"
#import "partInVC.h"
#import "photoShowVC.h"
#import "appInfoModel.h"
#import "statusSmodel.h"
#import "photoShowCell.h"
#import "ShareView.h"
#import "JSHAREService.h"
#import "signUpinfoVC.h"
#import "matchVideoVC.h"
#import "matchViewModel.h"

@interface matchDetailVC ()<UITableViewDelegate,UITableViewDataSource ,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *bottomTab;
@property (weak, nonatomic) IBOutlet UITableView *myTab;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *tag;
@property (weak, nonatomic) IBOutlet UILabel *titleHead;
@property (weak, nonatomic) IBOutlet UILabel *timeadreess;
@property (nonatomic,strong)appInfoModel *model;
@property (nonatomic,strong)NSMutableArray * arr;
@property (nonatomic,strong)UILabel        * styleL;
@property (nonatomic,strong)UILabel        * numL;
@property (nonatomic,strong)UILabel        * numS;
@property (nonatomic,strong)UILabel        * price;
@property (nonatomic,strong)NSMutableArray * ZhiboArr;
@property (nonatomic,strong)NSMutableArray * bottomVideoArr;
@property (nonatomic,strong)NSMutableArray * picArr;
@property (nonatomic,strong)NSMutableArray * infoArr;

@property (nonatomic, strong) ShareView * shareView;
@end

@implementation matchDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setsubview];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)updateViewConstraints{
    [super updateViewConstraints];
   
}
-(void)setsubview{
    self.webView.userInteractionEnabled = NO;
    self.headView.frame = CGRectMake(0, 0, KScreenWidth, 400);
    self.infoArr    =  [NSMutableArray array];
    self.ZhiboArr   =  [NSMutableArray array];
    self.bottomVideoArr = [NSMutableArray array];
    self.picArr  = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets   = NO;
    self.styleL = [XYUIKit labelWithTextColor:mainColor numberOfLines:1 text:@" U16 " fontSize:13];
    self.styleL.layer.borderColor =mainColor.CGColor;
    self.styleL.layer.borderWidth =1;
    self.styleL.layer.cornerRadius=2;
    
    self.numL = [XYUIKit labelWithTextColor:mainColor numberOfLines:1 text:@" 11人制 " fontSize:13];
    self.numL.layer.borderColor =mainColor.CGColor;
    self.numL.layer.borderWidth =1;
    self.numL.layer.cornerRadius=2;
    self.numS = [XYUIKit labelWithTextColor:KGrayColor numberOfLines:1 text:@"还剩999个名额" fontSize:13];
    
    self.price = [XYUIKit labelWithTextColor:KmainRed numberOfLines:1 text:@"¥999999" fontSize:17];
    self.price.textAlignment  = NSTextAlignmentRight;
    
    self.arr = [NSMutableArray array];
   
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    [self.myColl setCollectionViewLayout:layout];
    [self.myColl registerClass:[photoShowCell class] forCellWithReuseIdentifier:@"cell"];
    //注册头视图
    [self.myColl registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];
    
    [self.myTab registerClass:[meCell class] forCellReuseIdentifier:NSStringFromClass([meCell class])];
    [self.myTab registerNib:[UINib nibWithNibName:@"sampleMatchCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([ sampleMatchCell class])];
    self.tag.layer.cornerRadius = 11.25;
    self.tag.layer.masksToBounds=YES;
    [self.bottomTab  registerClass:[sampleVideoCell class] forCellReuseIdentifier:NSStringFromClass([sampleVideoCell class])];
}
-(void)setHeadViewlayer{
    [self.headView sd_addSubviews:@[self.styleL,self.numL,self.price,self.numS]];
    

    self.styleL.sd_layout
    .leftSpaceToView(self.headView, 20)
    .bottomSpaceToView(self.headView, 25)
    .heightIs(18);
    [self.styleL setSingleLineAutoResizeWithMaxWidth:80];
    
    self.numL.sd_layout
    .leftSpaceToView(self.styleL, 8)
    .centerYEqualToView(self.styleL)
    .heightIs(18);
    [self.numL setSingleLineAutoResizeWithMaxWidth:80];
    
    self.price.sd_layout
    .rightSpaceToView(self.headView, 20)
    .heightIs(24)
    //.widthIs(100)
    .centerYEqualToView(self.styleL);
    [self.price setSingleLineAutoResizeWithMaxWidth:200];
    
    
    self.numS.sd_layout
    .rightSpaceToView(self.price,6 )
    .heightIs(18)
    .centerYEqualToView(self.styleL);
    [self.numS setSingleLineAutoResizeWithMaxWidth:200];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([tableView isEqual:self.myTab]){
        if(self.infoArr.count==2){
        if(section==1){
            NSArray * arr = self.infoArr[1];
           
            return arr.count;
        }else if(section==0){
            self.myTab.autoresizesSubviews =NO;
            NSArray * arr = self.infoArr[0];
            self.headTabHeight.constant =578+arr.count*80;
            return arr.count;
          }
        }else{
            NSArray * arr = self.infoArr[0];
            return arr.count;
        }
}else if([tableView isEqual:self.bottomTab]){
    
    self.bottomTab.autoresizesSubviews=NO;
    self.bottomTabHeight.constant =self.bottomVideoArr.count*110+60;
        return self.bottomVideoArr.count;
    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForheaderInSection:(NSInteger)section {
    return 0.0001;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([tableView isEqual:self.myTab]){
        return self.infoArr.count;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView isEqual:self.myTab]){
        if(self.infoArr.count==2){
        
        if(indexPath.section==1){
            return 44;
        }else{
            return 80;
          }
         }else{
            return 44;
        }
    }else if([tableView isEqual:self.bottomTab]){
        return 110;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView isEqual:self.myTab]){
        
        if(self.infoArr.count==2){
        if(indexPath.section==1){
            meCell * cell =nil;
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([meCell class])];
            NSArray   * arr = self.infoArr[indexPath.section];
            cell.dic =  arr[indexPath.row];
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            return  cell;
            
        }else {
            sampleMatchCell     * cell =nil;
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([sampleMatchCell   class])];
            NSArray   * arr = self.infoArr[indexPath.section];
             cell.model =  arr[indexPath.row];
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            return  cell;
        }
           }else{
            meCell * cell =nil;
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([meCell class])];
            NSArray   * arr = self.infoArr[indexPath.section];
            cell.dic =  arr[indexPath.row];
            cell.selectionStyle  = UITableViewCellSelectionStyleNone;
            return  cell;
        }
    }else if([tableView isEqual:self.bottomTab]){
        sampleVideoCell *cell = nil;
        cell = [tableView   dequeueReusableCellWithIdentifier:NSStringFromClass([sampleVideoCell class])];
        cell.model=self.bottomVideoArr[indexPath.row];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView isEqual:self.myTab]){
         if(self.infoArr.count==2){
        if (indexPath.section==0) {
            zhiBoVC *zhibo = [[zhiBoVC alloc]init];
            [self.navigationController pushViewController:zhibo animated:YES];
            
        }else if(indexPath.section==1){
            if(indexPath.row==1){
                 if([self.model.statusV isEqualToString:@"报名中"]){
                dataAnalysisVC * analysis = [[dataAnalysisVC alloc]init];
                      analysis.matchID =self.model.id;
                     [self.navigationController pushViewController:analysis animated:YES];
                 }
            } else if(indexPath.row==2){
                 if([self.model.statusV isEqualToString:@"报名中"]){
               ScheduleVC * Schedule = [[ScheduleVC alloc]init];
                Schedule.idTag  =self.model.id;
                [self.navigationController pushViewController:Schedule animated:YES];
                 }
            }else{
        partInVC *  partIn = [[ partInVC alloc]init];
        partIn.idTag  =self.model.id;
        [self.navigationController pushViewController: partIn animated:YES];
                
            }
           }
         }else{
             if(indexPath.row==1){
                 if(![self.model.statusV isEqualToString:@"报名中"]){
                 dataAnalysisVC * analysis = [[dataAnalysisVC alloc]init];
                 analysis.matchID =self.model.id;
                 [self.navigationController pushViewController:analysis animated:YES];
              }
             } else if(indexPath.row==2){
                  if(![self.model.statusV isEqualToString:@"报名中"]){
                 ScheduleVC * Schedule = [[ScheduleVC alloc]init];
                 Schedule.idTag  =self.model.id;
                 [self.navigationController pushViewController:Schedule animated:YES];
                  }
             }else{
                 partInVC *  partIn = [[ partInVC alloc]init];
                 partIn.idTag  =self.model.id;
                 [self.navigationController pushViewController: partIn animated:YES];
                 
             }
 
         }
    }else if([tableView isEqual:self.bottomTab]){
        matchVideoVC  * vc = [[matchVideoVC alloc]init];
        matchViewModel * model = self.bottomVideoArr[indexPath.row];
        vc.URLString = model.fileurl;
        [self.navigationController pushViewController:vc animated:YES];

//        zhiBoVC *zhibo = [[zhiBoVC alloc]init];
//        [self.navigationController pushViewController:zhibo animated:YES];
   }
 }


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSDictionary   * dic =@{
    @"action" : @"getMatchDetail",
    @"id" : self.idTag
    };
   // @"view_img" : @"1",  //选填 为1时显示全部赛事图片，不填默认显示4张
   // @"view_video" : @"1",};
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:dic
         successBlock:^(BaseModel *response) {
             [self.infoArr removeAllObjects];
             [self.picArr    removeAllObjects];
             [self.bottomVideoArr removeAllObjects];
            // NSArray * arr1 = response.data.match_imgs;
             NSString *  num= [NSString  string];
             self.model =response.data;
             if([self.model.surplus isEqualToString:self.model.quota]){
                 num=[NSString stringWithFormat:@"0/%@",self.model.quota];
             }else{
                 int a = [self.model.quota intValue]-[self.model.surplus intValue];
             
                 num = [NSString stringWithFormat:@"%d/%@",a,self.model.quota];
             }
             NSArray * arrInfo = @[
                                   @{@"title":@"参赛球队",@"detaile":num,@"img":@"Steam"},
                                   @{@"title":@"数据分析",@"detaile":@"",@"img":@"Analysis"},
                                   @{@"title":@"赛程表",@"detaile":@"",@"img":@"Schedule"}
                                   ];
             NSArray * arr2 = response.data.schedule;
             [self.bottomVideoArr  addObjectsFromArray: response.data.match_video];
             [self.picArr removeAllObjects];
             [self.picArr addObjectsFromArray:self.model.match_imgs];
             if(self.picArr.count==0){
                 self.myColl.autoresizingMask = NO;
                 self.mycollHeight.constant = 0;
                 self.myColl.alpha = 0;

             }else{
                 self.myColl.autoresizingMask = NO;
                 self.mycollHeight.constant = (KScreenWidth-60)/3.0+30;
                 self.myColl.alpha = 1;
             }
             self.tag.text =response.data.statusV;
             self.titleHead.text =response.data.name;
             self.timeadreess.text = [NSString stringWithFormat:@"%@至%@|%@",self.model.start_time,self.model.end_time,self.model.address];
             self.numL.text =[NSString stringWithFormat:@" %@ ",self.model.typeV];
             self.numS.text = [NSString stringWithFormat:@"还剩%@个名额",self.model.surplus];
             self.styleL.text = [NSString stringWithFormat:@" %@ ",self.model.levelV];
             self.price.text= [NSString stringWithFormat:@"¥%@",self.model.sell_price];
             [self setHeadViewlayer];
             [self.infoArr insertObject:arrInfo atIndex:0];
             if (![response.data.statusV isEqualToString:@"报名中"]){
                 self.bottomBtn.autoresizingMask = NO;
                 self.bottomButHeight.constant   = 0;
                 self.bottomBtn.alpha=0;
             }
            
             [self.bottomBtn setTitle: [NSString stringWithFormat:@"我要报名（¥%@)",self.model.sell_price] forState:UIControlStateNormal];
             [self.headImg sd_setImageWithURL:[NSURL URLWithString:self.model.cover] placeholderImage:nil];
             if([self.model.statusV isEqualToString:@"报名中"]){
                 _tag.backgroundColor = mainColor ;
             }else if([self.model.statusV isEqualToString:@"进行中"]){
                 self.numS.hidden =YES;
                 self.price.hidden=YES;
                 _tag.backgroundColor = KRgb(0.35, 0.78, 0.98) ;
             }else{
                 self.numS.hidden =YES;
                 self.price.hidden=YES;
                 _tag.backgroundColor = RGBColor(204, 204, 204) ;
             }
             self.webView.autoresizingMask= NO;
             [self.webView loadHTMLString:self.model.descrip baseURL:nil];
             
             if(arr2.count!=0){
                 [self.infoArr insertObject:arr2 atIndex:0];
             }
            
             [self.myTab     reloadData];
             [self.myColl    reloadData];
             [self.bottomTab reloadData];
         } failureBlock:^(NSError *error) {
             
         }];

    self.navigationController.navigationBar.hidden=YES;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGRect frame = self.webView.frame;
    frame.size.width=KScreenWidth-20;
    frame.size.height=1;
    self.webView.frame= frame;
    frame.size.height= self.webView.scrollView.contentSize.height;
    self.webView.autoresizingMask= NO;
    self.webHeight.constant  =frame.size.height;
   
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
}
- (IBAction)backRootView:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    if(![ball getStringById:@"load" fromTable:@"person"]){
        [SVProgressHUD showErrorWithStatus:@"需先登录"];
        [SVProgressHUD dismissWithDelay:1.0f];
        LoginVC *loginVC = [[LoginVC alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }else{
        [self.shareView showWithContentType:JSHARELink];
    }
    
}




//常用
- (void)shareLinkWithPlatform:(JSHAREPlatform)platform {
    JSHAREMessage *message = [JSHAREMessage message];
    
    message.mediaType = JSHARELink;
    message.url = @"";
    message.text =  self.timeadreess.text;
    message.title = self.titleHead.text;
    message.platform = platform;
    NSString *imageURL = self.model.cover;
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


- (IBAction)pushInfo:(UIButton *)sender {
    if(![ball getStringById:@"load" fromTable:@"person"]){
        [SVProgressHUD showErrorWithStatus:@"需先登录"];
        [SVProgressHUD dismissWithDelay:1.0f];
        LoginVC *loginVC = [[LoginVC alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self presentViewController:loginVC animated:YES completion:nil];
        return;
    }else{
    signUpinfoVC * sign = [[signUpinfoVC alloc]init];
    sign.tagID =self.idTag;
    [self.navigationController pushViewController:sign animated:YES];
    }
//    signupVC * sign = [[signupVC alloc]init];
//    sign.tagID =self.idTag;
//    [self.navigationController pushViewController:sign animated:YES];
}
- (void)getPhoto {
    photoShowVC * photo = [[photoShowVC alloc]init];
    photo.arr =self.picArr;
    [self.navigationController pushViewController:photo animated:YES];
}
-(id)init{
    if(self = [super init]){
        self.idTag =[NSString string];
    }
    
    return self;
}
//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.picArr.count;
}
//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                            withReuseIdentifier:@"UICollectionViewHeader"
                                                                                   forIndexPath:indexPath];
    
    UILabel  * lab = [XYUIKit labelWithTextColor:KBlackColor numberOfLines:0 text:@"赛事图片" fontSize:21];
    lab.font =FontBold(21);
    lab.frame =CGRectMake(20, 0, 0.4*KScreenWidth, 30);
    [headView addSubview:lab];
    
    UIButton * btn = [XYUIKit buttonWithBackgroundColor:KClearColor titleColor:mainColor title:@"更多图片" fontSize:17];
    btn.frame = CGRectMake(KScreenWidth-120, 0, 100, 30);
    btn.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentRight;
    [headView addSubview:btn];
    [btn addTarget:self action:@selector(getPhoto) forControlEvents:UIControlEventTouchUpInside];
    return headView;
}
//设置元素内容
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =@"cell";
    
    photoShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.model =self.picArr[indexPath.row];
    
    return cell;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{  //top, left, bottom, right;
    UIEdgeInsets top = {0,20,0,20};
    return top;
}
/** 头部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    
    return CGSizeMake(KScreenWidth,30);
}
/** 顶部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    
    return CGSizeMake(0, 0);
}

//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"%f",(kDeviceHeight-88-49)/4.0);
    return CGSizeMake((KScreenWidth-60)/3.0,(KScreenWidth-60)/3.0);
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    //    DetailVideoViewController *detailVC = [[DetailVideoViewControlleralloc]init];
    //    [self.navigationControllerpushViewController:detailVCanimated:YES];
    //    [detailVC release];
}

@end
