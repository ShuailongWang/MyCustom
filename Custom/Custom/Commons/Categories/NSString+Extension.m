//
//  NSString+Extension.m
//  RGfzzd
//
//  Created by admin on 16/12/14.
//  Copyright © 2016年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

// 根据文字的长度和字号返回size
-(CGSize)StringWithSize:(CGFloat)fontSize{
    NSDictionary *attrs = @{
                            NSFontAttributeName : [UIFont boldSystemFontOfSize:fontSize]
                            };
    CGSize size = [self sizeWithAttributes:attrs];
    
    return size;
}


// 根据文字的长度返回height
- (CGFloat)getHeightWithFont:(CGFloat)fontSize constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:fontSize constrainedToSize:size].height;
}
- (CGFloat)getWidthWithFont:(CGFloat)fontSize constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:fontSize constrainedToSize:size].width;
}
- (CGSize)getSizeWithFont:(CGFloat)fontSize constrainedToSize:(CGSize)size{
    
    CGSize resultSize = CGSizeZero;
    
    if (self.length <= 0) {
        return resultSize;
    }
    
    resultSize = [self boundingRectWithSize:size options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;

    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    
    return resultSize;
}


//添加富文本
-(NSAttributedString*)addAttriButedWithLeftName:(NSString*)leftName rightName:(NSString*)rightName{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    
    // 创建图片图片附件
    NSTextAttachment *leftAtt = [[NSTextAttachment alloc] init];
    leftAtt.image = [UIImage imageNamed:leftName];
    leftAtt.bounds = CGRectMake(0, 0, 10, 10);
    NSAttributedString *leftAttString = [NSAttributedString attributedStringWithAttachment:leftAtt];
    //文本
    NSAttributedString *attriStr = [[NSAttributedString alloc]initWithString: self];
    
    // 创建图片图片附件
    NSTextAttachment *rightAtt = [[NSTextAttachment alloc] init];
    rightAtt.image = [UIImage imageNamed:rightName];
    rightAtt.bounds = CGRectMake(0, 0, 10, 10);
    NSAttributedString *rightAttString = [NSAttributedString attributedStringWithAttachment:rightAtt];
    
    //添加
    [str appendAttributedString:leftAttString];
    [str appendAttributedString:attriStr];
    [str appendAttributedString:rightAttString];
    
    return str;
}

-(NSAttributedString*)addAttriButedWithRightName:(NSString*)rightName{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    
    //文本
    NSAttributedString *attriStr = [[NSAttributedString alloc]initWithString: self];
    
    // 创建图片图片附件
    NSTextAttachment *rightAtt = [[NSTextAttachment alloc] init];
    rightAtt.image = [UIImage imageNamed:rightName];
    rightAtt.bounds = CGRectMake(0, 0, 10, 10);
    NSAttributedString *rightAttString = [NSAttributedString attributedStringWithAttachment:rightAtt];
    
    //添加
    [str appendAttributedString:attriStr];
    [str appendAttributedString:rightAttString];
    
    return str;
}

/**
 *  计算富文本字体高度
 *
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
-(CGSize)getLabelHeightWithFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];

    // NSKernAttributeName字体间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}



//为空
-(BOOL)isNull{
    if ([self isEqualToString:@""]) {
        return YES;
    }
    return NO;
}


-(NSString*)ReplacStrWithReplaceArr:(NSArray*)replaceArr endStr:(NSString*)endStr{
    NSMutableString *strM = [NSMutableString string];

    [strM appendString:[self stringByReplacingOccurrencesOfString:replaceArr[0] withString:replaceArr[1]]];
    [strM appendString:endStr];
    
    return strM.copy;
}




//去掉无意义的0
+ (NSString *)stringDisposeWithFloatStringValue:(NSString *)floatStringValue {
    NSString *str = floatStringValue;
    NSUInteger len = str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else {
            if ([str rangeOfString:@"."].location != NSNotFound) {
                str = [str substringToIndex:[str length]-1];
            } else {
                break;
            }
        }
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        return [str substringToIndex:[str length]-1];//s.substring(0, len - i - 1);
    }
    else
    {
        return str;
    }
}

//此方法去掉2.0000这样的浮点后面多余的0
//传人一个浮点字符串,需要保留几位小数则保留好后再传
+ (NSString *)stringDisposeWithFloatValue:(float)floatNum {
    
    NSString *str = [NSString stringWithFormat:@"%.2f",floatNum];
    NSUInteger len = str.length;
    for (int i = 0; i < len; i++)
    {
        if (![str  hasSuffix:@"0"])
            break;
        else
            str = [str substringToIndex:[str length]-1];
    }
    if ([str hasSuffix:@"."])//避免像2.0000这样的被解析成2.
    {
        return [str substringToIndex:[str length]-1];//s.substring(0, len - i - 1);
    }
    else
    {
        return str;
    }
}



+ (NSString *)ittemThousandPointsFromNumString:(NSString *)numString {
    NSString *str = numString;
    
    NSString *preStr = @"";
    if ([str rangeOfString:@"-"].location != NSNotFound) {
        str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
        preStr = @"-";
    }
    
    NSString *lastStr = @"";
    if ([str rangeOfString:@"."].location != NSNotFound) {
        NSArray *array = [str componentsSeparatedByString:@"."];
        if (array.count > 1) {
            str = array[0];
            lastStr = [NSString stringWithFormat:@".%@",array[1]];
        }
    }
    
    NSUInteger len = [str length];
    NSUInteger x = len % 3;
    NSUInteger y = len / 3;
    NSUInteger dotNumber = y;
    
    if (x == 0) {
        dotNumber -= 1;
        x = 3;
    }
    NSMutableString *rs = [@"" mutableCopy];
    
    [rs appendString:[str substringWithRange:NSMakeRange(0, x)]];
    
    for (int i = 0; i < dotNumber; i++) {
        [rs appendString:@","];
        [rs appendString:[str substringWithRange:NSMakeRange(x + i * 3, 3)]];
    }
    rs = [NSMutableString stringWithFormat:@"%@%@",preStr,rs];
    [rs appendString:lastStr];
    return rs;
}

- (CGSize)ex_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize resultSize;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(boundingRectWithSize:options:attributes:context:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(boundingRectWithSize:options:attributes:context:)];
        NSDictionary *attributes = @{ NSFontAttributeName:font };
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        NSStringDrawingContext *context;
        [invocation setArgument:&size atIndex:2];
        [invocation setArgument:&options atIndex:3];
        [invocation setArgument:&attributes atIndex:4];
        [invocation setArgument:&context atIndex:5];
        [invocation invoke];
        CGRect rect;
        [invocation getReturnValue:&rect];
        resultSize = rect.size;
    } else {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(sizeWithFont:constrainedToSize:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(sizeWithFont:constrainedToSize:)];
        [invocation setArgument:&font atIndex:2];
        [invocation setArgument:&size atIndex:3];
        [invocation invoke];
        [invocation getReturnValue:&resultSize];
    }
    
    return resultSize;
}


//文字没有设置行间距。
- (CGFloat)getHeightWithFont:(CGFloat)fontSize constrainedToWidth:(CGFloat)width{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
    
    return ceil(textSize.height);
}
//文字设置了行间距
- (CGFloat)getHeightWithFont:(CGFloat)fontSize constrainedToWidth:(CGFloat)width lineSpacing:(CGFloat)lineSpacing{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.lineSpacing  = lineSpacing;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
    
    return ceil(textSize.height);
}


/**
 *  改变某些文字的颜色 并单独设置其字体
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param totalString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)ls_changeFontAndColor:(UIFont *)font Color:(UIColor *)color TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray {
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    
    for (NSString *rangeStr in subArray) {
        
        NSRange range = [totalString rangeOfString:rangeStr options:NSBackwardsSearch];
        
        [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        [attributedStr addAttribute:NSFontAttributeName value:font range:range];
    }
    
    return attributedStr;
}


@end
