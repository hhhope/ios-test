//
//  changePassWordViewController.m
//  Uepp-0307
//
//  Created by 严 on 2017/3/17.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "changePassWordViewController.h"

@interface changePassWordViewController ()

@end

@implementation changePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text =@"修改密码";
    titleLabel.textColor =[UIColor whiteColor];
    self.navigationItem.titleView =titleLabel;
    // Do any additional setup after loading the view.
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
