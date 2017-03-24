//
//  AppDelegate.h
//  Custom
//
//  Created by admin on 17/2/15.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) BOOL isFull;  //webView中的视频是否允许自动旋转
@property (nonatomic, strong) UITabBarController *mainTabBar;


@end

