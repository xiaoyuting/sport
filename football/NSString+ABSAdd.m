//
//  NSString+ABSAdd.m
//  ABSPartner
//
//  Created by ABS on 16/8/11.
//  Copyright © 2016年 ABS. All rights reserved.
//

#import "NSString+ABSAdd.h"
#import "CommonCrypto/CommonDigest.h"
@implementation NSString (ABSAdd)

//+(NSString *)MD5:(NSString *)str {
//    const char *cStr = [str UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(cStr, strlen(cStr), result);
//    
//    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//             result[0], result[1], result[2], result[3],
//             result[4], result[5], result[6], result[7],
//             result[8], result[9], result[10], result[11],
//             result[12], result[13], result[14], result[15]
//             ] lowercaseString];
//    
//}

+ (NSString *)Base64encode:(NSString *)encodeStr {
    NSString* encoded =@"";
    return encoded;
}

+ (NSString *)Base64decode:(NSString *)decodeStr
{
    NSString *decoded =@"";
    return decoded;
}

+ (BOOL) isEmpty:(NSString *) str {
    
    if ([str isKindOfClass:[NSNull class]])
    {
        return true;
    }
    else {
        if (!str) {
            return true;
        } else {
            NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
            
            NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
            
            if ([trimedString length] == 0) {
                return true;
            } else {
                return false;
            }
        }
    }
}

- (NSString *)paramDateFormat {
    NSArray  *partStrArr = [self componentsSeparatedByString:@"/"];
    partStrArr = [[partStrArr reverseObjectEnumerator] allObjects];
    return [partStrArr componentsJoinedByString:@"-"];
}

- (NSString *)uiDateFormat {
    NSArray  *partStrArr = [self componentsSeparatedByString:@"-"];
    partStrArr = [[partStrArr reverseObjectEnumerator] allObjects];
    return [partStrArr componentsJoinedByString:@"/"];
}


+(NSString *)formatPhoneNum:(NSString *)phone
{
    if ([phone hasPrefix:@"86"]) {
        NSString *formatStr = [phone substringWithRange:NSMakeRange(2, [phone length]-2)];
        return formatStr;
    }
    else if ([phone hasPrefix:@"+86"])
    {
        if ([phone hasPrefix:@"+86·"]) {
            NSString *formatStr = [phone substringWithRange:NSMakeRange(4, [phone length]-4)];
            return formatStr;
        }
        else
        {
            NSString *formatStr = [phone substringWithRange:NSMakeRange(3, [phone length]-3)];
            return formatStr;
        }
    }
    return phone;
}


