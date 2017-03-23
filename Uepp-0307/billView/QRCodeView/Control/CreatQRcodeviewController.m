//
//  CreatQRcodeviewController.m
//  Uepp-0307
//
//  Created by 严 on 2017/3/13.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "CreatQRcodeviewController.h"
#import "creatQRcode.h"
@interface CreatQRcodeviewController ()

@end

@implementation CreatQRcodeviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0x1C86EE);
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text =@"二维码收款";
    titleLabel.textColor =[UIColor whiteColor];
    self.navigationItem.titleView =titleLabel;
    //设置左边返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(0, 0, 50, 40);
    //    searchBtn.backgroundColor = [UIColor blackColor];
    backBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:25];
    [backBtn setTitle:@"\U000F0292" forState:UIControlStateNormal];
    backBtn.tintColor= [UIColor whiteColor];
    [backBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *informationCardItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = informationCardItem;

    //设置透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    // Do any additional setup after loading the view.
    //二维码图片生成
    creatQRcode *qrCode = [[creatQRcode alloc]init];
    UIImageView *qrImageView = [[UIImageView alloc]init];
    qrImageView = [qrCode creatQrcodeimage:@"http://blog.csdn.net/chengyakun11/article/details/7668470"];

    //生成二维码图片显示边框
    UIView *qrView = [[UIView alloc]init];
    qrView.backgroundColor = [UIColor whiteColor];
    [qrView.layer setCornerRadius:10];
    [self.view addSubview:qrView];
    [qrView makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(84);
        make.left.offset(30);
        make.right.offset(-30);
        make.height.equalTo(400);
    }];
    UILabel *balLabel = [[UILabel alloc]init];
    NSString *str = [NSString stringWithFormat:@"￥%@",self.amt];
    balLabel.text = str;


    balLabel.layer.borderColor = [[UIColor grayColor] CGColor];
    balLabel.textColor = [UIColor blackColor];
    balLabel.font = [UIFont systemFontOfSize:35];
    balLabel.textAlignment = NSTextAlignmentCenter;
    [qrView addSubview:balLabel];
    [balLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(60);
    }];
    //分割线view
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width-60, 1)];
    lineview.backgroundColor = [UIColor grayColor];
    [qrView addSubview:lineview];
    
    [qrView addSubview:qrImageView];
    [qrImageView makeConstraints:^(MASConstraintMaker *make) {
//        make.center.offset(0);
        make.centerY.offset(10);
        make.centerX.offset(0);
        
    }];
    UILabel *bottomLaber = [[UILabel alloc]init];
    bottomLaber.backgroundColor = UIColorFromRGB(0XEBEBEB);
    [qrView addSubview:bottomLaber];
    bottomLaber.frame = CGRectMake(0, 360, self.view.frame.size.width-60, 40);
    //设置某个圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bottomLaber.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bottomLaber.bounds;
    maskLayer.path = maskPath.CGPath;
    bottomLaber.layer.mask = maskLayer;
    bottomLaber.text = @"微信支付收款,";
    bottomLaber.textAlignment = NSTextAlignmentCenter;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)cancelAction{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
