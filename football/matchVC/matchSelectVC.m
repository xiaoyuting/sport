//
//  matchSelectVC.m
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "matchSelectVC.h"
#import "selectHeadCell.h"
#import "titleCell.h"
#import "bottomCell.h"
#import "statusSmodel.h"
@interface matchSelectVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * myTab;
@property (nonatomic,strong)NSMutableArray * arr;
@property (nonatomic,strong)NSMutableArray * bottomArr;
@property (nonatomic, strong) NSMutableArray *categoryData;
@property (nonatomic, strong) NSMutableArray *foodData;
@property (nonatomic,strong) NSMutableDictionary * dic;

@end

@implementation matchSelectVC


- (void)viewDidLoad {
    self.dic = [[NSMutableDictionary alloc]initWithDictionary:
               @{ //@"page" : @"1",  //选填 页数
                  @"type" : @"",  //选填 赛事赛制
                  @"status" : @"",  //选填 比赛状态 1报名中2进行中
                  @"level" : @"",  //选填  比赛级别
                  @"city" : @"",  //选填 城市id
                  @"county" : @""  //选填  区县id
            }];

    [self setrequestBottom];
    [self setNavLeftItemTitle:@"返回" andImage:nil];
    self.title = @"筛选";
    self. arr  =[NSMutableArray array];
    self. bottomArr  =[NSMutableArray array];
    [self sendRequest];
    [super viewDidLoad];
   
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    

}


- (void)setSubview{

    
    self.myTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth,KScreenHeight-64-48) style:UITableViewStyleGrouped];
    self.myTab.delegate =self;
    self.myTab.dataSource =self;
    self.myTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myTab registerClass:[selectHeadCell class] forCellReuseIdentifier:NSStringFromClass([selectHeadCell class])];
    [self.myTab registerClass:[bottomCell class] forCellReuseIdentifier:NSStringFromClass([bottomCell class ])];
    [self.view addSubview:self.myTab];
    UIButton * btnL = [XYUIKit buttonWithBackgroundColor:KWhiteColor titleColor:KGrayColor title:@"重置" fontSize:17];
    btnL.frame = CGRectMake(0, KScreenHeight-64-48, 0.5*KScreenWidth, 48);
    UIButton * btnR = [XYUIKit buttonWithBackgroundColor:mainColor titleColor:KWhiteColor title:@"确定" fontSize:17];
    btnR.frame = CGRectMake(0.5*KScreenWidth, KScreenHeight-64-48, 0.5*KScreenWidth, 48);
    btnR.tag =0;
    btnL.tag =1;
    [self.view addSubview:btnL];
    [self.view addSubview:btnR];
    [btnR addTarget:self action:@selector(choseInfo:) forControlEvents:UIControlEventTouchUpInside];
    [btnL addTarget:self action:@selector(choseInfo:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)choseInfo:(UIButton *)sender{
    if(sender.tag==0){
        [self.seledelegate   setRequest:self.dic];
        NSLog(@"%@",self.dic);
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if(sender.tag==1){
        [self.myTab reloadData];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     if(_myTab ==tableView){
         NSLog(@"self.arr.count;%ld",self.arr.count);
         return self.arr.count;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_myTab ==tableView){
        return 1;
    }
    return 0;
}
-(void)leftItemClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section<3){
    selectHeadCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([selectHeadCell class])];
        if(indexPath.section==0){
            cell.cheakinfo = ^(NSIndexPath  *a) {
               
                NSArray * arr =    self.arr[indexPath.section];
                statusSmodel *model = arr[a.row];
                 [self.dic setValue:model.id  forKey:@"level"];
            };
        }else if(indexPath.section==1){
            cell.cheakinfo = ^(NSIndexPath  *a) {
                NSArray * arr =    self.arr[indexPath.section];
                statusSmodel *model = arr[a.row];
                [self.dic setValue:model.id forKey:@"status"];
            };
        }else if(indexPath.section==2){
            cell.cheakinfo = ^(NSIndexPath  *a) {
              
                NSArray * arr =    self.arr[indexPath.section];
                statusSmodel *model = arr[a.row];
                [self.dic setValue:model.id forKey:@"type"];
            };
        }

        
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setContentView:self.arr[indexPath.section]];
        return cell;
    }else{
       bottomCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([bottomCell class])];
        cell.left = ^(NSIndexPath *a) {
           
        [self.dic setValue: [self.categoryData[a.row] objectForKey:@"area_id"] forKey:@"city"];
          
 
        };
        cell.right = ^(NSIndexPath *b) {
            NSArray * arr =self.foodData[b.section];
            [self.dic setValue: [arr[b.row] objectForKey:@"area_id"] forKey:@"county"];
        };
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell setCateArr:self.categoryData setDetaileArr:self.foodData];
        return cell;
    }
       
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 40)];
    view.backgroundColor   =  [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    UILabel * lab = [XYUIKit labelWithBackgroundColor:KClearColor textColor:KGrayColor textAlignment:NSTextAlignmentLeft numberOfLines:0 text:nil fontSize:13];
    [view addSubview:lab];
    lab.frame = CGRectMake(20, 8, 200, 32);
    if(section==0){
        lab.text =@"赛事级别";
    }else if(section==1){
        lab.text =@"比赛状态";
    }else if(section==2){
        lab.text =@"比赛赛制";
    }else if(section==3){
        lab.text =@"地区";
    }
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if(indexPath.section<3){
     return    [selectHeadCell  HeightWithArray: self.arr[indexPath.section]];
    }
    
         return 300;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(_myTab==tableView){
        return 40;
    }
    return 0;

}



