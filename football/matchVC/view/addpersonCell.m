//
//  addpersonCell.m
//  football
//
//  Created by 雨停 on 2017/7/27.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "addpersonCell.h"

@implementation addpersonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDic:(NSDictionary *)dic{
    _dic=dic;
    

    self.name.text = [dic objectForKey:@"name"];
    self.posizition.text =[dic objectForKey:@"position"];
    self.num.text = [dic objectForKey:@"number"];
    
}
@end
