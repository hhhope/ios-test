//
//  selctViewController.m
//  Uepp-0307
//
//  Created by 严素 on 2017/3/8.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "selctViewController.h"
//取色
#define UIColorFromRGB1(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface selctViewController ()

@end

@implementation selctViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backup)];
    rightBtn.tintColor = UIColorFromRGB(0x1C86EE);
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.view.backgroundColor = UIColorFromRGB(0xF2F2F2);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)backup{
    self.tabBarController.tabBar.hidden = NO;
           self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x1C86EE);
    [self.navigationController popViewControllerAnimated:YES];
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
