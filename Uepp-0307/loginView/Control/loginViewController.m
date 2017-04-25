//
//  loginViewController.m
//  Uepp-0307
//
//  Created by 严 on 2017/3/20.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()
@property NSString *userName;
@property NSString *passWord;
@property UITextField *userNameText;
@property UITextField *passWordText;
@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //回到主界面调整好网络接口后删除
    NSDictionary *dic = [[NSDictionary alloc]init];
    self.userNameText = [[UITextField alloc]init];
    _userNameText.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_userNameText];
    _userNameText.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"用户名" attributes:dic];
    [_userNameText makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.centerY.equalTo(-150);
        make.height.equalTo(30);
        make.width.equalTo(150);
    }];
    _passWordText = [[UITextField alloc]init];
    _passWordText.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_passWordText];
    [_passWordText makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.centerY.equalTo(-100);
        make.height.equalTo(30);
        make.width.equalTo(150);
    }];

    UIButton *loginButton = [UIButton buttonWithType: UIButtonTypeSystem];
    loginButton.layer.cornerRadius = 5;
    loginButton.backgroundColor = UIColorFromRGB(0x1C86EE);
    [self.view addSubview:loginButton];
    [loginButton setTitle: @"登录" forState:UIControlStateNormal];
    [loginButton setTintColor:[UIColor whiteColor]];
    [loginButton makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        make.centerY.equalTo(-60);
        make.width.equalTo(150);
        make.height.equalTo(30);
    }];
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    backbutton.backgroundColor = UIColorFromRGB(0x1C86EE);
    [self.view addSubview:backbutton];
    [backbutton setTitle: @"返回主界面" forState:UIControlStateNormal];
    [backbutton setTintColor:[UIColor whiteColor]];
    backbutton.layer.cornerRadius = 5;
    [backbutton makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        make.centerY.equalTo(60);
        make.width.equalTo(150);
        make.height.equalTo(50);
    }];
    [backbutton addTarget:self action:@selector(backUprootView) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
    [self NotificationCenter];
}

-(void)backUprootView{
    
      [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)loginAction{
    NSString *webServiceUrl = @"http://www.dldhcwx.com/icmp-ums/dhc/sys/mobile.do";
//    //参数值
//    NSString *theCityCode = @"nanjing";
    //请求体拼接
    DLOGP(@"%@",self.passWord);
    // 启动系统风火轮
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\" ?>"
                             "<Response>"
                             "<Head>"
                             "<trace_no>6</trace_no>"
                             "<terminalno>8</terminalno>"
                             "<tanstype>10001</tanstype>"
                             "</Head>"
                             "<Body>"
                             "<uname>%@</uname>"
                             "<ucode>%@</ucode>"
                             "</Body>"
                             "</Response>"
                             ,self.userName,[self MD5:self.passWord]];
    

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
     NSString *merid = [dic2 objectForKey:@"merid"];
     NSLog(@"%@",merid);
     if(merid != nil ){
         NSUserDefaults *mer = [NSUserDefaults standardUserDefaults];
         [mer setObject:merid forKey:@"mer_id"];
     }
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         // time-consuming task
         dispatch_async(dispatch_get_main_queue(), ^{
             [SVProgressHUD dismiss];
         });
     });
     if(merid != nil){
     [self backUprootView];
     }
 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     NSLog(@"error");
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         // time-consuming task
         dispatch_async(dispatch_get_main_queue(), ^{
             [SVProgressHUD dismiss];
         });
     });
 }];
}
-(void)NotificationCenter{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    
}
// 实现按钮状态转变
-(void)textDidChangeNotification:(NSNotification*)notifi{

    if(![_userNameText.text isEqualToString:@""]){
        _userName = _userNameText.text;
        NSLog(@"%@",_userName);
    }
    if (![_passWordText.text isEqualToString:@""]) {
        _passWord = _passWordText.text;
        NSLog(@"%@",_passWord);
    }

}
//MD5加密
- (id)MD5:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    unsigned int x=(int)strlen(cStr) ;
    CC_MD5( cStr, x, digest );
    // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
@end
