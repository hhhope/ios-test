//
//  CreatQRcodeviewController.m
//  Uepp-0307
//
//  Created by 严 on 2017/3/13.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "CreatQRcodeviewController.h"
#import "QRCodeGenerator.h"
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
    
    UIImageView * imView = [[UIImageView alloc]init];
    imView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imView];
    [imView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(-40);
        make.height.equalTo(300);
        make.left.equalTo(50);
        make.right.equalTo(-50);
    }];
//    UILabel *lab =[[UILabel alloc]init];
//    lab.text = @"111111";
//    UIImageView *photo = [[UIImageView alloc]init];
//    photo.frame= CGRectMake(0,0 , 200, 200);
//    [imView addSubview:photo];
    imView.image = [QRCodeGenerator qrImageForString:@"1111" imageSize:300];
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
