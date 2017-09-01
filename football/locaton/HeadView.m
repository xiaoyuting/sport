//
//  HeadView.m
//  AddressInfo
//
//  Created by Alesary on 16/1/6.
//  Copyright © 2016年 Mr.Chen. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

-(instancetype)init
{
    self=[[[NSBundle mainBundle]loadNibNamed:@"HeadView" owner:nil options:nil] firstObject];
    
   
    return self;
}
@end
