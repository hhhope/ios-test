//
//  QRcodeViewController.m
//  Uepp-0307
//
//  Created by 严素 on 2017/3/8.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "QRcodeViewController.h"
//取色
#define UIColorFromRGB1(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
@interface QRcodeViewController ()

//显示屏
@property UIImageView *amount;
@property UILabel  *amountTitle;
@property UILabel  *amountlabel;
@property UIButton *qrButton;
@property UIButton *massage;
//扫描和收款
@property UIButton *qrCodeButton;
@property UIButton *qrReceivables;
@end

@implementation QRcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.qrCodeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.qrReceivables = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview: self.qrCodeButton];
    [self.view addSubview: self.qrReceivables];
    
 
    [self.qrCodeButton setTitle:@"扫一扫" forState:UIControlStateNormal];
    self.qrCodeButton.tintColor = [UIColor whiteColor];
    self.qrCodeButton.backgroundColor =UIColorFromRGB(0x1C86EE);
    self.qrCodeButton.layer.cornerRadius = 5;

    [self.qrCodeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(20);
        make.bottom.equalTo(self.view.bottom).offset(-73);
        make.height.equalTo(50);
        make.right.equalTo(self.qrReceivables.left).offset(-20);
    }];
    
    [self.qrReceivables setTitle:@"二维码收款" forState:UIControlStateNormal];
    self.qrReceivables.tintColor = [UIColor whiteColor];
    self.qrReceivables.backgroundColor =UIColorFromRGB(0x1C86EE);
     self.qrReceivables.layer.cornerRadius = 5;

    [self.qrReceivables makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.right).offset(-20);
        make.bottom.equalTo(self.qrCodeButton);
        make.height.equalTo(self.qrCodeButton);
//        make.equalTo(self.qrCodeButton.right).offset(20);
        make.width.equalTo(self.qrCodeButton);

    }];
}
- (void)screenCalculatorView{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
