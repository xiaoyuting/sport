//
//  ABSSegmentCate.h
//  ABSHome
//
//  Created by 雨停 on 2017/1/2.
//  Copyright © 2017年 ABS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABSSegmentCate;

typedef void (^LLSegmentedControlBlock) (ABSSegmentCate *segmentedControl, NSInteger selectedIndex);

// 下划线样式
typedef NS_ENUM(NSUInteger, LLSegmentedControlLineStyle) {
    LLSegmentedControlStyleUnderline = 0, //  下划线在底部
    LLSegmentedControlStyleTopline = 1, // 下划线在顶部
    LLSegmentedControlLineStyleHidden = 2, // 下划线隐藏
};

// 文字排列样式
typedef NS_ENUM(NSUInteger, LLSegmentedControlTitleSpacingStyle) {
    // 文字自适应, 不需要设置titleWidth, 需要设置间距 titleSpacing
    LLSegmentedControlTitleSpacingStyleWidthAutoFit = 0,
    // 文字宽度固定, 只需要设置titleWidth, 不需要设置titleSpacing
    LLSegmentedControlTitleSpacingStyleWidthFixed = 1,
};

@interface ABSSegmentCate : UIView

#pragma mark -
#pragma mark - init methods
- (instancetype)init;

- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray <NSString *>*)titleArray;

#pragma mark -
#pragma mark - @properties
/**
 * @property titleArray: 显示文字数组
 */
@property (nonatomic, strong) NSArray <NSString *>*titleArray;

/**
 * @property segmentedControlLineStyle: 下划线样式
 */
@property (nonatomic, assign) LLSegmentedControlLineStyle segmentedControlLineStyle;

/**
 * @property segmentedControlTitleSpacingStyle: 显示文字的间距样式
 */
@property (nonatomic, assign) LLSegmentedControlTitleSpacingStyle segmentedControlTitleSpacingStyle;
/**
 * @property lineWidthEqualToTextWidth: 下划线样式是否与当前位置的文字宽度相等
 * 如果为YES则表示下划线的宽度和文字的宽度相等, 不需要设置lineWidth 属性
 */
@property (nonatomic, assign) BOOL lineWidthEqualToTextWidth;

/**
 * @property textColor: 字体颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 * @property selectedTextColor: 选中位置字体颜色
 */
@property (nonatomic, strong) UIColor *selectedTextColor;

/**
 * @property font: 字体
 */
@property (nonatomic, strong) UIFont *font;

/**
 * @property selectedFont: 选中位置字体
 */
@property (nonatomic, strong) UIFont *selectedFont;

/**
 * @property lineColor: 下划线颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

/**
 * @property lineHeight: 下划线高度
 */
@property (nonatomic, assign) CGFloat lineHeight;

/**
 * @property lineWidth: 下划线宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 * @property titleWidth: 文字宽度
 */
@property (nonatomic, assign) CGFloat titleWidth;

/**
 * @property titleSpacing: 文字间隔
 */
@property (nonatomic, assign) CGFloat titleSpacing;

/**
 * @property defaultSelectedIndex: 默认选中位置
 */
@property (nonatomic, assign) NSInteger defaultSelectedIndex;

/**
 * @property selectedIndex: 当前选中位置
 */
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

/**
 * @property showSplitLine: 显示分割线, default is NO, if YES show splitLine
 */
@property (nonatomic, assign) BOOL showSplitLine;

/**
 * @property splitLineHeight: 分割线大小
 */
@property (nonatomic, assign) CGSize splitLineSize;

/**
 * @property splitLineColor: 分割线颜色
 */
@property (nonatomic, strong) UIColor *splitLineColor;
//滑动视图

@property (nonatomic, strong) UIScrollView *scrollView;

/** 点击回调
 *   回调
 */
- (void)segmentedControlSelectedWithBlock:(LLSegmentedControlBlock)block;

/** 手动设置选中位置
 * @param selectedIndex 选中位置
 */
- (void)segmentedControlSetSelectedIndex:(NSInteger)selectedIndex;

/** 手动设置选中位置且执行 segmentedControlSelectedWithBlock: 的回调方法
 * @param selectedIndex 选中位置
 *   回调
 */
- (void)segmentedControlSetSelectedIndexWithSelectedBlock:(NSInteger)selectedIndex;

@end

@interface NSString (LLAdd)

/** 计算NSString的宽度
 * @param textHeight 文字高度
 * @param text 文字
 * @param font 字体
 */
+ (float)getTextWidth:(float)textHeight text:(NSString *)text font:(UIFont *)font;

@end
