//
//  JYCustomWebViewProtocol.h
//  JYNSURLProtocolDemo
//
//  Created by James Yu on 15/8/25.
//  Copyright (c) 2015年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYCustomWebViewProtocol : NSURLProtocol

+ (void)startListeningNetWorking;
+ (void)cancelListeningNetWorking;

@end
