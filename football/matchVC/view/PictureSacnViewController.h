//
//  PictureSacnViewController.h
//  Nursery
//
//  Created by chenp on 16/10/19.
//  Copyright © 2016年 chenp. All rights reserved.
//





/*
 
 PictureSacnViewController *picVC=[PictureSacnViewController new];
 NSMutableArray *array=[NSMutableArray array];
 for(int i=0;i<9;i++){
 NSMutableDictionary *dic=[NSMutableDictionary dictionary];
 
 if(i!=8){
 [dic setObject:@"1" forKey:@"islocal"];
 [dic setObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]] forKey:@"picString"];
 }else{
 [dic setObject:@"0" forKey:@"islocal"];
 [dic setObject:@"http://i1.hexunimg.cn/2014-08-15/167580248.jpg" forKey:@"picString"];
 }
 [array addObject:dic];
 }
 picVC.picArray=[NSMutableArray arrayWithArray:array];
 picVC.currenpage=9;
 [self.navigationController presentViewController:picVC animated:YES completion:nil];
 */

#import <UIKit/UIKit.h>

@interface PictureSacnViewController : UIViewController

@property (nonatomic,strong)NSMutableArray *picArray;//dic:@"islocal" @"picString" @"text"

@property (nonatomic,assign)int currenpage;


@end
