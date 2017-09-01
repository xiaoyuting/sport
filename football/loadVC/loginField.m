//
//  loginField.m
//  football
//
//  Created by 雨停 on 2017/7/12.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "loginField.h"

@implementation loginField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [ super initWithFrame:frame]){
        self.field = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 21)];
        self.field.font = FontSize(15);
        self.field.clearButtonMode =UITextFieldViewModeWhileEditing;
        [self addSubview:self.field];
        
        self.line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 32, self.frame.size.width, 2)];
        self.line.image = Img(@"Line");
        [self addSubview:self.line];
    }
    
    return self;
}
@end
