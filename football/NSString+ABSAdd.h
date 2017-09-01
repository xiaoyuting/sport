//
//  NSString+ABSAdd.h
//  ABSPartner
//
//  Created by ABS on 16/8/11.
//  Copyright © 2016年 ABS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (ABSAdd)

//+(NSString *)MD5:(NSString *)str;
+(NSString *)Base64encode:(NSString *)encodeStr;
+(NSString *)Base64decode:(NSString *)decodeStr;
+(BOOL) isEmpty:(NSString *) str;
+(BOOL)isValidateEmail:(NSString *)msg;
+(NSString *)formatPhoneNum:(NSString *)phone;
+(BOOL)isMobileNumber:(NSString *)mobileNum;
+(BOOL)isIdentityNumber:(NSString *)identityNum;


+ (NSString *)personNumChangeToStringWithPerMil:(CGFloat)floatNum;

+ (NSString *)salesFloatNumChangeToStringWithPerMil:(CGFloat)floatNum;

+ (NSString *)formatWrongDecimalDoubleNum:(double)wrongNum;


- (NSString *)paramDateFormat;


- (NSString *)uiDateFormat;


+ (CGFloat)heightForText:(NSString *)text withTextFont:(UIFont *)font withTextWidth:(CGFloat)textWidth;


+ (CGFloat)widthForText:(NSString *)text withTextFont:(UIFont *)font withTextHeight:(CGFloat)textHeight;

+(CGSize)calculateTextSize:(CGSize)size Content:(NSString *)strContent  font:(UIFont *)font;
+(BOOL)isStandardPassword:(NSString *)str andView:(UIView *)view;
+(BOOL)isStandardFargatherName:(NSString *)str andView:(UIView *)view;
+(NSString *)stringRemoveEmoji:(NSString *)stringRemoveEmoji;
+(NSString *)strarrNamesToStr:(NSArray *)arrayNames;
+(CGFloat)calculateTextHeight:(NSArray *)arrIems;
+(NSMutableAttributedString *)calculateUpdateStringColor:(NSString *)willUpdateStr  allTextString:(NSString *)allTextStr willUpdateStringColor:(UIColor *)WillUpdateColor;


+(NSMutableAttributedString *)parseText:(NSString *)parseText withBegin:(NSString *)begin  withEnd:(NSString *)end AndParams:(NSDictionary *)dic;


- (NSMutableAttributedString *)stringChangeToAttributedStringWithFont:(UIFont *)font
                                                                color:(UIColor *)color
                                                                range:(NSRange)range;



- (NSMutableAttributedString *)changeNumWithDecimalPointForFont:(UIFont *)font;


- (NSMutableAttributedString *)changeNumWithDecimalPointForFont:(UIFont *)font
                                                           color:(UIColor *)color;

+ (NSString *)translationIntStrToChinese:(NSString *)arebic;

@end
