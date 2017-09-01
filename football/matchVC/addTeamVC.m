//
//  addTeamVC.m
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "addTeamVC.h"
#import "addTitleCell.h"
#import "addpersonCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "ZYInputAlertView.h"
#import "addPlayerVC.h"
#import "SDAutoLayout.h"
@interface addTeamVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,infoDicdelegate>
@property (nonatomic,strong) UITableView * myTab;
@property (nonatomic,strong) NSMutableArray * arr0;
@property (nonatomic,strong) NSMutableArray * arr1;
@property (nonatomic,strong) NSMutableArray * arr2;
@property (nonatomic,strong) NSMutableArray * arrGroup;
@property (nonatomic,strong)  UIImageView   * teamImg;
@property (nonatomic,strong)  NSMutableArray  * member;
@property (nonatomic,strong)  UIImagePickerController *imagePickerController;
@property (nonatomic,strong)  UILabel     * coach;
@property (nonatomic,strong)  UILabel     * assistsI;
@property (nonatomic,strong)  UILabel     * assistsII;
@property (nonatomic,strong)  UILabel     * team;
@property (nonatomic,copy)    NSString    * imgID;
@property (nonatomic,copy)    NSString    * photo;
@property (nonatomic,copy)    NSString    * typeSelect;

@property (nonatomic,copy)NSString * name;
@end

@implementation addTeamVC
-(id)init{
    if(self = [super init]){
        self.from =[NSString string];
        self.style = [NSString string];
    }
    return self;
}
- (void)viewDidLoad {
   // [self set];
    [self setSubPhotos];
    self.member =[NSMutableArray array];
    self.arr0 =[NSMutableArray array];
    self.arr1 =[NSMutableArray array];
    
    self.arr2 =[NSMutableArray array];
    
    self.arrGroup =[NSMutableArray array];
    
    [super viewDidLoad];
    [self requestviewfirstAppear];
    [self setSubview];
    // Do any additional setup after loading the view.
}
-(void)setSubview{
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.title = @"添加新球队";
    self.myTab = [[UITableView alloc]
initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64-44) style:UITableViewStylePlain];
    [self.view addSubview:self.myTab];
    self.myTab.delegate =self;
    self.myTab.dataSource =self;
    self.myTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myTab registerClass:[addTitleCell class] forCellReuseIdentifier:NSStringFromClass([addTitleCell class])];
    [self.myTab registerNib:[UINib nibWithNibName:@"addpersonCell" bundle:nil] forCellReuseIdentifier:@"addperson"];
    self.myTab.tableFooterView =[self setBottomView];
    self.myTab.tableHeaderView =[self setHeadView];
    UIButton  * btn =[XYUIKit buttonWithBackgroundColor:mainColor titleColor:KWhiteColor title:@"保存" fontSize:20];
    [btn addTarget:self action:@selector(baocunTeam) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, KScreenHeight-44-64, KScreenWidth, 44);
    [self.view addSubview:btn];
}

- (void)setInfo :(NSDictionary * )info{
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:info
         successBlock:^(BaseModel *response) {
             
         } failureBlock:^(NSError *error) {
}];

}
-(void)baocunTeam{
     [self upImage:self.teamImg.image];
     [self.navigationController popViewControllerAnimated:YES];

       }


