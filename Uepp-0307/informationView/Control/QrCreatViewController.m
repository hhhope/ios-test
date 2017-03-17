//
//  QrCreatViewController.m
//  Uepp-0307
//
//  Created by 严 on 2017/3/15.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "QrCreatViewController.h"
#import "creatQRcode.h"

@interface QrCreatViewController ()

@end

@implementation QrCreatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = UIColorFromRGB(0XEBEBEB);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text =@"固定收款二维码";
    
    titleLabel.textColor =[UIColor whiteColor];
    self.navigationItem.titleView =titleLabel;
    UIView *qrView = [[UIView alloc]init];
    qrView.backgroundColor = [UIColor whiteColor];
    [qrView.layer setCornerRadius:8];
    [self.view addSubview:qrView];
    [qrView makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(104);
        make.left.offset(25);
        make.right.offset(-25);
        make.height.offset(450);

    }];
    UILabel *label  = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:35];
    label.text = @"扫一扫付款";
    label.textAlignment = NSTextAlignmentCenter;
    [qrView addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.centerX.offset(0);
    }];
    creatQRcode *qrCode = [[creatQRcode alloc]init];
    UIImageView *qrImageView = [[UIImageView alloc]init];
    qrImageView = [qrCode creatQrcodeimage:@"http://blog.csdn.net/chengyakun11/article/details/7668470"];
    [qrView addSubview:qrImageView];
    [qrImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(-20);
        make.left.offset(40);
        make.right.offset(-40);
    }];
    UIView *linView = [[UIView alloc]init];
    [qrView addSubview:linView];
    [linView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-70);
        make.left.offset(0);
        make.right.offset(0);
        make.height.equalTo(1);
    }];
    linView.backgroundColor = [UIColor lightGrayColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
