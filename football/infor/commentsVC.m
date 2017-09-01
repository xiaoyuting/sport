//
//  commentsVC.m
//  football
//
//  Created by 雨停 on 2017/8/25.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "commentsVC.h"

@interface commentsVC ()<UITextViewDelegate>

@end

@implementation commentsVC
-(id)init{
    if(self==[super init]){
        self.commentID = [NSString string];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubview];
   }
- (void)setSubview{
    self.title = @"发表评论";
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self setNavLeftItemTitle:@"返回" andImage:nil];
}
-(void)leftItemClick:(id)sender{
    [self absPopNav];
    
}
- (IBAction)btnPushInfo:(UIButton *)sender {
    
    [self requestType:HttpRequestTypePost url:nil
           parameters:@{@"action" : @"comment",
                         @"type"  : @"1",     //评论对象类型：1资讯
                         @"obj_id" : self.commentID,  //评论对象id
                         @"content" :self.textview.text}
         successBlock:^(BaseModel *response) {
             if([response.errorno  isEqualToString:@"0"]){
                   [self absPopNav];
             }
               
           } failureBlock:^(NSError *error) {
               
           }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum >500)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:500];
        
        [textView setText:s];
    }
    
    //不让显示负数
    self.numLab.text = [NSString stringWithFormat:@"%ld/500",MAX(0,500 - existTextNum)];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    if (![text isEqualToString:@""])
    {
        self.btnPush.userInteractionEnabled=YES;
        [self.btnPush setBackgroundColor:mainColor];
        
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        self.btnPush.userInteractionEnabled=NO;
        [self.btnPush setBackgroundColor:[UIColor lightGrayColor]];

    }
    

    NSString * comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = 500 - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
    
    return YES;
}

@end
