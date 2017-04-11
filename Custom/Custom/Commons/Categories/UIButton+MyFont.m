//
//  UIButton+MyFont.m
//  RGFZZD
//
//  Created by admin on 17/2/23.
//  Copyright © 2017年 北京奥泰瑞格科技有限公司. All rights reserved.
//

#import "UIButton+MyFont.h"
#import <objc/runtime.h>


@implementation UIButton (MyFont)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不像改变字体的 把tag值设置成3333跳过
        if(self.titleLabel.tag != 3333){
            CGFloat fontSize = self.titleLabel.font.pointSize;
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize * SizeScale];
        }
    }
    return self;
}

@end


@implementation UILabel (myFont)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不像改变字体的 把tag值设置成3333跳过
        if(self.tag != 3333){
            CGFloat fontSize = self.font.pointSize;
            self.font = [UIFont systemFontOfSize:fontSize*SizeScale];
        }
    }
    return self;
}

@end

