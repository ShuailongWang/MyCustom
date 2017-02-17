//
//  FourViewController.m
//  Custom
//
//  Created by admin on 17/2/15.
//  Copyright © 2017年 wsl. All rights reserved.
//

#import "FourViewController.h"
#import "CustomInput.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [CustomInput setDescTitle:@"请输入"];
    [CustomInput setMaxContentLength:10];
    [CustomInput setNormalContent:@"输入你想输入的..."];
    [CustomInput showInput:^(NSString *inputContent) {
        NSLog(@"%@", inputContent);
    }];
}

@end
