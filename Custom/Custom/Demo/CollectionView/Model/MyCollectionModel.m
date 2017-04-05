//
//  MyCollectionModel.m
//  Custom
//
//  Created by admin on 17/4/5.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "MyCollectionModel.h"

@implementation MyCollectionModel

+(void)MyCollectionModelWithData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Type" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        MyCollectionModel *model = [MyCollectionModel yy_modelWithDictionary:dict];
        
        [arrayM addObject:model];
    }
    
    //保存到本地
    [kUserDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:arrayM.copy] forKey:KTypeListKey];
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.icon forKey:@"icon"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.icon = [aDecoder decodeObjectForKey:@"icon"];
    }
    return self;
}


@end
