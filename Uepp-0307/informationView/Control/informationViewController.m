//
//  informationViewController.m
//  Uepp-0307
//
//  Created by 严素 on 2017/3/8.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "informationViewController.h"
#import "QrCreatViewController.h"
#import "optionViewController.h"
#import "questionViewController.h"
#import "UserInformationViewController.h"

@interface informationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (copy,nonatomic)NSString *userName;
@property UIImageView *imageView;
@property UILabel *userNameLabel;
@property UITableViewCell *cell;
@end

@implementation informationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text =@"我的";
    titleLabel.textColor =[UIColor whiteColor];
    self.navigationItem.titleView =titleLabel;
    //设置背景色
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x1C86EE);
    
    
    //设置tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate= self;
    tableView.dataSource= self;

    [self.view addSubview: tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(0 == section||1 == section||2 == section){
        return 1;
    }
        return 2;
    
}
-   (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.section == 0)
    {
        //设置无法点击
        self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.imageView = [[UIImageView alloc]init];
        self.imageView.image = [UIImage imageNamed:@"icon_my_business_general_54x54_"];
        [self.cell addSubview:self.imageView];
        [self.imageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.top.offset(10);
            make.bottom.offset(-10);
        }];
        self.userNameLabel = [[UILabel alloc]init];
        NSString *str1 = [NSString stringWithFormat:@"收银员:%@",self.userName ];
        self.userNameLabel.text =str1;
        [self.userNameLabel sizeToFit];
        [self.cell addSubview:self.userNameLabel];
        [self.userNameLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView.right).offset(15);
            make.top.equalTo(self.imageView);
        }];
        UILabel *phoneNumber = [[UILabel alloc]init];
        phoneNumber.text = @"18624393361";
        [phoneNumber sizeToFit];
        phoneNumber.font = [UIFont systemFontOfSize:15];
        phoneNumber.textColor = [UIColor grayColor];
        [self.cell addSubview:phoneNumber];
        [phoneNumber makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userNameLabel.bottom).offset(10);
            make.left.equalTo(self.userNameLabel);
            
        }];
    }
    if(indexPath.section == 1){
        self.cell = [self cellinitStyle:@"icon_my_receivablesQRcode_general_02_21x21_" title:@"收款二维码"];
    }
    if(indexPath.section == 2){
        self.cell = [self cellinitStyle:@"icon_my_set_general_04_21x21_" title:@"设置"];
    }
    if(indexPath.section == 3){
        if(indexPath.row == 0){
            self.cell = [self cellinitStyle:@"icon_my_help_05_21x21_" title:@"常见问题"];
            return self.cell;
        }
        self.cell = [self cellinitStyle:@"icon_my_home_06_21x21_" title:@"关于我们"];
    }
    return self.cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     return 0.1;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 70;
    }
    return 50;
}
//自定义cell样式
- (UITableViewCell *)cellinitStyle:(NSString *)imageName title:(NSString *)title{
    UIImageView *imageView = [[UIImageView alloc ]init];
    imageView.image = [UIImage imageNamed:imageName];
    imageView.frame = CGRectMake(10, 10, 30, 30);
    self.cell.center = imageView.center;
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
   
   
    label.font = [UIFont systemFontOfSize:16];
    [label sizeToFit];
    [self.cell addSubview:imageView];
    [self.cell addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.centerY.equalTo(self.cell);
    }];
    UILabel *jumpLabel = [[UILabel alloc]init];
    jumpLabel.font = [UIFont fontWithName:@"iconfont" size:15];
    jumpLabel.text =@"\U0000E634";
    jumpLabel.textColor= [UIColor grayColor];
    [jumpLabel  sizeToFit];
    [self.cell addSubview:jumpLabel];
    [jumpLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.centerY.equalTo(self.cell);
    }];
    return self.cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置回弹动画
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 1 ){
        QrCreatViewController *qrVc = [[QrCreatViewController alloc]init];
        [self.navigationController pushViewController:qrVc animated:YES];
    }
    if(indexPath.section == 2 ){
        optionViewController *opVc = [[optionViewController alloc]init];
        [self.navigationController pushViewController:opVc animated:YES];
    }
    if(indexPath.section == 3 &&indexPath.row == 0){
        questionViewController *qVc = [[questionViewController alloc]init];
        [self.navigationController pushViewController:qVc animated:YES];
    }else if(indexPath.section == 3 &&indexPath.row == 1) {
        UserInformationViewController *userVc = [[UserInformationViewController alloc]init];
        [self.navigationController pushViewController:userVc animated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

@end
