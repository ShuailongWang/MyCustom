//
//  WelcomeController.m
//  Custom
//
//  Created by admin on 17/3/24.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "WelcomeController.h"

@interface WelcomeController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView *myCollectionView;
@property (strong,nonatomic) UIPageControl *pageControl;
@property (strong,nonatomic) NSArray *imageArr;

@end

@implementation WelcomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupUI];
}

-(void)setupUI{
    if (nil == _myCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _myCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.pagingEnabled = YES;
        _myCollectionView.bounces = NO;
        _myCollectionView.showsVerticalScrollIndicator = NO;
        _myCollectionView.showsHorizontalScrollIndicator = NO;
        _myCollectionView.backgroundColor = [UIColor grayColor];
        [_myCollectionView registerClass:[WelcomeCell class] forCellWithReuseIdentifier:@"WelcomeCell"];
        [self.view addSubview:_myCollectionView];
    }
    if (nil == _pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = self.imageArr.count;
        _pageControl.tintColor = [UIColor redColor];
        [self.view addSubview:_pageControl];
    }
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.pageControl.frame = CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 40);
}

#pragma Mark - UICollectionDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WelcomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WelcomeCell" forIndexPath:indexPath];
    cell.imageName = self.imageArr[indexPath.item];
    if (indexPath.item == self.imageArr.count - 1) {
        [cell showFreshButton];
    }
    cell.myBlock = ^(){
        NSLog(@"回调");
    };
    return cell;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat idx = offsetX / scrollView.bounds.size.width;
    self.pageControl.currentPage = idx;
}

-(NSArray *)imageArr{
    if (nil == _imageArr) {
        _imageArr = @[@"",@"",@"",@""];
    }
    return _imageArr;
}

@end


@interface WelcomeCell()
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UIButton *freshBtn;
@end
@implementation WelcomeCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (nil == _imageView) {
            _imageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
            [self.contentView addSubview:_imageView];
        }
        if (nil == _freshBtn) {
            CGSize size = self.contentView.bounds.size;
            CGFloat x = size.width / 3;
            CGFloat y = size.height - 80;
            _freshBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, x, 30)];
            [_freshBtn setTitle:@"立即加入" forState:UIControlStateNormal];
            [_freshBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _freshBtn.backgroundColor = [UIColor blueColor];
            _freshBtn.layer.cornerRadius = 10;
            _freshBtn.layer.masksToBounds = YES;
            _freshBtn.hidden = YES;
            [_freshBtn addTarget:self action:@selector(clickFreshButton) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_freshBtn];
        }
    }
    return self;
}
-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.imageView.image = [UIImage imageNamed:imageName];
}
-(void)showFreshButton{
    self.freshBtn.hidden = NO;
}
-(void)clickFreshButton{
    if (self.myBlock) {
        self.myBlock();
    }
}
@end

