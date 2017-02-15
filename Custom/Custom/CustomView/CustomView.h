//
//  CustomView.h
//  Custom
//
//  Created by admin on 17/2/15.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomView;
@protocol CustomViewDelegate <NSObject>

@optional
-(void)CustomView:(CustomView*)customView viewHeight:(CGFloat)viewHeight;

@end

@interface CustomView : UIView

/**背景颜色*/
@property (assign,nonatomic) UIColor *CustomBackgroundColor;

/**标签颜色*/
@property (assign,nonatomic) UIColor *LabelBackgroundColor;

/**标签数组*/
@property (nonatomic, strong) NSArray *labelArr;

@property (weak,nonatomic) id<CustomViewDelegate> customDelegate;
@property (copy,nonatomic) void(^myBlock)(CGFloat viewHeight);

@end
