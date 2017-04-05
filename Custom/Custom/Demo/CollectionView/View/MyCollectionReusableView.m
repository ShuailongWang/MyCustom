//
//  MyCollectionReusableView.m
//  Custom
//
//  Created by admin on 17/4/5.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "MyCollectionReusableView.h"

@interface MyCollectionReusableView()

@property (nonatomic, strong) UILabel *titleLabel;      //标题
@property (nonatomic, strong) UILabel *titleSubLabel;   //副标题
@property (nonatomic, strong) UIView *topLineView;      //顶部线

@end


@implementation MyCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {

    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //防止移动动画时被遮盖
        self.layer.zPosition = -1;
        [self setUpTheViewFrame];
    }
    return self;
}

#pragma mark - Private methods
- (void)setUpTheViewFrame {
    [self addSubview:self.titleLabel];
    [self addSubview:self.titleSubLabel];
    [self addSubview:self.topLineView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15.);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(40.);
        make.height.mas_equalTo(25.);
    }];
    
    [self.titleSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(5.);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.width.mas_equalTo(200.);
        make.height.mas_equalTo(25.);
    }];
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(self);
        make.height.mas_equalTo(10.);
    }];
}

#pragma mark - 懒加载
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18.];
        _titleLabel.textColor = HEXColor(0x444444);
    }
    return _titleLabel;
}
- (UILabel *)titleSubLabel {
    if (_titleSubLabel == nil) {
        _titleSubLabel = [[UILabel alloc] init];
        _titleSubLabel.font = [UIFont systemFontOfSize:13.];
        _titleSubLabel.textColor = HEXColor(0x8d8d8d);
    }
    return _titleSubLabel;
}
- (UIView *)topLineView {
    if (_topLineView == nil) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = HEXColor(0xf5f5f5);
    }
    return _topLineView;
}

//选中
- (void)setSectionIndex:(NSInteger)sectionIndex {
    if (sectionIndex == 0) {
        _titleLabel.text = @"常用";
        _titleSubLabel.text = self.isSelectManageButton ? @"点击可删除，长按可拖动排序" : @"";
        _topLineView.hidden = YES;
    }
    if (sectionIndex == 1) {
        _titleLabel.text = @"更多";
        _titleSubLabel.text = self.isSelectManageButton ? @"点击可添加到常用" : @"";
        _topLineView.hidden = NO;
    }
}


@end
