//
//  MyCollectionViewCell.m
//  Custom
//
//  Created by admin on 17/4/5.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "MyCollectionModel.h"
#import <UIButton+WebCache.h>

@interface MyCollectionViewCell()

@property (nonatomic, strong) UIImageView *topRightImageV;

@end

@implementation MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    [self.contentView addSubview:self.imageButton];
    [self.contentView addSubview:self.titleButton];
    [self.contentView addSubview:self.topRightImageV];
    
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self);
        make.height.mas_equalTo(CGRectGetWidth(self.bounds));
    }];
    
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.equalTo(self);
        make.top.mas_equalTo(self.imageButton.mas_bottom);
    }];
    
    [self.topRightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(6.);
        make.right.mas_equalTo(self.mas_right).offset(-6.);
        make.width.and.height.mas_equalTo(15.);
    }];
}

#pragma mark - 方法
- (void)setTheCellContent:(MyCollectionModel *)model {

    self.model = model;
    
    //赋值
    [self.titleButton setTitle:model.name != nil ? model.name : @"" forState:UIControlStateNormal];
    [self.imageButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.icon]] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageRefreshCached];
}

- (void)setTheCellRightTopImageContent:(TopRightImageShowType)type {
    _topRightImageV.hidden = NO;
    if (type == TopRightImageAdd_Type) {
        _topRightImageV.image = [UIImage imageNamed:@"sortimage_add"];
    }else if (type == TopRightImageDelete_Type) {
        _topRightImageV.image = [UIImage imageNamed:@"sortimage_delete"];
    }else if (type == TopRightImageHide_Type) {
        _topRightImageV.hidden = YES;
    }
}


#pragma mark - 懒加载
- (UIButton *)imageButton {
    if (_imageButton == nil) {
        _imageButton = [[UIButton alloc] init];
        _imageButton.userInteractionEnabled = NO;
    }
    return _imageButton;
}
- (UIButton *)titleButton {
    if (_titleButton == nil) {
        _titleButton = [[UIButton alloc] init];
        [_titleButton setTitleColor:HEXColor(0x777777) forState:UIControlStateNormal];
        _titleButton.titleLabel.font = [UIFont systemFontOfSize:13.];
        _titleButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleButton;
}
- (UIImageView *)topRightImageV {
    if (_topRightImageV == nil) {
        _topRightImageV = [[UIImageView alloc] init];
        _topRightImageV.hidden = YES;
    }
    return _topRightImageV;
}

@end
