//
//  MyCollectionViewController.m
//  Custom
//
//  Created by admin on 17/4/5.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionModel.h"
#import "MyCollectionViewCell.h"
#import "MyCollectionFlowLayout.h"
#import "MyCollectionReusableView.h"

@interface MyCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,MyCollectionFlowLayoutDelegate>

@property (nonatomic, strong) UIButton *manageButton;
@property (nonatomic, assign) BOOL isSelectManageButton;
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) MyCollectionFlowLayout *collectionViewLayout;
@property (nonatomic, strong) NSMutableArray *commonArray;  //常用
@property (nonatomic, strong) NSMutableArray *moreArray;    //更多

@end

static NSString * const MyCollectionViewCellID     = @"MyCollectionViewCell";
static NSString * const MyCollectionReusableViewID = @"MyCollectionReusableView";

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [MyCollectionModel MyCollectionModelWithData];
    
    [self setUpTheViewFrame];
}

- (void)setUpTheViewFrame {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"分类";
    //导航栏右边按钮
    UIBarButtonItem *rightBarButtonitem = [[UIBarButtonItem alloc] initWithCustomView:self.manageButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -8;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,rightBarButtonitem];
    
    if (nil == _myCollectionView) {
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewLayout];
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        _myCollectionView.dataSource = self;
        _myCollectionView.delegate = self;
        [_myCollectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:MyCollectionViewCellID];
        [_myCollectionView registerClass:[MyCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MyCollectionReusableViewID];
        _myCollectionView.frame = self.view.bounds;
        self.collectionViewLayout.itemSize = CGSizeMake((KScreen_Width - 90)/4, (KScreen_Width - 90)/4 + 22);
        [self.view addSubview:_myCollectionView];
    }
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.commonArray.count;
    }else{
        return self.moreArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MyCollectionViewCellID forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell setTheCellRightTopImageContent:self.isSelectManageButton ? TopRightImageDelete_Type : TopRightImageHide_Type];
        [cell setTheCellContent:self.commonArray[indexPath.item]];
    }else if (indexPath.section == 1 ) {
        [cell setTheCellRightTopImageContent:self.isSelectManageButton ? TopRightImageAdd_Type : TopRightImageHide_Type];
        [cell setTheCellContent:self.moreArray[indexPath.item]];
    }
    return cell;
}
//头视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return CGSizeMake(CGRectGetWidth(self.view.bounds), 40);
            break;
        case 1:
            return CGSizeMake(CGRectGetWidth(self.view.bounds), 50);
            break;
        default:
            return CGSizeMake(CGRectGetWidth(self.view.bounds),0.000001);
            break;
    }
    
}
//头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    MyCollectionReusableView *headerView = (MyCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MyCollectionReusableViewID forIndexPath:indexPath];
    headerView.isSelectManageButton = self.isSelectManageButton;
    headerView.sectionIndex = indexPath.section;
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.isSelectManageButton) {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[self.myCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.item inSection:indexPath.section]];
        NSLog(@"selected %@",cell.model.name);
        return;
    }
    //常用为8
    if (self.commonArray.count == 8) {
        return;
    }
    id removeItem;
    if (indexPath.section == 0) {
        removeItem = self.commonArray[indexPath.item];
        [self.commonArray removeObjectAtIndex:indexPath.item];
    }
    if (indexPath.section == 1) {
        removeItem = self.moreArray[indexPath.item];
        [self.moreArray removeObjectAtIndex:indexPath.item];
    }
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[self.myCollectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        [self.moreArray insertObject:removeItem atIndex:0];
        [self.myCollectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
        //需要更新cell右上角的图片状态为添加
        [cell setTheCellRightTopImageContent:TopRightImageAdd_Type];
    }
    if (indexPath.section == 1) {
        [self.commonArray insertObject:removeItem atIndex:0];
        [self.myCollectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        //需要更新cell右上角的图片状态为删除
        [cell setTheCellRightTopImageContent:TopRightImageDelete_Type];
    }
    self.collectionViewLayout.commonCount = self.commonArray.count;
    [self.myCollectionView reloadData];
}

#pragma APHomePageSortBasicLayoutDataSource methods
- (BOOL)canMoveSortCollectionViewItemAtIndex {
    return self.isSelectManageButton;
}

- (void)moveSortCollectionViewItemDone {
    [self.myCollectionView reloadData];
}
//把更多的天骄到常用中
- (void)currentIndexPath:(NSIndexPath *)fromeIndexPath movedToIndexPath:(NSIndexPath *)toIndexPath {

    MyCollectionModel *tempModel = [self.commonArray objectAtIndex:fromeIndexPath.item];
    [self.commonArray removeObjectAtIndex:fromeIndexPath.item];
    [self.commonArray insertObject:tempModel atIndex:toIndexPath.item];
}

#pragma mark - 管理
- (void)manageButtonEvent {
    //如果没有内容为不可编辑
    if (!self.commonArray.count && !self.moreArray.count) {
        return;
    }
    if (!self.isSelectManageButton) {
        [_manageButton setTitle:@"完成" forState:UIControlStateNormal];
        self.isSelectManageButton = YES;
        self.collectionViewLayout.commonCount = self.commonArray.count;
    }else{
        [_manageButton setTitle:@"管理" forState:UIControlStateNormal];
        self.isSelectManageButton = NO;
        
        //保存本地
        [kUserDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:self.commonArray] forKey:KCommonListKey];
        [kUserDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:self.moreArray] forKey:KTypeListKey];
    }
    [self.myCollectionView reloadData];
}

#pragma mark - 懒加载
- (UIButton *)manageButton {
    if (_manageButton == nil) {
        _manageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_manageButton setExclusiveTouch:YES];
        [_manageButton setFrame:CGRectMake(0, 0, 40, 44)];
        [_manageButton addTarget:self action:@selector(manageButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        [_manageButton setTitle:@"管理" forState:UIControlStateNormal];
        [_manageButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_manageButton setTitleColor:HEXColor(0xfea700) forState:UIControlStateHighlighted];
        _manageButton.titleLabel.font = [UIFont systemFontOfSize:16.];
    }
    return _manageButton;
}

- (MyCollectionFlowLayout *)collectionViewLayout{
    if (_collectionViewLayout == nil) {
        _collectionViewLayout = [[MyCollectionFlowLayout alloc] init];
        _collectionViewLayout.minimumLineSpacing = 15;
        _collectionViewLayout.minimumInteritemSpacing = 20;
        _collectionViewLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        _collectionViewLayout.datasource = self;
    }
    return _collectionViewLayout;
}

- (NSMutableArray *)commonArray {
    if (_commonArray == nil) {
        _commonArray = [NSMutableArray array];
        
        NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:KCommonListKey]];
        [_commonArray addObjectsFromArray:arr];
    }
    return _commonArray;
}

- (NSMutableArray *)moreArray {
    if (_moreArray == nil) {
        _moreArray = [NSMutableArray array];
        
        NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:KTypeListKey]];
        [_moreArray addObjectsFromArray:arr];
    }
    return _moreArray;
}

@end
