//
//  UIView+LLAdd.h
//  ABSHome
//
//  Created by 雨停 on 2017/1/2.
//  Copyright © 2017年 ABS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (LLAdd)

@property (nonatomic, assign) CGFloat top;

@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat left;

@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGPoint origin;

@end

@interface UIView (LLViewController)

@property (nonatomic, weak, readonly) UIViewController *viewController;

@end