+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    NSString * MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0-9])\\d{8}$|(^1705\\d{7}$)";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:mobileNum] == YES) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL)isIdentityNumber:(NSString *)identityNum {
    NSString * identityReg = @"^\\d{6}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", identityReg];
    if ([regextestmobile evaluateWithObject:identityNum] == YES) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL)isValidateEmail:(NSString *)msg {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:msg];
}
+ (CGSize)calculateTextSize:(CGSize)size Content:(NSString *)strContent  font:(UIFont *)font {
    NSDictionary *tdic =[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    return [strContent boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
}
+ (CGFloat)heightForText:(NSString *)text withTextFont:(UIFont *)font withTextWidth:(CGFloat)textWidth {
    if ([NSString isEmpty:text]) {
        return 0.0f;
    }
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize size = CGSizeMake(textWidth, 2000);
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
    return frame.size.height;
}

+ (CGFloat)widthForText:(NSString *)text withTextFont:(UIFont *)font withTextHeight:(CGFloat)textHeight {
    if ([NSString isEmpty:text]) {
        return 0.0f;
    }
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize size = CGSizeMake(2000, textHeight);
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
    return frame.size.width;
}


+ (NSMutableAttributedString *)calculateUpdateStringColor:(NSString *)willUpdateStr  allTextString:(NSString *)allTextStr willUpdateStringColor:(UIColor *)WillUpdateColor{
    NSString *string3=allTextStr;
    NSRange range3 = [string3 rangeOfString: willUpdateStr];
    NSRange fontRange3=[string3 rangeOfString:allTextStr];
    NSMutableAttributedString *attribute3 =[[NSMutableAttributedString alloc] initWithString: string3];
    [attribute3 addAttributes:@{
                                NSForegroundColorAttributeName:WillUpdateColor
                                }range:range3];
    [attribute3 addAttributes:@{
                                NSFontAttributeName:FontSize(15)
                                }range:fontRange3];
    NSLog(@"==%@",[attribute3 string]);
    return attribute3;
}

+ (BOOL)isStandardPassword:(NSString *)str andView:(UIView *)view {
    if (str.length >5&&str.length<33) {
        
        return YES;
    }
    else {
       // [view makeToast:@"请输入6~32位字符" duration:1.0 position:@"center"];
        return NO;
    }
}

+ (BOOL)isStandardFargatherName:(NSString *)str andView:(UIView *)view {
    if ([NSString isEmpty:str])
    {
       // [view makeToast:@"聚会名不能为空" duration:1.5 position:@"center"];
        return NO;
    }
    else{
        if (str.length >0&&str.length<11) {
            return YES;
        }
        else {
           // [view makeToast:@"请输入1~10位字符" duration:1.5 position:@"center"];
            return NO;
        }
    }
}

+ (NSString *)stringRemoveEmoji:(NSString *)stringRemoveEmoji {
    return @"";
}

+ (NSString *)strarrNamesToStr:(NSArray *)arrayNames {
    if (arrayNames.count ==0) {
        return @"";
    }
    else if (arrayNames.count ==1) {
        return [[arrayNames objectAtIndex:0] objectForKey:@"userName"];
    }
    else {
        NSMutableString *strname =[[NSMutableString alloc] init];
        for (int i=0; i<arrayNames.count; i++){
            [strname appendString:[[arrayNames objectAtIndex:i]objectForKey:@"userName"]];
            if (i+1==arrayNames.count) {
                
            }
            else {
                [strname appendString:@","];
            }
        }
        return strname;
    }
}

+ (CGFloat)calculateTextHeight:(NSArray *)arrIems {
    float x=15.0f;
    float y=44.0f;
    if (arrIems ==nil||arrIems.count ==0) {
        return 44.0f;
    }
    for (int i=0; i<arrIems.count; i++) {
        NSString *strTabsName = arrIems[i];
        float tempWidth = [NSString widthForText:strTabsName withTextFont:FontSize(13) withTextHeight:100];
        if (tempWidth +10+x >KScreenWidth-35) {
            x =15.0;
            y =y+20.0f;
        }
        else {
            x =x+tempWidth+10;
        }
    }
    return 30+y+10;
}

+ (NSMutableAttributedString *)parseText:(NSString *)parseText withBegin:(NSString *)begin  withEnd:(NSString *)end AndParams:(NSDictionary *)dic {
    NSMutableAttributedString *returnAttributedString =[[NSMutableAttributedString alloc] init];
    NSArray *arrayParse =[parseText componentsSeparatedByString:begin];
    for (NSInteger i=0; i<arrayParse.count; i++) {
        NSString *strIndex =[arrayParse objectAtIndex:i];
        if ([strIndex rangeOfString:end].location ==NSNotFound) {
            NSAttributedString *attributedString =[[NSAttributedString alloc] initWithString:strIndex attributes:@{NSForegroundColorAttributeName:[UIColor  redColor]}];
            [returnAttributedString appendAttributedString:attributedString];
        }
        else {
            NSRange endRange =[strIndex rangeOfString:end];
            NSString *strMatch =[strIndex substringToIndex:endRange.location];
            NSString *strEnd =[strIndex substringFromIndex:endRange.location+endRange.length];
            NSAttributedString *attributedStringMatch =[[NSAttributedString alloc] initWithString:strMatch attributes:@{NSForegroundColorAttributeName:[dic objectForKey:@"color"]}];
            [returnAttributedString appendAttributedString:attributedStringMatch];
            NSAttributedString *attributedStringEnd =[[NSAttributedString alloc] initWithString:strEnd attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
            [returnAttributedString appendAttributedString:attributedStringEnd];
        }
        
    }
    return returnAttributedString;
}

+ (NSString *)personNumChangeToStringWithPerMil:(CGFloat)floatNum {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    CGFloat num = [[NSString stringWithFormat:@"%.0f",floatNum] floatValue];
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithFloat:num]];
    return string;
}

+ (NSString *)salesFloatNumChangeToStringWithPerMil:(CGFloat)floatNum {
    
    floatNum = (floatNum *100 + 0.5);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithFloat:floatNum/100]];
    
    NSRange range = [string rangeOfString:@"."];
    NSUInteger location = range.location;
    
    
    if (![string containsString:@"."]) {
        string = [string stringByAppendingString:@".00"];
    }else if (location == string.length - 2) {
        string = [string stringByAppendingString:@"0"];
    } else if (location != (string.length - 3)) {
        string = [string substringWithRange:NSMakeRange(0, location+3)];
    }
    return string;
}

- (NSMutableAttributedString *)stringChangeToAttributedStringWithFont:(UIFont *)font
                                                                color:(UIColor *)color
                                                                range:(NSRange)range {
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:self];
    
    if (color) {
        [attStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(range.location, range.length)];
    }
    if (font) {
        [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(range.location, range.length)];
    }
    return attStr;
}

- (NSMutableAttributedString *)changeNumWithDecimalPointForFont:(UIFont *)font {
    return [self changeNumWithDecimalPointForFont:font color:[UIColor redColor]];
}

- (NSMutableAttributedString *)changeNumWithDecimalPointForFont:(UIFont *)font
                                                           color:(UIColor *)color {
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:self];
    if (![self containsString:@"."]) {
        return attStr;
    }
    NSRange range = [self rangeOfString:@"."];
    NSUInteger location = range.location;
    NSUInteger length   = self.length-range.location;
    
    if (color) {
        [attStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(location, length)];
    }
    if (font) {
        [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(location, length)];
    }
    return attStr;
}

+ (NSString *)formatWrongDecimalDoubleNum:(double)wrongNum {
    NSString *doubleString        = [NSString stringWithFormat:@"%lf", wrongNum];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

+ (NSString *)translationIntStrToChinese:(NSString *)arebic

{   NSString *str = arebic;
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length -i-1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]])
        {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
            {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]])
                {
                    [sums removeLastObject];
                }
            }else
            {
                sum = chinese_numerals[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum])
            {
                continue;
            }
        }
        
        [sums addObject:sum];
    }
    
    NSString *sumStr = [sums  componentsJoinedByString:@""];
    NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
    return chinese;
}

@end