-(void)sendRequest{
    [self requestType:HttpRequestTypePost
                  url:nil
           parameters:@{@"action" : @"getMatchFilter"
                        }
         successBlock:^(BaseModel *response) {
             
             if([response.errorno isEqualToString:@"0"]){
              NSArray * arr1 =response.data.level;
              NSArray * arr2 =response.data.status;
              NSArray * arr3 =response.data.type;
             [self.arr addObject:arr1];
             [self.arr addObject:arr2];
             [self.arr addObject:arr3];
             [self setSubview];
             [self.myTab reloadData];
             }
         }
         failureBlock:^(NSError *error) {
             
         }];
}


-(void)setrequestBottom{
    
    appInfoModel * model = [appInfoModel yy_modelWithDictionary:[ball getObjectById:@"urlInfo" fromTable:@"person"]];
    NSDictionary  * dic =@{
                           @"client_id"    : model.app_key,
                           @"state"        : model.seed_secret,
                           @"access_token" : model.access_token,
                           @"action"       : @"getCounties"
                           };
    
    [RequestManager requestWithType:HttpRequestTypePost
                          urlString:model.source_url
                         parameters:dic
                       successBlock:^(id response){
                           NSLog(@"response==%@",response);
                           NSArray * arr =[response objectForKey:@"data"];
                         
                           
                            for(NSDictionary * dic in arr){
                               if([[dic objectForKey:@"title"]isEqualToString:[ball getStringById:@"city" fromTable:@"person"]]){
                                   [self.categoryData addObject:dic];
                                   NSMutableArray    * arrInsert = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"county"]];
                                   [arrInsert    insertObject:@{
                                                               @"area_id" : @"0",
                                                               @"title" : @"全部"
                                                               }atIndex:0];
                                   
                                [self.foodData addObject:arrInsert];
                               }
                              
                           }
                           [self.arr addObject:arr];
                           [self setSubview];
                           [self.myTab reloadData];

                          
                       }failureBlock:^(NSError *error) {
                           
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
}
    /* NSDictionary * dic =@{
     @"action" : @"getMatchList",
     // @"page" : @"2",    //选填 页数
     // @"type" : @"11",   //选填 赛事赛制
     //@"status" :@"1",   //选填 比赛状态 1报名中2进行中
     // @"level" : @"19",  //选填  比赛级别
     // @"city" :@"310100",  //选填 城市id
     //@"county" : @"310104"  //选填  区县id
     
     };
     [self requestType:HttpRequestTypePost url:nil parameters:dic  successBlock:^(BaseModel *response) {
     
     } failureBlock:^(NSError *error) {
     
     }];*/
    
    
- (NSMutableArray *)categoryData
{
    if (!_categoryData)
    {
        _categoryData = [NSMutableArray array];
    }
    return _categoryData;
}

- (NSMutableArray *)foodData
{
    if (!_foodData)
    {
        _foodData = [NSMutableArray array];
    }
    return _foodData;
}



@end
