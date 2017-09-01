//
//  UIColor+XYColor.h
//  ABSHome
//
//  Created by XY on 16/8/11.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XYColor)

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat)alpha;

@end
