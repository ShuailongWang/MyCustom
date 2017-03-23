//
//  JYCustomWebViewProtocol.m
//  JYNSURLProtocolDemo
//
//  Created by James Yu on 15/8/25.
//  Copyright (c) 2015年 James. All rights reserved.
//

#import "JYCustomWebViewProtocol.h"
#import <UIKit/UIKit.h>
#import "SDWebImageManager.h"
#import "UIImage+MultiFormat.h"
#import "NSData+ImageContentType.h"
#import "UIImage+GIF.h"
#import "NSURLProtocol+WebKitSupport.h"

static NSString * const hasInitKey = @"JYCustomWebViewProtocolKey";

@interface JYCustomWebViewProtocol ()

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSURLConnection *connection;

@end

//标识
static NSString * const URLProtocolAlreadyHandleKey = @"alreadyHandle";
static NSString * const checkUpdateInBgKey = @"checkUpdateInBg";

@implementation JYCustomWebViewProtocol

+ (void)startListeningNetWorking{
    [JYCustomWebViewProtocol registerClass:[JYCustomWebViewProtocol class]];
    for (NSString* scheme in @[@"http", @"https"]) {
        [NSURLProtocol wk_registerScheme:scheme];
    }
}

+ (void)cancelListeningNetWorking{
    [NSURLProtocol unregisterClass:[JYCustomWebViewProtocol class]];
}

//返回YES我们才能够继续后续的处理。
//我们可以在这个方法的实现里面进行请求的过滤，筛选出需要进行处理的请求。
//YES处理,NO不处理
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSString* extension = request.URL.pathExtension;
    //NSLog(@"%@",request.URL);
    BOOL isImage = [@[@"png", @"jpeg", @"gif", @"jpg"] indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [extension compare:obj options:NSCaseInsensitiveSearch] == NSOrderedSame;
    }] != NSNotFound;
    return [NSURLProtocol propertyForKey:hasInitKey inRequest:request] == nil && isImage;
}

//1.返回规范化后的request,一般就只是返回当前request即可。
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    //这边可用干你想干的事情。。更改地址，提取里面的请求内容，或者设置里面的请求头。。
    return mutableReqeust;
}

//开始
- (void)startLoading{
    //NSLog(@"11");
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    //做下标记，防止递归调用
    [NSURLProtocol setProperty:@YES forKey:hasInitKey inRequest:mutableReqeust];
    
    //查看本地是否已经缓存了图片
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:self.request.URL];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    NSData *SDdata = UIImagePNGRepresentation(image);
    
    NSData *thisData = nil;
    //加载本地图片
    NSString *fileName = [[self.request.URL.absoluteString lastPathComponent] stringByDeletingPathExtension];   //图片的文件名字
    if ([self.request.URL.absoluteString hasSuffix:@".gif"]) {
        thisData = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:fileName ofType:@"gif"]];
    }else{
        UIImage *image = [UIImage imageNamed:fileName];
        thisData = UIImagePNGRepresentation(image);
    }
    
    //赋值
    NSData *data = nil;
    if (thisData) {
        data = thisData;
    }else if(SDdata){
        data = SDdata;
    }
    
    if (data) {
        //NSLog(@"有图片缓存,加载本地");
        
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:mutableReqeust.URL MIMEType:[NSData sd_contentTypeForImageData:data] expectedContentLength:data.length textEncodingName:nil];
        
        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
    }
    else {
        //NSLog(@"没有图片缓存,发送请求");
        self.connection = [NSURLConnection connectionWithRequest:mutableReqeust delegate:self];
    }
    
}

//结束
- (void)stopLoading{
    [self.connection cancel];
}

#pragma mark- NSURLConnectionDelegate
//请求失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [self.client URLProtocol:self didFailWithError:error];
}

#pragma mark - NSURLConnectionDataDelegate
//请求返回
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.responseData = [[NSMutableData alloc] init];
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

//请求的数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
    [self.client URLProtocol:self didLoadData:data];
}

//请求成功
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

    UIImage *cacheImage = [UIImage sd_imageWithData:self.responseData];
    //NSLog(@"保存图片");
    
    //利用SDWebImage提供的缓存进行保存图片
    [[SDImageCache sharedImageCache] storeImage:cacheImage recalculateFromImage:NO imageData:self.responseData forKey:[[SDWebImageManager sharedManager] cacheKeyForURL:self.request.URL] toDisk:YES];
    
    [self.client URLProtocolDidFinishLoading:self];
}

@end
