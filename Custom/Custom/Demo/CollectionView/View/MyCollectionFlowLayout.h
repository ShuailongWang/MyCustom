//
//  MyCollectionFlowLayout.h
//  Custom
//
//  Created by admin on 17/4/5.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MyCollectionFlowLayoutDelegate <NSObject>

- (BOOL)canMoveSortCollectionViewItemAtIndex;       //是否移动
- (void)moveSortCollectionViewItemDone;             //移动
- (void)currentIndexPath:(NSIndexPath *)fromeIndexPath movedToIndexPath:(NSIndexPath *)toIndexPath;

@end

@interface MyCollectionFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<MyCollectionFlowLayoutDelegate> datasource;
@property (nonatomic, assign) NSInteger commonCount; //常用数量

@end
