//
//  JCButton.h
//  JCCountDownBtn
//
//  Created by QB on 16/4/27.
//  Copyright © 2016年 JC. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  命名 --变化的block块
 */
@class JCButton;
typedef NSString *(^DidChangBlock)(JCButton *countDownBtn,int second);
/**
 *  命名--完成的Block块
 */

typedef NSString *(^DidFinshBlock)(JCButton *countDownBtn,int second);
/**
 *  name
 */

typedef void(^TouchDownBlock)(JCButton *countDownBtn,NSInteger tag);

@interface JCButton : UIButton


/**
 *  变化
 */
@property (nonatomic, copy) DidChangBlock didChangBlock;


/**
 *  完成
 */
@property (nonatomic, copy) DidFinshBlock didFinshBlock;


/**
 *  name
 */
@property (nonatomic, copy) TouchDownBlock touchDownBlock;


- (void)addToucheHandler:(TouchDownBlock)touchHandler;


- (void)didChangBlock:(DidChangBlock)changBlock;


- (void)didFinshBlock:(DidFinshBlock)finshBlock;

/**
 *  开始
 */

-(void)startWithSecond:(int)totalSecond;

/**
 *  停止
 */

- (void)stop;

@end
