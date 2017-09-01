//
//  myfooterInfoSet.m
//  football
//
//  Created by 雨停 on 2017/8/18.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "myfooterInfoSet.h"
#import "DPPopUpMenu.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import "LoginVC.h"
#import "NavigationVC.h"
static const float RealSrceenHight =  667.0;
static const float RealSrceenWidth =  375.0;
#define AdaptationH(x) x/RealSrceenHight*[[UIScreen mainScreen]bounds].size.height
#define AdaptationW(x) x/RealSrceenWidth*[[UIScreen mainScreen]bounds].size.width
#define AdapationLabelFont(n) n*([[UIScreen mainScreen]bounds].size.width/375.0f)
@interface myfooterInfoSet ()<DPPopUpMenuDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic,strong)  UIImagePickerController *imagePickerController;
@property (nonatomic,copy)  NSString  * legStyle;
@property (nonatomic,copy)  NSString  * sexStyle;
@property  (nonatomic,copy) NSString    * imgID;
@end

@implementation myfooterInfoSet

- (void)viewDidLoad {
   
    self.imgID =@"";
    self.name.text =@"";
    self.turename.text =@"";
    self.address.text =@"";
    self.age.text = @"";
    self.foot.text=@"";
    self.weight.text =@"";
    self.foot.text =@"";
    self.footage.text =@"";
    self.phone.text=@"";
    self.legStyle=@"";
    self.sexStyle=@"";
    
    self.pic.layer.cornerRadius =35.5;
    [super viewDidLoad];
    [self setSubview];
    [self setSubPhotos];
    [self getPersonInfo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)photoSelect:(UIButton *)sender {
    [self getPhoto];
    
}
- (IBAction)ageSelect:(UIButton *)sender {
    DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
    men.titleText=@"性别";
    men.delegate=self;
    men.tag=0;
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"保密",@"name",@"0", @"typeID",nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"男",@"name",@"1",@"typeID",  nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"女",@"name",@"2",@"typeID", nil];
    men.dataArray = [NSArray arrayWithObjects:dic1,dic2,dic3, nil];
    [men show];
}

- (IBAction)footSelect:(UIButton *)sender {
    DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
    men.titleText=@"惯用脚";
    men.tag=1;
    men.delegate=self;
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"左脚",@"name",@"1",@"typeID", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"右脚",@"name",@"2",@"typeID", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"左右均衡",@"name",@"3",@"typeID" , nil];
    men.dataArray = [NSArray arrayWithObjects:dic1,dic2,dic3, nil];
    [men show];
}
-(void)DPPopUpMenuCellDidClick:(DPPopUpMenu *)popUpMeunView withDic:(NSDictionary *)dic{
    
    //NSLog(@"%@",[dic objectForKey:@"name"]);
    
    if(popUpMeunView.tag==0){
        
        self.sexStyle = [dic objectForKey:@"typeID"];

        self.sex.text = [dic objectForKey:@"name"];
    }else if(popUpMeunView.tag==1){
        self.legStyle = [dic objectForKey:@"typeID"];
       self.foot.text = [dic objectForKey:@"name"];
    }else if(popUpMeunView.tag==2){
        self.age.text = [dic objectForKey:@"name"];
    }else if(popUpMeunView.tag==3){
        self.height.text = [dic objectForKey:@"name"];
    }else if(popUpMeunView.tag==4){
        self.weight.text = [dic objectForKey:@"name"];
    }else if(popUpMeunView.tag==5){
        self.footage.text =[dic objectForKey:@"name"];
    }

    
    
   
}

