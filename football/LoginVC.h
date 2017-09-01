//
//  ABSLoginVC.h
//  ABSHome
//
//  Created by ABS on 16/10/18.
//  Copyright © 2016年 ABS. All rights reserved.
//

#import "XYBaseVC.h"

typedef void(^LogoutBackBlock)();
typedef void(^LoginBlock)();

@interface LoginVC : XYBaseVC
@property (nonatomic, copy)   LogoutBackBlock   boackBlock;
@property (nonatomic, copy)   LoginBlock        loginBlock;
@property (nonatomic, strong) UIButton    * exitBtn;
@end
