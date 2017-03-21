//
//  loginViewController.m
//  Uepp-0307
//
//  Created by 严 on 2017/3/20.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //回到主界面调整好网络接口后删除
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    backbutton.backgroundColor = UIColorFromRGB(0x1C86EE);
    [self.view addSubview:backbutton];
    [backbutton setTitle: @"返回主界面" forState:UIControlStateNormal];
    [backbutton setTintColor:[UIColor whiteColor]];
    backbutton.layer.cornerRadius = 5;
    [backbutton makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        make.centerY.equalTo(60);
        make.width.equalTo(150);
        make.height.equalTo(50);
    }];
    [backbutton addTarget:self action:@selector(backUprootView) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)backUprootView{
    
      [self dismissViewControllerAnimated:YES completion:nil];
}

@end
