//
//  RGWebProgressLayer.h
//  RGApp
//
//  Created by admin on 17/3/22.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface RGWebProgressLayer : CAShapeLayer

- (void)finishedLoad;
- (void)startLoad;

- (void)closeTimer;

@end
