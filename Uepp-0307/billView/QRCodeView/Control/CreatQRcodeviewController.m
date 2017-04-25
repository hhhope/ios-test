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
    
    NSUserDefaults *mer = [NSUserDefaults standardUserDefaults];
    NSString *mer_id = [ mer objectForKey:@"mer_id"];
    DLOGP(@"%@",mer_id);
    
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
    qrImageView = [qrCode creatQrcodeimage:self.qrCode];

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
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = UIColorFromRGB(0XEBEBEB);
    [qrView addSubview:bottomView];
    bottomView.frame = CGRectMake(0, 360, self.view.frame.size.width-60, 40);
    //设置某个圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bottomView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bottomView.bounds;
    maskLayer.path = maskPath.CGPath;
    bottomView.layer.mask = maskLayer;
    bottomView.userInteractionEnabled = YES;
//    bottomLaber.userInteractionEnabled = YES;
//    UIView *reminderView = [[UIView alloc]init];
//    UIColor *color = [UIColor whiteColor];
//
//    reminderView.backgroundColor = color;
//    [bottomLaber addSubview:reminderView];
//    [reminderView makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(0);
//        make.height.equalTo(35);
//        make.width.equalTo(200);
//    }];
    UILabel *reminderLable = [[UILabel alloc]init];
    if (self.payFlag == 1) {
    reminderLable.text = @"支付宝收款，";
    }
    else{
    reminderLable.text = @"微信支付收款，";
    }
    reminderLable.textColor = [UIColor blackColor];
    reminderLable.font = [UIFont systemFontOfSize:16];
    [reminderLable sizeToFit];
    [bottomView addSubview:reminderLable];
    [reminderLable makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(-10);
        make.centerY.equalTo(0);
        make.height.equalTo(20);
    }];
    UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [changeButton setTitle:@"更换" forState:UIControlStateNormal];
    changeButton.frame = CGRectMake((bottomView.bounds.size.width/2) +30, 10, 50, 20);
    [changeButton addTarget:self action:@selector(changeQRcode) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview: changeButton];
    
    UIButton *QRcodeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [QRcodeButton setTitle:@"切换扫一扫" forState:UIControlStateNormal];
    QRcodeButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [QRcodeButton setTintColor:[UIColor whiteColor]];
    [self.view addSubview:QRcodeButton];
    [QRcodeButton makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-130);
        make.centerX.equalTo(0);
        make.width.equalTo(150);
    }];
    [QRcodeButton addTarget:self action:@selector(creatQrView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)cancelAction{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)changeQRcode{
    
    NSLog(@"changeQRcode");
}
- (void)creatQrView{
    NSLog(@"creatQrView");

    if ([self.delegate respondsToSelector:@selector(removeQRcodeview)]) {
      
        [self.delegate removeQRcodeview];
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 通讯
-(void)loginAction{
    NSString *webServiceUrl = @"http://www.dldhcwx.com/icmp-ums/dhc/sys/mobile.do";
    //    //参数值
    //    NSString *theCityCode = @"nanjing";
    //请求体拼接
   
    // 启动系统风火轮
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\" ?>"
                             "<Response>"
                             "<Head>"
                             "<trace_no>6</trace_no>"
                             "<terminalno>8</terminalno>"
                             "<tanstype>80014</tanstype>"
                             "<acceptidcode>%@</acceptidcode>"
                             "<operateno><operateno>"
                             "</Head>"
                             "<Body>"
                             "</Body>"
                             "</Response>"
                             ,self.amt];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml", @"application/xml", nil];
    //    [SVProgressHUD show];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml", nil];
    //请求体设置
    
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
        return [soapMessage copy];
    }];
    //设置返回XMLParser数据解析类型
    [SVProgressHUD showWithStatus:nil];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [manager POST:webServiceUrl parameters:@"aaa" progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success");
        // 隐藏系统风火轮
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        XMLDictionaryParser *parser=[[XMLDictionaryParser alloc]init];
        NSDictionary *dic=[parser dictionaryWithData:responseObject];
        NSLog(@"%@",dic);
        NSDictionary *dic2 = [dic objectForKey:@"Body"];
        NSLog(@"%@",dic2);
        NSString *respcd = [dic2 objectForKey:@"respcd"];
        NSLog(@"%@",respcd);
        NSString *RET_MSG = [dic2 objectForKey:@"RET_MSG"];
        NSLog(@"%@",RET_MSG);
        if([respcd  isEqual: @"00"]){
           NSLog(@"%@",RET_MSG);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // time-consuming task
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            });
        }


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}
@end
