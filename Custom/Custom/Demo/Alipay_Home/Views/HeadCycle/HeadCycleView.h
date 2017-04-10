//
//  HeadCycleView.h
//  支付宝首页
//
//  Created by admin on 17/4/10.
//  Copyright © 2017年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeadCycleView;
@protocol HeadCycleViewDelegate <NSObject>

-(void)HeadCycleView:(HeadCycleView*)headCycleView index:(NSInteger)index;

@end

@interface HeadCycleView : UIView

@property (weak,nonatomic) id<HeadCycleViewDelegate> delegate;

@end
