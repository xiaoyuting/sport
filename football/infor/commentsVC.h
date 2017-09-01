//
//  commentsVC.h
//  football
//
//  Created by 雨停 on 2017/8/25.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "XYBaseVC.h"

@interface commentsVC : XYBaseVC
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIButton *btnPush;
@property (nonatomic, copy)NSString  * commentID;
@end
