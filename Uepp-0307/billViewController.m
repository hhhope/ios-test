//
//  billViewController.m
//  Uepp-0307
//
//  Created by 严素 on 2017/3/8.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "billViewController.h"
#import "selctViewController.h"
//取色
#define UIColorFromRGB1(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
@interface billViewController ()

@end

@implementation billViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];

    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text =@"账单";
    titleLabel.textColor =[UIColor whiteColor];
    self.navigationItem.titleView =titleLabel;

    //设置背景色
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x1C86EE);
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"报表" style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    rightBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    searchBtn.frame = CGRectMake(0, 0, 50, 40);
//    searchBtn.backgroundColor = [UIColor blackColor];
    searchBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:18];
    [searchBtn setTitle:@"\U0000E601" forState:UIControlStateNormal];
    searchBtn.tintColor= [UIColor whiteColor];
    [searchBtn addTarget:self action:@selector(select) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *informationCardItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
   self.navigationItem.leftBarButtonItem = informationCardItem;
    
    
}

- (void)search{
    
}


- (void)select{
    selctViewController *selectVc = [[selctViewController alloc]init];
   
    [self.navigationController pushViewController:selectVc animated:YES];
    
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
