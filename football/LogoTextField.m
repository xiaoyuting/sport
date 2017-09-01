//
//  LogoTextField.m
//  BicycleApp
//
//  Created by 雨停 on 2017/5/16.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "LogoTextField.h"
#import "TimerButton.h"
@implementation LogoTextField


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
       
        self.tittle  = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 64, self.frame.size.height-10)];
        self.tittle.textAlignment =NSTextAlignmentLeft;
        self.tittle.font =FontSize(14);
        [self addSubview:self.tittle ];
        self.lineV = [[UIImageView alloc]initWithFrame:CGRectMake(self.tittle.right+1, 15, 1,self.frame.size.height-30)];
        self.lineV.backgroundColor= [UIColor blackColor];
        [self addSubview:self.lineV];
        self.field   = [[UITextField alloc]initWithFrame:CGRectMake(79, 5, self.frame.size.width-89-60, self.frame.size.height-10)];
        //self.field.textColor = gary51;
        self.field.font      = FontSize(14);
        self.field.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:self.field ];
        //self.btn= [[ TimerButton alloc]initWithFrame:CGRectMake(self.field.right, 0, 60, 36)];
        //self.btn.layer.cornerRadius = 4;
        //[self addSubview:self.btn];
        self.lineH = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.field.bottom+5, self.frame.size.width, 2)];
        self.lineH.image = Img(@"Line");
        [self addSubview:self.lineH];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
