//
//  WelcomeController.h
//  Custom
//
//  Created by admin on 17/3/24.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeController : UIViewController

@end


@interface WelcomeCell : UICollectionViewCell

@property (copy,nonatomic) NSString *imageName;
@property (copy,nonatomic) void(^myBlock)();

-(void)showFreshButton;

@end
