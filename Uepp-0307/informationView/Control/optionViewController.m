//
//  optionViewController.m
//  Uepp-0307
//
//  Created by 严 on 2017/3/16.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "optionViewController.h"
#import "changePassWordViewController.h"
#import "loginViewController.h"

@interface optionViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation optionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text =@"设置";
    
    titleLabel.textColor =[UIColor whiteColor];
    self.navigationItem.titleView =titleLabel;
    //设置导航栏下移
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UITableView *tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [exitButton setTitle:@"安全退出" forState:UIControlStateNormal];
    [exitButton setTintColor:[UIColor blackColor]];
    exitButton.backgroundColor = [UIColor whiteColor];
    exitButton.titleLabel.font = [UIFont systemFontOfSize:17];
    exitButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:exitButton];
    [exitButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.centerY.equalTo(-115);
        make.width.equalTo(300);
        make.height.equalTo(40);
    }];
    [exitButton addTarget:self action:@selector(exitToLogin) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if(indexPath.section == 0){
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = @"密码安全";
        [cell addSubview:titleLabel];
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        UILabel *jumpLabel = [[UILabel alloc]init];
        jumpLabel.font = [UIFont fontWithName:@"iconfont" size:15];
        jumpLabel.text =@"\U0000E634";
        jumpLabel.textColor= [UIColor grayColor];
        [jumpLabel  sizeToFit];
        [cell addSubview:jumpLabel];
        [jumpLabel makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-20);
            make.centerY.equalTo(0);
        }];

    }
    if(indexPath.section == 1){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = @"语音播报";
        [cell addSubview:titleLabel];
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        UISwitch *switchButton = [[UISwitch alloc]init];
        switchButton.onTintColor =UIColorFromRGB(0x1C86EE);
        [cell addSubview:switchButton];
        [switchButton makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-20);
            make.centerY.equalTo(0);
        }];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        changePassWordViewController *changePwdVc = [[changePassWordViewController alloc]init];
    [self.navigationController pushViewController:changePwdVc animated:YES];
    }
}

-(void)exitToLogin{

    loginViewController *loginVc = [[loginViewController alloc]init];
    [self presentViewController:loginVc animated:YES completion:^{
        self.tabBarController.selectedIndex = 0;
    }];
    [self.navigationController popToRootViewControllerAnimated:YES];
    //利用通知告诉对应控制器需要做什么
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clear" object:nil];
//    UITabBarController *tableBar = [[UITabBarController alloc]init];
//    [UIApplication sharedApplication].keyWindow.rootViewController =tableBar;
}
@end
