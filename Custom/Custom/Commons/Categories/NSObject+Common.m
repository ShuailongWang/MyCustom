//
//  NSObject+Common.m
//  RGfzzd
//
//  Created by admin on 16/12/7.
//  Copyright © 2016年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import "NSObject+Common.h"

@implementation NSObject (Common)

//显示成功信息
+ (void)showSuccessMsg:(NSString *)success {
    MBProgressHUD *progresshud = [self createCustomeHud];
    progresshud.label.text = success;
    [progresshud hideAnimated:YES afterDelay:1];
}
//显示失败信息
+ (void)showErrorMsg:(NSString *)error {
    MBProgressHUD *progresshud = [self createCustomeHud];
    progresshud.label.text = error;
    [progresshud hideAnimated:YES afterDelay:1];
}

//创建MBProgressHUD
+ (MBProgressHUD *)createCustomeHud {
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *progresshud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    progresshud.detailsLabel.font = [UIFont boldSystemFontOfSize:16];
    progresshud.mode = MBProgressHUDModeCustomView;
    [window addSubview:progresshud];
    [progresshud showAnimated:YES];
    
    return progresshud;
}






@end
