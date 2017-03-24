//
//  CustomScrollingNavbarViewController.h
//  Custom
//
//  Created by admin on 17/3/24.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomScrollingNavbarViewController : UIViewController

/** Scrolling init method
 *
 * Enables the scrolling on a generic UIView.
 *
 * @param scrollableView The UIView where the scrolling is performed.
 */
- (void)followScrollView:(UIView*)scrollableView;

@end