-(void)leftItemClick:(id)sender{
    if([self.typeSelect isEqualToString:@"clearTeam"]){
        [self requestType:HttpRequestTypePost url:nil
               parameters:@{
                            @"action": @"delMyTeam",
                            @"team_id": self.style}
             successBlock:^(BaseModel *response) {
                [self.navigationController popViewControllerAnimated:YES];
                 
             } failureBlock:^(NSError *error) {
                 
             }];

    }else{
        [self.navigationController popViewControllerAnimated:YES];
 
    }
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return   self.arrGroup.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
        addpersonCell *cell =nil;
        cell = [tableView dequeueReusableCellWithIdentifier:@"addperson"];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
     
        cell.dic =self.arrGroup[indexPath.row];
        return cell;
  
   }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    view.layer.borderWidth=0.1;
    view . backgroundColor = KRgb(0.91, 0.91, 0.91);
    UILabel * lab = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KGrayColor textAlignment:NSTextAlignmentLeft numberOfLines:0 text:nil fontSize:13];
    [view addSubview:lab];
    lab.frame = CGRectMake(20, 8, 200, 32);
    
    
   
        lab.text =@"球员";
   
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section    {
    return 0.00001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section    {
    if(section==0){
    return 40;
    }
    return 0.00001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        addPlayerVC * play = [[addPlayerVC alloc]init];
        play.dic =self.arrGroup[indexPath.row];
        play.playerInfodelegate =self;
        play.teamId = self.style;
    
        [self.navigationController pushViewController:play animated:YES];
   
 }
-(UIView *)setBottomView{
    UIView * bottom = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 80)];
    bottom. backgroundColor = KRgb(0.91, 0.91, 0.91);
    UIButton  * btn =[XYUIKit buttonWithBackgroundColor:KClearColor titleColor:KGrayColor titleHighlightColor:KClearColor title:@"+添加新成员" fontSize:17];
    btn .frame = CGRectMake(40, 18, KScreenWidth-80, 44);
    btn.layer .borderWidth =1;
    btn.layer.borderColor =KGrayColor.CGColor;
    [bottom   addSubview:btn];
    [btn addTarget: self  action:@selector(writeInfo:) forControlEvents:UIControlEventTouchUpInside];
    return bottom  ;
}
- (void)writeInfo:(UIButton *)sender{
    addPlayerVC * play = [[addPlayerVC alloc]init];
    play.playerInfodelegate =self;
    play.from=@"new";
    play.teamId =self.style;
    [self.navigationController pushViewController:play animated:YES];
}
-(void)setPlayerInfo:(NSString *)str{
    self.from=str;
    [self requestplayerviewAppear];
}
-(UIView * )setHeadView{
    UIView * head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 322)];
    self. teamImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 71, 71)];
    self.teamImg.layer.cornerRadius =35.5;
    self.teamImg.layer.masksToBounds = YES;
    [head addSubview:self.teamImg];
    self.teamImg.image = Img(@"teamTag");
    UILabel * teamTag = [[UILabel alloc]initWithFrame:CGRectMake(105, 38, 80, 24)];
    teamTag.text = @"球队标志";
    [head addSubview:teamTag];
    UIImageView *right =[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth-40, 45, 8, 13)];
    right.image = Img(@"Arrow");
    [head addSubview: right];
    UIImageView * line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 101, KScreenWidth, 1)];
    line.image =Img(@"line");
    [head addSubview:line];
    UIButton *btn = [[UIButton    alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 102)];
    [btn addTarget:self action:@selector(selectphoto ) forControlEvents:UIControlEventTouchUpInside];
    [head addSubview:btn];
    UILabel * name1 = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KBlackColor textAlignment:NSTextAlignmentLeft numberOfLines:0 text:@"球队名字" fontSize:17];
    name1.frame = CGRectMake(16, 102, 70, 45);
    [head addSubview: name1];
    UIImageView * line2  = [[UIImageView alloc]init];
    line2.image =Img(@"line2");
    line2.frame = CGRectMake(0, 101, KScreenWidth, 1);
    [head addSubview:line2];
    self.team = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KGrayColor textAlignment:NSTextAlignmentRight numberOfLines:0 text:@"球队名" fontSize:17];
    self.team.frame = CGRectMake(name1.right, 102, KScreenWidth-122, 45);
    [head addSubview: self.team ];
    UIButton *btn0 = [[UIButton alloc]initWithFrame:CGRectMake(name1.right, 102, KScreenWidth-122, 45)];
    btn0.tag=0;
    [head addSubview:btn0];
   [btn0 addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView * line1  = [[UIImageView alloc]init];
    line1.image =Img(@"line2");
    line1.frame = CGRectMake(0, 146, KScreenWidth, 1);
    [head addSubview:line1];
    UIView *view = [[UIView  alloc]initWithFrame:CGRectMake(0, 147, KScreenWidth, 40)];
    view.layer.borderWidth=0.1;
    view . backgroundColor = KRgb(0.91, 0.91, 0.91);
    UILabel * lab = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KGrayColor textAlignment:NSTextAlignmentLeft numberOfLines:0 text:nil fontSize:13];
    [view addSubview:lab];
    lab.frame = CGRectMake(20, 8, 200, 32);
             lab.text =@"教练";
    [head addSubview:view];
    
    
    UILabel * name3 = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KBlackColor textAlignment:NSTextAlignmentLeft numberOfLines:0 text:@"主教练" fontSize:17];
    name3.frame = CGRectMake(16, 187, 70, 45);
    [head addSubview: name3];
    
    self.coach = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KGrayColor textAlignment:NSTextAlignmentRight numberOfLines:0 text:@"教练名" fontSize:17];
    self.coach.frame = CGRectMake(name1.right, 187, KScreenWidth-122, 45);
    [head addSubview: self.coach ];
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(name1.right,187, KScreenWidth-122, 45)];
    btn1.tag=1;
    [head addSubview:btn1];
        [btn1 addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView * line4 = [[UIImageView alloc]init];
    line4.image =Img(@"line2");
    line4.frame = CGRectMake(0, 231, KScreenWidth, 1);
    [head addSubview:line4];
    
    UILabel * name4 = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KBlackColor textAlignment:NSTextAlignmentLeft numberOfLines:0 text:@"助理教练" fontSize:17];
    name4.frame = CGRectMake(16, 232, 70, 45);
    [head addSubview: name4];
    
    self.assistsI = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KGrayColor textAlignment:NSTextAlignmentRight numberOfLines:0 text:@"教练名" fontSize:17];
    self.assistsI.frame = CGRectMake(name1.right, 232, KScreenWidth-122, 45);
    [head addSubview: self.assistsI ];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(name1.right, 232, KScreenWidth-122, 45)];
    btn2.tag=2;
    [head addSubview:btn2];
        [btn2 addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView * line5 = [[UIImageView alloc]init];
    line5.image =Img(@"line2");
    line5.frame = CGRectMake(0, 276, KScreenWidth, 1);
    [head addSubview:line5];
    
    UILabel * name5 = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KBlackColor textAlignment:NSTextAlignmentLeft numberOfLines:0 text:@"助理教练" fontSize:17];
    name5.frame = CGRectMake(16, 277, 70, 45);
    [head addSubview: name5];
    
    self.assistsII = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KGrayColor textAlignment:NSTextAlignmentRight numberOfLines:0 text:@"教练名" fontSize:17];
    self.assistsII.frame = CGRectMake(name1.right, 277, KScreenWidth-122, 45);
    [head addSubview: self.assistsII ];
    UIButton *btn3= [[UIButton alloc]initWithFrame:CGRectMake(name1.right, 277, KScreenWidth-122, 45)];
    btn3.tag=3;
    [head addSubview:btn3];
    [btn3 addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView * line6 = [[UIImageView alloc]init];
    line6.image =Img(@"line2");
    line6.frame = CGRectMake(0, 321, KScreenWidth, 1);
    [head addSubview:line6];
    
    return head;
}
-(void)selectphoto{
    [self getPhoto];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  //Dispose of any resources that can be recreated.
}

