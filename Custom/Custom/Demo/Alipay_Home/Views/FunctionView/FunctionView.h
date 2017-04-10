//
//  FunctionView.h
//  支付宝首页
//
//  Created by admin on 17/4/10.
//  Copyright © 2017年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FunctionViewDelegate <NSObject>

-(void)didSelectIitem;

@end

@interface FunctionView : UIView

@property (weak,nonatomic) id<FunctionViewDelegate> delegate;

@end



@interface FunctionViewCell : UICollectionViewCell

-(void)textName:(NSString*)textName imageName:(NSString*)imageName;

@end
