//
//  selctViewController.m
//  Uepp-0307
//
//  Created by 严素 on 2017/3/8.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "selctViewController.h"
#import "MovieInformation.h"
@interface selctViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property UISearchBar *searchBar;
@property MovieInformation *moveDate;
@end

@implementation selctViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   self.tabBarController.tabBar.hidden = YES;
    //设置导航栏只有箭头返回按钮
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = UIColorFromRGB(0xF2F2F2);
    [self.navigationController.navigationBar addSubview:[self searchBarView]];
    
}
-(UIView *)searchBarView{
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(40, 0, 300, 44)];
    self.searchBar.keyboardType = UIKeyboardAppearanceDefault;
    self.searchBar.placeholder = @"请输入搜索关键字";
    self.searchBar.delegate = self;
    //底部的颜色
    self.searchBar.barTintColor = [UIColor grayColor];
    self.searchBar.searchBarStyle = UISearchBarStyleDefault;
    self.searchBar.barStyle = UIBarStyleDefault;
    return self.searchBar;
}


- (void)viewWillDisappear:(BOOL)animated{
    [self.searchBar removeFromSuperview];
}


@end