-(void)setSubPhotos{
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
}

#pragma 相机
- (void)selectImageFromCamera
{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
    _imagePickerController.videoMaximumDuration = 15;
    
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    
    _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}
#pragma 相册
- (void)selectImageFromAlbum
{
    //NSLog(@"相册");
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}
-(void)getPhoto {
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromAlbum];
    }];
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromCamera];
    }];
    UIAlertAction *act3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:act1];
    [alert addAction:act2];
    [alert addAction:act3];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma 代理方法

//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        //  [  setImage:info[UIImagePickerControllerEditedImage] forState:UIControlStateNormal];
        //如果是图片
        UIImage * image = info[UIImagePickerControllerEditedImage];
        self.teamImg.image =image;
       
        self.photo =@"11";
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)requestviewfirstAppear{
    appInfoModel * model = [appInfoModel yy_modelWithDictionary:[ball getObjectById:@"urlInfo" fromTable:@"person"]];
    if([self.from isEqualToString:@"setup"]){
        
        
        self.typeSelect = @"clearTeam";
        
        
        
        
        [self requestType:HttpRequestTypePost
                      url:nil
               parameters:@{ @"action"    : @"editMyTeam"}
             successBlock:^(BaseModel *response) {
                 self.style =response.team_id;
                 
             } failureBlock:^(NSError *error) {
                 
             }];
        
        
        
        
        return;
    }else{
        
        NSMutableDictionary  * dic =[NSMutableDictionary  dictionary];
        
        
        [ dic addEntriesFromDictionary:@{
                                         @"client_id" : model.app_key,
                                         @"state" : model.seed_secret,
                                         @"access_token" :model.access_token,
                                         @"action"    : @"getMyTeamDetail",
                                         @"team_id" : self.style
                                         
                                         
                                         }
         ];
        [RequestManager requestWithType:HttpRequestTypePost
                              urlString:model.source_url
                             parameters:dic
                           successBlock:^(id response){
                               NSLog(@"%@",response);
                               
                               
                               if([[response objectForKey:@"errno"] isEqualToString:@"0"]){
                                   NSDictionary * dic = [response objectForKey:@"data"];
                                   [self.arrGroup removeAllObjects];
                                   [self.arr0 removeAllObjects];
                                   [self.arr1 removeAllObjects];
                                   if([dic objectForKey:@"team_name"]){
                                       self.team.text = [dic objectForKey:@"team_name"];
                                   }
                                   if([dic objectForKey:@"coach"]){
                                       [self.arr0  addObjectsFromArray:[dic objectForKey:@"coach"]];
                                       NSDictionary *dic = self.arr0[0];
                                       self.coach.text = [ dic  objectForKey:@"name"];
                                   }
                                   if([dic objectForKey:@"assists"]){
                                       [self.arr1 addObjectsFromArray:[dic objectForKey:@"assists"]];
                                       for (int i=0; i<self.arr1.count; i++) {
                                           if(i==0){
                                               NSDictionary *dic = self.arr1[0];
                                               self.assistsI.text = [dic objectForKey:@"name"];
                                           }
                                           if(i==1){
                                               NSDictionary *dic = self.arr1[1];
                                               self.assistsII.text = [dic objectForKey:@"name"];
                                               
                                           }
                                       }
                                   }
                                   if(![self.photo isEqualToString:@"11"]){
                                       [self.teamImg  sd_setImageWithURL:imgUrl([dic objectForKey:@"logo_url"]) placeholderImage:nil];
                                       self.photo=@"22";
                                   }
                                   
                                   [self.arrGroup addObjectsFromArray:[[response   objectForKey:@"data"] objectForKey:@"player"]];
                                   
                                   
                                   [self.myTab reloadData];
                               }
                           }failureBlock:^(NSError *error) {
                               
                           } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                               
                           }];
        
        
        
    }

}

