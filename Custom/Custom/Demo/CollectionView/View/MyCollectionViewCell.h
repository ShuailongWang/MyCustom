//
//  MyCollectionViewCell.h
//  Custom
//
//  Created by admin on 17/4/5.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TopRightImageDelete_Type,   //加号
    TopRightImageAdd_Type,      //减号
    TopRightImageHide_Type      //无
} TopRightImageShowType;

@class MyCollectionModel;
@interface MyCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) MyCollectionModel *model;

- (void)setTheCellContent:(MyCollectionModel *)model;
- (void)setTheCellRightTopImageContent:(TopRightImageShowType)type;

@end
