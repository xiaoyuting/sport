//
//  addPlayerVC.m
//  football
//
//  Created by 雨停 on 2017/8/1.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "addPlayerVC.h"
#import "DPPopUpMenu.h"
#import "ZYInputAlertView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
static const float RealSrceenHight =  667.0;
static const float RealSrceenWidth =  375.0;
#define AdaptationH(x) x/RealSrceenHight*[[UIScreen mainScreen]bounds].size.height
#define AdaptationW(x) x/RealSrceenWidth*[[UIScreen mainScreen]bounds].size.width
#define AdapationLabelFont(n) n*([[UIScreen mainScreen]bounds].size.width/375.0f)
@interface addPlayerVC ()<DPPopUpMenuDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic,strong)  UIImagePickerController *imagePickerController;
@property  (nonatomic,copy) NSString    * imgID;
@end

@implementation addPlayerVC
-(id)init{
    if(self = [super init]){
        self.from =[NSString string];
        self.dic = [NSDictionary  dictionary];
        self.teamId = [NSString string];
        
    }
    return self;
}
- (void)viewDidLoad {
    self.imgID = @"";
    
    [super viewDidLoad];
    [self setSubview];
    
    self.photoPic.layer.cornerRadius =35.5;
    [self setSubPhotos];
    // Do any additional setup after loading the view from its nib.
}
-(void)setSubview{
    if([self.from isEqualToString:@"new"]){
        self.title = @"添加新球员";
        
    }else{
        self.title = @"修改球员信息";
        self.playName.text = [self.dic objectForKey:@"name" ];
        self.posizition.text =[self.dic objectForKey:@"position"];
        self.num.text =[self.dic objectForKey:@"number"];
        [self.bottom  setTitle:@"确认修改" forState:UIControlStateNormal];
    }
    
    [self.photoPic sd_setImageWithURL:imgUrl([self.dic objectForKey:@"header_url"]) placeholderImage:Img(@"photoMe")];
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    
}
-(void)leftItemClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clinckInfo:(UIButton *)sender {
    if(sender.tag==0){
        [self getPhoto];
        
    }else if(sender.tag==1){
        __block typeof(self) weakSelf = self;

        ZYInputAlertView *alertView = [ZYInputAlertView alertView];
        alertView.placeholder = @"球员姓名" ;
        [alertView confirmBtnClickBlock:^(NSString *inputString) {
            
            weakSelf.self.playName.text = inputString;
         }];
        [alertView show];

        
    }else if(sender.tag==2){
        DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
        men.titleText=@"位置";
        men.delegate=self;
        men.tag=0;
        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"前锋",@"name",@"0",@"cellID",  nil];
        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"中锋",@"name",@"1",@"cellID",  nil];
        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"左边锋",@"name",@"2",@"cellID",  nil];
         NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"右边锋",@"name",@"2",@"cellID",  nil];
         NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys:@"中场",@"name",@"2",@"cellID",  nil];
         NSDictionary *dic6 = [NSDictionary dictionaryWithObjectsAndKeys:@"后卫",@"name",@"2",@"cellID",  nil];
         NSDictionary *dic7 = [NSDictionary dictionaryWithObjectsAndKeys:@"守门员",@"name",@"2",@"cellID",  nil];
        
        men.dataArray = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,dic7, nil];
        [men show];
  
    }else if(sender.tag==3){
        DPPopUpMenu *men=[[DPPopUpMenu alloc]initWithFrame:CGRectMake(0, 0, AdaptationW(270), AdaptationH(176))];
        men.titleText=@"号码";
        men.delegate=self;
        men.tag=1;
        NSString *path=[[NSBundle mainBundle] pathForResource:@"personfooter" ofType:@"plist"];
        men.dataArray =  [[NSArray arrayWithContentsOfFile:path] subarrayWithRange:NSMakeRange(0, 120)];
        ;
        [men show];
  
    }else if(sender.tag==4){
        
        if([self.from isEqualToString:@"new"]){
            
              [self setInfo:@{
                            @"action" :@"editMyTeam",
                            @"team_id":self.teamId,
                            @"name":self.playName.text ,
                            @"position":self.posizition.text,
                            @"number":self.num.text,
                            @"type":@"0",
                            @"header":self.imgID
                            }];
        }else{
             [self setInfo:@{
                            @"member_id":[self.dic objectForKey:@"id"],
                            @"action" :@"editMyTeam",
                            @"team_id":self.teamId,
                            @"name":self.playName.text ,
                            @"position":self.posizition.text,
                            @"number":self.num.text,
                            @"type":@"0",
                            @"header":self.imgID
                            }];
        }
        
    }
}
- (void)setInfo :(NSDictionary * )info{
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:info
         successBlock:^(BaseModel *response) {
             if([response.errorno  isEqualToString:@"0"]){
                 [self.playerInfodelegate   setPlayerInfo:@"player"];
                 [self.navigationController   popViewControllerAnimated:YES];
 
             }
             
         } failureBlock:^(NSError *error) {
         }];
}

-(void)DPPopUpMenuCellDidClick:(DPPopUpMenu *)popUpMeunView withDic:(NSDictionary *)dic{
    
    NSLog(@"%@",[dic objectForKey:@"name"]);
    if(popUpMeunView.tag==0){
        self.posizition.text =[dic objectForKey:@"name"];
    }else if(popUpMeunView.tag==1){
        self.num.text =[dic objectForKey:@"name"];
    }
    //NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary: self.arr[  [[dic objectForKey:@"cellID"] integerValue]]];
   // [d setValue:[dic objectForKey:@"name"] forKey:@"detaile"];
    
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
        self.photoPic.image =image;         //压缩图片
        [self upImage:image];
        //NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
        
        //保存图片至相册
        //  UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        //上传图片
        //  [self uploadImageWithData:fileData];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
