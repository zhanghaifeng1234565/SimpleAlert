//
//  ViewController.m
//  SimpleAlertView
//
//  Created by iOS on 2017/12/8.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import "ViewController.h"

#import "SureCanceAlert.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[SureCanceAlert shareAlert] setTitleText:@"确定删除此消息？" withMaxHeight:100 withSureBtnClick:^(UIButton *sender) {
        NSLog(@"确定啦");
    } withCancelBtnClick:^(UIButton *sender) {
        NSLog(@"取消啦");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
