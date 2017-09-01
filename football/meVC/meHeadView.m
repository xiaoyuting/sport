//
//  meHeadView.m
//  football
//
//  Created by 雨停 on 2017/6/29.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "meHeadView.h"

@implementation meHeadView
- (IBAction)pushRegist:(UIButton *)sender {
    
 
        if(self.personInfo){
            self.personInfo(sender.tag);
  
  
        }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