- (IBAction)replacephone:(UIButton *)sender {
}
- (IBAction)exit:(UIButton *)sender {
    
    [self initAppinfo];
    [ball deleteObjectById:@"load" fromTable:@"person"];
    [ball deleteObjectById:@"phoneNum" fromTable:@"person"];
    LoginVC * login = [[LoginVC alloc]init];
    login.exitBtn.alpha = 0;
    NavigationVC   * nav  = [[NavigationVC alloc]initWithRootViewController:login];
    [self  presentViewController:nav animated:YES completion:^{
        [kNotificationCenter postNotificationName:@"loadStatus" object:@"0"];
    }];

}
-(void)setSubview{
    self.title = @"账户设置";
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    [self setNavRightItemTitle:@"保存" andImage:nil];
   
    
}
-(void)leftItemClick:(id)sender{
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
-(void)rightItemClick:(id)sender{
 
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{
                       
                         @"action": @"saveBaseUserInfo",
                         @"truename": self.turename.text,
                        // @"birthday": ‘1990-01-01’,
                         @"sex": self.sexStyle,//0保密1男2女
                         @"height": self.height.text,
                         @"weight": self.weight.text,
                         @"leg": self.legStyle,// 惯用脚：1右脚2左脚3左右均衡
                         @"type": @"modify", //刚注册时完善个人信息此参数不填，其他情况必填
                         @"soccer_age":self.footage.text,
                         @"address":   self.address.text,
                         @"username":  self.name.text,
                         @"header"  :   self.imgID,
                         @"age"     :   self.age.text

                        }
         successBlock:^(BaseModel *response) {
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
 
-(UIView *)footView{
    UIView  * foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 80)];
    
    
    UIButton * exit = [[UIButton alloc]initWithFrame:CGRectMake(0, foot.top+16, 268, 46)];
    exit.centerX = KScreenWidth/2.0;
    [foot addSubview:exit];
    exit. backgroundColor = mainColor;
    exit. layer.cornerRadius = 4;
    [exit addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
    [exit setTitle:@"退出登录" forState:UIControlStateNormal];
    exit.titleLabel.font = FontSize(15);
    
    
    return foot;
    
}

- (IBAction)setfootAge:(UIButton *)sender {
    DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
    men.titleText=@"年龄";
    men.tag=2;
    men.delegate=self;
   
    NSString *path=[[NSBundle mainBundle] pathForResource:@"personfooter" ofType:@"plist"];
    men.dataArray =  [[NSArray arrayWithContentsOfFile:path] subarrayWithRange:NSMakeRange(0, 120)];
;
    

    [men show];
    

}
- (IBAction)setfootHeight:(UIButton *)sender {
    DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
    men.titleText=@"身高";
    men.tag=3;
    men.delegate=self;
    NSString *path=[[NSBundle mainBundle] pathForResource:@"personfooter" ofType:@"plist"];
    men.dataArray = [[NSArray arrayWithContentsOfFile:path] subarrayWithRange:NSMakeRange(60, 180)];
    [men show];

}
- (IBAction)setfootweight:(id)sender {
    DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
    men.titleText=@"体重";
    men.tag=4;
    men.delegate=self;
    NSString *path=[[NSBundle mainBundle] pathForResource:@"personfooter" ofType:@"plist"];
    men.dataArray =  [[NSArray arrayWithContentsOfFile:path] subarrayWithRange:NSMakeRange(30, 170)];
    [men show];
    

}
- (IBAction)setfootplayAge:(UIButton *)sender {
    DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
    men.titleText=@"球龄";
    men.tag=5;
    men.delegate=self;
    NSString *path=[[NSBundle mainBundle] pathForResource:@"personfooter" ofType:@"plist"];
    men.dataArray =  [[NSArray arrayWithContentsOfFile:path] subarrayWithRange:NSMakeRange(0, 50)];
    [men show];

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
        self.pic.image =image;
        [self upImage:image];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)getPersonInfo{
    [self requestType:HttpRequestTypePost
                  url:nil parameters:@{
                                       
                                       @"action":@"getUserInfo"
                                                               }
         successBlock:^(BaseModel *response) {
            if([response.errorno isEqualToString:@"0"]){
                self.name.text = response.data.username;
                self.turename.text =response.data.truename;
                self.height.text = response.data.height;
                self.weight.text = response.data.weight;
                
                if([response.data.leg isEqualToString:@"1"]){
                    self.foot.text = @"左脚";
                    self.legStyle =@"1";
                }
                else if([response.data.leg isEqualToString:@"2"]){
                self.foot.text = @"右脚";
                    self.legStyle =@"2";
                                                                           
                }else if([response.data.leg isEqualToString:@"3"]){
                self.foot.text = @"左右平衡";
                    self.legStyle =@"3";
                    }
                self.age.text =response.data.age;
                if([response.data.sex isEqualToString:@"0"]){
                    self.sex.text = @"保密";
                    self.sexStyle = @"0";
                }
                else if([response.data.sex isEqualToString:@"1"]){
                    self.sex.text = @"男";
                    self.sexStyle = @"1";
                    
                }else if([response.data.sex isEqualToString:@"2"]){
                    self.sex.text = @"女";
                    self.sexStyle  = @"2";
                }
                [self.pic sd_setImageWithURL:imgUrl(response.data.header_url) placeholderImage:nil];
                self.footage.text = response.data.soccer_age;
                self.phone.text = response.data.mobile;
                self.address.text =response.data.address;
                //self.clabe.text = response.data.
                
                                                                   }
                                                               } failureBlock:^(NSError *error) {
                                                                   
                                                               }];

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
                                    NSLog(@"%@",response);
                                    if([response    objectForKey:@"img_id"]){
                                        self.imgID =[response    objectForKey:@"img_id"];
                                    }
                                } failurBlock:^(NSError *error) {
                                    
                                } upLoadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                                    
                                }];
    
}

@end
