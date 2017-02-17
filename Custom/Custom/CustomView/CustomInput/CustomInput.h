//
//  CustomInput.h
//  RGFZZD
//
//  Created by admin on 17/2/17.
//  Copyright © 2017年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ConfirmBlock)(NSString *inputContent);

@interface CustomInput : NSObject

/**
 *  点击确定按钮回调
 */
+(void)showInput:(ConfirmBlock)confirmHandler;

/**
 *  设置默认文字
 */
+(void)setNormalContent:(NSString *)content;

/**
 *  输入文字的最大长度
 */
+(void)setMaxContentLength:(NSInteger)lenght;

/**
 *  设置标题
 */
+(void)setDescTitle:(NSString *)descTitle;

@end
