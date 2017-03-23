//
//  NSNumber+Extension.m
//  RGfzzd
//
//  Created by admin on 16/12/19.
//  Copyright © 2016年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import "NSNumber+Extension.h"

@implementation NSNumber (Extension)


//年月日
- (NSString *)ReturnDateWithFormatter:(NSString*)format{
    
    NSDate *date = [self CreateDate];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    
    //    [dateformatter setDateFormat:@"yyyy-MM-dd"];//12小时
    [dateformatter setDateFormat:format];//24小时
    
    return [dateformatter stringFromDate:date];
}

//年月日时分秒
- (NSString *)ReturnDateAndTiem{
    
    NSDate *date = [self CreateDate];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    
    //    [dateformatter setDateFormat:@"yyyy-MM-dd hh:mm"];//12小时
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];//24小时
    return [dateformatter stringFromDate:date];
    
}

//年月日
- (NSString *)ReturnDate{
    
    NSDate *date = [self CreateDate];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    
    //    [dateformatter setDateFormat:@"yyyy-MM-dd"];//12小时
    [dateformatter setDateFormat:@"yyyy/MM/dd"];//24小时
    
    return [dateformatter stringFromDate:date];
}

//年月
- (NSString *)ReturnYearOrMonth{
    
    NSDate *date = [self CreateDate];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    
    //    [dateformatter setDateFormat:@"yyyy-MM-dd"];//12小时
    [dateformatter setDateFormat:@"yyyy-MM"];//24小时
    
    return [dateformatter stringFromDate:date];
}

//年月日
- (NSString *)ReturnSymbolDate{
    
    NSDate *date = [self CreateDate];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    
    //    [dateformatter setDateFormat:@"yyyy-MM-dd"];//12小时
    [dateformatter setDateFormat:@"yyyy/MM/dd"];//24小时
    
    
    return [dateformatter stringFromDate:date];
}


-(NSDate*)CreateDate{
    NSString *str1 = [NSString stringWithFormat:@"%@",self];
    int x = [[str1 substringToIndex:10] intValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:x];
    
    return date;
}

@end
