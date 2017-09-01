//
//  XYBaseVC.h
//  CateTool
//
//  Created by 雨停 on 2016/12/18.
//  Copyright © 2016年 雨停. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ABSSegmentCate;
@class navi;

extern NSString *const kName;

/*! 定义请求成功的 block */
typedef void( ^ RequestSuccess)(BaseModel * response);
/*! 定义请求失败的 block */
typedef void( ^ RequestFail)(NSError *error);


@interface XYBaseVC : UIViewController
/**
 用了自定义的手势返回，则系统的手势返回屏蔽
 不用自定义的手势返回，则系统的手势返回启用
 */
@property (nonatomic, assign) BOOL enablePanGesture;//是否支持自定义拖动pop手势，默认yes,支持手势
-(void)initAppinfo;
@property (nonatomic, strong) navi * navi;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
           dictionary:(NSDictionary *)dic;
- (NSMutableString *)webImageFitToDeviceSize:(NSMutableString *)strContent;
-(void)location :(id)sender;
- (void)setData;
- (void)leftFoundation;
- (void)rightFoundation;
-(void)setNaivTitle:(NSString *)title;
- (void)playBtnClick;
- (void)setSubviews;
-(void)setLine;
- (CGFloat)cellContentViewWith;
-( ABSSegmentCate  *)setSegframe:(CGRect)rect titleArr:(NSArray *)arr space:(CGFloat)space;
- (void)viewWillAppear:(BOOL)animated;
- (void)absPushViewController:(XYBaseVC *) controller animated:(BOOL) animated;

-(void)requestType:(HttpRequestType)type
               url:(NSString *)url
        parameters:(NSDictionary *)parm
      successBlock:(RequestSuccess)success failureBlock:(RequestFail)failure;
- (void)absRootPushViewController:(XYBaseVC *) controller animated:(BOOL) animated;


- (void)setBackBarButtonItem;
- (void)absPopNav;



- (void)setNavLeftItemTitle:(NSString *)str andImage:(UIImage *)image;
- (void)leftItemClick:(id)sender;


- (void)setNavRightItemTitle:(NSString *)str andImage:(UIImage *)image;
- (void)rightItemClick:(id)sender;

-(void)setNavi;

-(void)loadNewData;


-(void)loadMoreData;

- (void)updatePlaceholderView;

- (void)showPlaceholderViewWithImage:(UIImage *)image
                             message:(NSString *)message
                         buttonTitle:(NSString *)title
                       centerOffsetY:(CGFloat)centerOffsetY
                         onSuperView:(UIView *)superView;

- (UIView *)setPlaceholderViewWithImage:(UIImage *)image
                                message:(NSString *)message
                            buttonTitle:(NSString *)title
                          centerOffsetY:(CGFloat)centerOffsetY;
- (void)startLoading;
- (void)endLoading;
- (void)updateLoading;

- (BOOL)isLogin;
- (float)getTextWidth:(float)textHeight text:(NSString *)text font:(UIFont *)font ;
- (float)getTextHeight:(float)textWidth text:(NSString *)text font:(UIFont *)font;


@end
