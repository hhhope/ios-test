//
//  billViewController.m
//  Uepp-0307
//
//  Created by 严素 on 2017/3/8.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "billViewController.h"
#import "selctViewController.h"
#import "MovieInformation.h"

@interface billViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)NSMutableArray *moveArray;
@property UITableView *tableView;
@end

@implementation billViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview: self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
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
    
    _moveArray =[NSMutableArray array];
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
-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _moveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    MovieInformation *movieDate = _moveArray[indexPath.row];
    NSLog(@"%@",movieDate.title);
    cell.textLabel.text = movieDate.title;
    return cell;
}
-(void)refresh{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"https://api.douban.com/v2/movie/top250" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arrayDic = [responseObject objectForKey:@"subjects"];
        [_moveArray removeAllObjects];
        for (NSDictionary *dic in arrayDic) {
            
            NSLog(@"%@",dic);
            MovieInformation *move = [MovieInformation moveWithDict:dic];
            [_moveArray addObject:move];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        NSLog(@"%ld",_moveArray.count);
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
        [self.tableView.mj_header endRefreshing];
    }];
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
