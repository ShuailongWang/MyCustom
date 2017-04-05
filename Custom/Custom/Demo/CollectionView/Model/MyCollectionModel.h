//
//  MyCollectionModel.h
//  Custom
//
//  Created by admin on 17/4/5.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCollectionModel : NSObject<NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;

+(void)MyCollectionModelWithData;

@end
