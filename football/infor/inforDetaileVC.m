//
//  inforDetaileVC.m
//  football
//
//  Created by 雨停 on 2017/8/10.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "inforDetaileVC.h"
#import "ShareView.h"
#import "JSHAREService.h"
#import "detailModel.h"
#import "leftYouthCell.h"
#import "SDAutoLayout.h"
#import "newsModel.h"
#import "commentsModel.h"
#import "myMessageCell.h"
#import "commentsVC.h"
@interface inforDetaileVC ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) ShareView * shareView;
@property (nonatomic, strong) NSMutableArray  * arr ;
@property (nonatomic, strong) detailModel     * model;
@property (nonatomic, strong)NSMutableArray   * arrCom;
@end

@implementation inforDetaileVC
-(id)init{
    if(self = [super init]){
        self.infoID = [NSString string];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr    = [NSMutableArray array];
    self.arrCom = [NSMutableArray array];
    self.webView.autoresizingMask  = NO;
    self.infoTab.autoresizingMask  = NO;
    self.commentTab.autoresizingMask = NO;
    [self.commentTab registerClass:[myMessageCell class] forCellReuseIdentifier:NSStringFromClass([myMessageCell class])];
    [self.infoTab registerClass:[leftYouthCell class] forCellReuseIdentifier:NSStringFromClass([leftYouthCell class])];
    [self sendRequest];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)leaveVC:(UIButton *)sender {
    [self absPopNav];
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
        NavigationVC * navVC  = [[NavigationVC alloc]initWithRootViewController:loginVC];
        [self presentViewController:navVC animated:YES completion:nil];
        return;
    }else{
        [self.shareView showWithContentType:JSHARELink];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView==self.infoTab){
        return [tableView cellHeightForIndexPath:indexPath
                                           model:self.arr[indexPath.row]
                                         keyPath:@"modelcenter"
                                       cellClass:[leftYouthCell class]
                                contentViewWidth:[self cellContentViewWith]];
    }else{
        
        return [tableView cellHeightForIndexPath:indexPath
                                           model:self.arrCom[indexPath.row]
                                         keyPath:@"model"
                                       cellClass:[myMessageCell class]
                                contentViewWidth:[self cellContentViewWith]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView==self.infoTab){
         return self.arr.count;
    }else{
          return  self.arrCom.count;
    }
   
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==self.infoTab){

    leftYouthCell * cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([leftYouthCell class])];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.modelcenter  =self.arr[indexPath.row];
        return cell;}
    else{
        myMessageCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([myMessageCell class])];
        cell.model =self.arrCom[indexPath.row];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    newsModel *model  =self.arr[indexPath.row];
    self.infoID = model.id;
    [self sendRequest];
    self.Scroller.contentOffset = CGPointMake(0, 0);
   }
- (IBAction)comment:(UIButton *)sender {
    commentsVC * vc = [[commentsVC alloc]init];
    vc.commentID =self.model.id;
    [self.navigationController  pushViewController:vc animated:YES];

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
//    message.text = self.model.title;
//    message.title = self.timeLab.text;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
    
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
-(void)sendRequest{
    [self requestType:HttpRequestTypePost url:nil
           parameters:@{ @"action" : @"getNewsDetail",
                          @"id" : self.infoID  }
         successBlock:^(BaseModel *response) {
             if([response.errorno isEqualToString:@"0"]){
                 [self.arr removeAllObjects];
                self.model = response.data.detail;
                 [self.pic sd_setImageWithURL:imgUrl(self.model.cover_url) placeholderImage:Img(@"")];
                 self.titleLab.text = self.model.title;
                 self.timeLab.text = [NSString stringWithFormat:@"%@|%@",self.model.ctime,self.model.cate_name];
                 //[self.photo sd_setImageWithURL:imgUrl(model.) placeholderImage:<#(nullable UIImage *)#>]
                 self.nameLab.text = self.model.author;
                 [self.webView loadHTMLString:self.model.body baseURL:nil];
                 [self.arr addObjectsFromArray:response.data.other_news];
                 if(self.arr.count!=0){
                    self.infoTabHeight.constant = self.arr.count*142;
                 }else{
                    self.infoTabHeight.constant = 0;
                 }
                 [self.arrCom addObjectsFromArray: response.data.comments];
                 if(self.arrCom.count==0){
                self.commentHeight.constant =0;
                 }
                
                 [self.commentTab reloadData];
                 [self.infoTab    reloadData];
             }
               
           } failureBlock:^(NSError *error) {
               
           }];
}
@end
