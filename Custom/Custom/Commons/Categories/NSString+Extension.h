//
//  NSString+Extension.h
//  RGfzzd
//
//  Created by admin on 16/12/14.
//  Copyright © 2016年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Extension)


/**
 根据文字获取size(宽度已经确定)

 @param fontSize 字号

 @return size
 */
-(CGSize)StringWithSize:(CGFloat)fontSize;


/**
 根据文字获取size

 @param fontSize 字号
 @param size     size

 @return size
 */
- (CGFloat)getHeightWithFont:(CGFloat)fontSize constrainedToSize:(CGSize)size;

- (CGFloat)getWidthWithFont:(CGFloat)fontSize constrainedToSize:(CGSize)size;


/**
 返回富文本
 
 @return 富文本
 */
-(NSAttributedString*)addAttriButedWithLeftName:(NSString*)leftName rightName:(NSString*)rightName;

-(NSAttributedString*)addAttriButedWithRightName:(NSString*)rightName;

/**
 *  计算富文本字体高度
 *
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
-(CGSize)getLabelHeightWithFont:(UIFont*)font withWidth:(CGFloat)width ;

//为空判断
-(BOOL)isNull;


-(NSString*)ReplacStrWithReplaceArr:(NSArray*)replaceArr endStr:(NSString*)endStr;


//去掉无意义的0
+ (NSString *)stringDisposeWithFloatStringValue:(NSString *)floatStringValue;
+ (NSString *)stringDisposeWithFloatValue:(float)floatNum;

//千分位格式化数据
+ (NSString *)ittemThousandPointsFromNumString:(NSString *)numString;

//计算字符串的CGSize
- (CGSize)ex_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;


//文字没有设置行间距。
- (CGFloat)getHeightWithFont:(CGFloat)fontSize constrainedToWidth:(CGFloat)width;
//文字设置了行间距
- (CGFloat)getHeightWithFont:(CGFloat)fontSize constrainedToWidth:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;


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
+ (NSMutableAttributedString *)ls_changeFontAndColor:(UIFont *)font Color:(UIColor *)color TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray;

@end
