-(void)requestplayerviewAppear{
     appInfoModel * model = [appInfoModel yy_modelWithDictionary:[ball getObjectById:@"urlInfo" fromTable:@"person"]];
    NSMutableDictionary  * dic =[NSMutableDictionary  dictionary];
    
    
    [ dic addEntriesFromDictionary:@{
                                     @"client_id" : model.app_key,
                                     @"state" : model.seed_secret,
                                     @"access_token" :model.access_token,
                                     @"action"    : @"getMyTeamDetail",
                                     @"team_id" : self.style
                                     
                                     
                                     }
     ];
    [RequestManager requestWithType:HttpRequestTypePost
                          urlString:model.source_url
                         parameters:dic
                       successBlock:^(id response){
                           NSLog(@"%@",response);
                           
                           
                           if([[response objectForKey:@"errno"] isEqualToString:@"0"]){
                               NSDictionary * dic = [response objectForKey:@"data"];
                               [self.arrGroup removeAllObjects];
                               [self.arr0 removeAllObjects];
                               [self.arr1 removeAllObjects];
                               if([dic objectForKey:@"team_name"]){
                                   self.team.text = [dic objectForKey:@"team_name"];
                               }
                               if([dic objectForKey:@"coach"]){
                                   [self.arr0  addObjectsFromArray:[dic objectForKey:@"coach"]];
                                   NSDictionary *dic = self.arr0[0];
                                   self.coach.text = [ dic  objectForKey:@"name"];
                               }
                               if([dic objectForKey:@"assists"]){
                                   [self.arr1 addObjectsFromArray:[dic objectForKey:@"assists"]];
                                   for (int i=0; i<self.arr1.count; i++) {
                                       if(i==0){
                                           NSDictionary *dic = self.arr1[0];
                                           self.assistsI.text = [dic objectForKey:@"name"];
                                       }
                                       if(i==1){
                                           NSDictionary *dic = self.arr1[1];
                                           self.assistsII.text = [dic objectForKey:@"name"];
                                           
                                       }
                                   }
                               }
                               if(![self.photo isEqualToString:@"11"]){
                                   [self.teamImg  sd_setImageWithURL:imgUrl([dic objectForKey:@"logo_url"]) placeholderImage:nil];
                                   self.photo=@"22";
                               }
                               
                               [self.arrGroup addObjectsFromArray:[[response   objectForKey:@"data"] objectForKey:@"player"]];
                               
                               
                               [self.myTab reloadData];
                           }
                       }failureBlock:^(NSError *error) {
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
    

}

            
-(void)info:(UIButton *)sender {
                
                  __block typeof(self) weakSelf = self;
                if(sender.tag==0){
                  
                    ZYInputAlertView *alertView = [ZYInputAlertView alertView];
                    [alertView.confirmBtn setTitle:@"保存" forState:UIControlStateNormal];

                    alertView.placeholder = @"球队名" ;
                    
                    [alertView confirmBtnClickBlock:^(NSString *inputString) {
                        [weakSelf setInfo:@{    @"action"   :@"editMyTeam",
                                                @"team_id"  :self.style,
                                                @"team_name":inputString,
                                           
                                                }];
                    
                     
                       weakSelf.team.text = inputString;
                     
                    
                    }];
                    [alertView show];
                }else if(sender.tag==1){
                
                    ZYInputAlertView *alertView = [ZYInputAlertView alertView];
                    [alertView.confirmBtn setTitle:@"保存" forState:UIControlStateNormal];

                    alertView.placeholder = @"主教练名" ;
                    
                    [alertView confirmBtnClickBlock:^(NSString *inputString) {
                        if(self.arr0.count!=0){
                            NSDictionary * dic = self.arr0[0];
                            [weakSelf setInfo:@{@"action":@"editMyTeam",
                                                @"type":@"2",
                                                @"team_id":self.style,
                                                @"name":inputString,
                                                @"member_id":[dic objectForKey:@"id"]
                                                }];
                            
                            
                        }else{
                            [weakSelf setInfo:@{@"action":@"editMyTeam",
                                                @"type":@"2",
                                                @"team_id":self.style,
                                                @"name":inputString}];
                            
                            
                        }
                        self.coach.text = inputString;
                    }];
                      [alertView show];
                
                }
                
                
                else if(sender.tag==2){
                    ZYInputAlertView *alertView = [ZYInputAlertView alertView];
                    [alertView.confirmBtn setTitle:@"保存" forState:UIControlStateNormal];

                    alertView.placeholder = @"助理教练名" ;
                    
                    [alertView confirmBtnClickBlock:^(NSString *inputString) {
                        
                        if(self.arr1.count!=0){
                            
                    NSDictionary *dic = self.arr1[0];
                                [weakSelf setInfo:@{@"action":@"editMyTeam",
                                                    @"type":@"1",
                                                    @"team_id":self.style,
                                                    @"name":inputString,
                                                    @"member_id":[dic objectForKey:@"id"]
                                                    }];
                                
                         
                     
                    }else{
                        
                         [weakSelf setInfo:@{@"action":@"editMyTeam",
                                            @"type":@"1",
                                            @"team_id":self.style,
                                            @"name":inputString}];
                    }
                     
                        self.assistsI.text =inputString  ;
                        
                    }];
                      [alertView show];
                }else if(sender.tag==3){
                    ZYInputAlertView *alertView = [ZYInputAlertView alertView];
                    [alertView.confirmBtn setTitle:@"保存" forState:UIControlStateNormal];
                   alertView.placeholder = @"助理教练名" ;
                    
                    [alertView confirmBtnClickBlock:^(NSString *inputString) {
                        
                        if(self.arr1.count==2){
                            
                            NSDictionary *dic = self.arr1[1];
                            [weakSelf setInfo:@{@"action":@"editMyTeam",
                                                @"type":@"1",
                                                @"team_id":self.style,
                                                @"name":inputString,
                                                @"member_id":[dic objectForKey:@"id"]
                                                }];
                            
                            
                            
                        }else{
                            
                            [weakSelf setInfo:@{@"action":@"editMyTeam",
                                                @"type":@"1",
                                                @"team_id":self.style,
                                                @"name":inputString}];
                            
                        }
                           self.assistsII.text =inputString  ;
                        }];
                     [alertView show];
                }
    
            }
-(void)upImage:(UIImage *)image{
    appInfoModel * model = [appInfoModel yy_modelWithDictionary:[ball getObjectById:@"urlInfo" fromTable:@"person"]];
    
    NSDictionary  * dic =@{
                           @"client_id"    : model.app_key,
                           @"state"        : model.seed_secret,
                           @"access_token" : model.access_token,
                           @"action":@"uploadImg",
                           
                           
                           };
    
    [RequestManager uploadImageWithUrlString:model.source_url
                                  parameters: dic
                                  imageArray: @[image]
                                    fileName: @"image"
                                successBlock:^(id response) {
                                    if([response    objectForKey:@"img_id"]){
                                        self.imgID =[response    objectForKey:@"img_id"];
                                        
                                        [self setInfo:@{        @"action"   :@"editMyTeam",
                                                                @"team_id"  :self.style,
                                                                @"team_name":self.team.text,
                                                                @"logo"     : self.imgID
                                                                }];
                                    }
                                } failurBlock:^(NSError *error) {
                                    
                                } upLoadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                                    
                                }];
    
}

@end
