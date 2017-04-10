//
//  FunctionView.m
//  支付宝首页
//
//  Created by admin on 17/4/10.
//  Copyright © 2017年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import "FunctionView.h"

@interface FunctionView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *myCollectionView;

@end

static NSString *FunctionViewCellID = @"FunctionViewCellID";

@implementation FunctionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (nil == _myCollectionView) {
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
            flowLayout.minimumLineSpacing = 0;
            flowLayout.minimumInteritemSpacing = 0;
            flowLayout.itemSize = CGSizeMake(self.width/4, self.width/6);
            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            
            _myCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
            _myCollectionView.delegate = self;
            _myCollectionView.dataSource = self;
            _myCollectionView.pagingEnabled = YES;
            _myCollectionView.backgroundColor = [UIColor whiteColor];
            [_myCollectionView registerClass:[FunctionViewCell class] forCellWithReuseIdentifier:FunctionViewCellID];
            [self addSubview:_myCollectionView];
        }
    }
    return self;
}


#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FunctionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FunctionViewCellID forIndexPath:indexPath];

    [cell textName:@"标题" imageName:@"item1"];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(didSelectIitem)]) {
        [self.delegate didSelectIitem];
    }
}


@end



#pragma mark - FunctionViewCell
@interface FunctionViewCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation FunctionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    if (nil == _iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 40, 40)];
        _iconImageView.centerX = self.contentView.centerX;
        [self.contentView addSubview:_iconImageView];
    }
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, _iconImageView.bottom, self.width - 10, 20)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
    }
}

-(void)textName:(NSString*)textName imageName:(NSString*)imageName{
    self.iconImageView.image = [UIImage imageNamed:imageName];
    self.titleLabel.text = textName;
}

@end
