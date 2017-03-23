//
//  NSNumber+Extension.h
//  RGfzzd
//
//  Created by admin on 16/12/19.
//  Copyright © 2016年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Extension)

//年月日
- (NSString *)ReturnDateWithFormatter:(NSString*)format;

/**
 根据秒返回年月日时分
 
 @return NSString
 */
- (NSString *)ReturnDateAndTiem;

/**
 根据秒返回年月日
 
 @return NSString
 */
- (NSString *)ReturnDate;

/**
 年/月/日
 */
- (NSString *)ReturnSymbolDate;

/**
 年-月
 */
- (NSString *)ReturnYearOrMonth;

@end
