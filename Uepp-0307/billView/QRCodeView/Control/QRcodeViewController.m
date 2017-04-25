//
//  QRcodeViewController.m
//  Uepp-0307
//
//  Created by 严素 on 2017/3/8.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "QRcodeViewController.h"
#import "LBXScanResult.h"
#import "LBXScanWrapper.h"
#import "LBXScanViewStyle.h"
#import "ScanImageViewController.h"
#import "CreatQRcodeviewController.h"
#import "loginViewController.h"
static  NSString* const weChatcode = @"80014";
static  NSString* const aliPay     = @"80008";
@interface QRcodeViewController ()<ScanImageView,CreatQRcodeviewDelegate>

//显示屏
@property UIImageView *amount;
@property UILabel  *amountTitle;
@property UILabel  *amountlabel;
@property UIButton *qrButton;
@property UIButton *massage;

@property NSString *balance;
@property NSString *ouput_amt;//金额
@property NSString *input_amt;
@property NSString *merid;
//扫描和收款

@property UIButton *qrCodeButton;
@property UIButton *qrReceivables;

//计算器
@property UIImageView *calculatorView;

//蒙板
@property UIButton *maskButton;

@property UINavigationController *nv;
@end

@implementation QRcodeViewController
//通知的固定格式
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [self loginView];
    [super viewDidLoad];
    //通知的固定格式
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clear) name:@"clear" object:nil];
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.qrCodeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.qrReceivables = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview: self.qrCodeButton];
    [self.view addSubview: self.qrReceivables];
      self.navigationController.navigationBarHidden = YES;
    //底部按钮设置
    [self.qrCodeButton setTitle:@"扫一扫" forState:UIControlStateNormal];
    self.qrCodeButton.tintColor = [UIColor whiteColor];
    self.qrCodeButton.backgroundColor =UIColorFromRGB(0x1C86EE);
    self.qrCodeButton.layer.cornerRadius = 5;
    self.qrCodeButton.titleLabel.font = [UIFont systemFontOfSize:18];

    [self.qrCodeButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(20);
        make.bottom.equalTo(self.view.bottom).offset(-80);
        make.height.equalTo(40);
        make.right.equalTo(self.qrReceivables.left).offset(-20);
    }];
    
    [self.qrReceivables setTitle:@"二维码收款" forState:UIControlStateNormal];
    self.qrReceivables.tintColor = [UIColor whiteColor];
    self.qrReceivables.backgroundColor =UIColorFromRGB(0x1C86EE);
    self.qrReceivables.layer.cornerRadius = 5;
    self.qrReceivables.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.qrReceivables makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.right).offset(-20);
        make.bottom.equalTo(self.qrCodeButton);
        make.height.equalTo(self.qrCodeButton);
        make.width.equalTo(self.qrCodeButton);
    }];
    self.balance =nil;
    self.ouput_amt = nil;
    self.input_amt = nil;
    [self amountConfigView];
    [self calculatorConfigView];
    [self.qrCodeButton addTarget:self action:@selector(qr_Pay) forControlEvents:UIControlEventTouchUpInside];
    [self.qrReceivables addTarget:self action:@selector(qrCollection) forControlEvents:UIControlEventTouchUpInside];

}
//清空
- (void)clear{
    self.amountlabel.text =@"0.00";
    self.balance=nil;
    self.ouput_amt=nil;//金额
    self.input_amt=nil;
}

- (void)screenCalculatorView{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//显示屏
- (void)amountConfigView{
    self.amount =[[UIImageView alloc]init];
    self.amount.userInteractionEnabled = YES;
    [self.view addSubview:self.amount];
    self.amount.backgroundColor =UIColorFromRGB(0x1C86EE);
    CGFloat height =(self.view.frame.size.height/3);
    [self.amount makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(height-44);
    }];
    self.amountTitle = [[UILabel alloc]init];
    [self.view addSubview:self.amountTitle];
    self.amountTitle.text = @"收款金额";
    self.amountTitle.font = [UIFont systemFontOfSize:17];
    self.amountTitle.textColor = [UIColor whiteColor];
    [self.amountTitle sizeToFit];
    [self.amountTitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.amount).offset(50);
        make.left.equalTo(self.amount).offset(20);
    }];
    self.input_amt = @"0.00";
    self.amountlabel = [[UILabel alloc]init];
    [self.view addSubview:self.amountlabel];
    self.amountlabel.text = self.input_amt;
    self.amountlabel.font = [UIFont systemFontOfSize:45];
    self.amountlabel.textColor = [UIColor whiteColor];
    [self.amountlabel sizeToFit];
    [self.amountlabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.amountTitle.bottom).offset(10);
        make.right.equalTo(self.amount).offset(-20);
    }];
    self.qrButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.qrButton addTarget:self action:@selector(qr_Pay) forControlEvents:UIControlEventTouchUpInside];
    [self.amount addSubview:self.qrButton];
    self.qrButton.titleLabel.font = [UIFont fontWithName:@"iconfont" size:25];
    [self.qrButton setTitle:@"\U0000E642" forState:UIControlStateNormal];
    self.qrButton.tintColor = [UIColor whiteColor];
    [self.qrButton sizeToFit];
    [self.qrButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.amount).offset(25);
        make.right.equalTo(self.amount).offset(-15);
    }];
    self.massage = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.amount addSubview:self.massage];
    self.massage.titleLabel.font = [UIFont fontWithName:@"iconfont" size:25];
    [self.massage setTitle:@"\U0000E632" forState:UIControlStateNormal];
    self.massage.tintColor = [UIColor whiteColor];
    [self.massage sizeToFit];
    [self.massage makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qrButton);
        make.right.equalTo(self.qrButton.left).offset(-20);
    }];
}
//计算器
-(void)calculatorConfigView{
    self.calculatorView = [[UIImageView alloc]init];
    self.calculatorView.userInteractionEnabled = YES;
    [self.view addSubview:self.calculatorView];
    self.calculatorView.backgroundColor = [UIColor clearColor];
    [self.calculatorView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.amount.bottom);
        make.bottom.equalTo(self.qrCodeButton.top);
        make.width.equalTo(self.view);
    }];
    [self calculator];
    
}



-(void)calculator{
    //申明区域，displayView是显示区域，keyboardView是键盘区域
    UIView *keyboardView = [UIView new];
    keyboardView.userInteractionEnabled = YES;
    [self.calculatorView addSubview:keyboardView];
    keyboardView.backgroundColor = [UIColor clearColor];
    [keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.calculatorView);
        make.bottom.equalTo(self.calculatorView.mas_bottom);
        make.left.and.right.equalTo(self.calculatorView);
    }];
    
    //定义键盘键名称，？号代表合并的单元格
    NSArray *keys = @[@"1",@"2",@"3",@"DEL"
                      ,@"4",@"5",@"6",@"C"
                      ,@"7",@"8",@"9",@"+"
                      ,@"00",@"0",@".",@"="
                      ];
    int indexOfKeys = 0;
    for (NSString *key in keys){
        //循环所有键
        indexOfKeys++;
        int rowNum = indexOfKeys %4 ==0? indexOfKeys/4:indexOfKeys/4 +1;
        int colNum = indexOfKeys %4 ==0? 4 :indexOfKeys %4;
        NSLog(@"index is:%d and row:%d,col:%d",indexOfKeys,rowNum,colNum);
        //键样式
        UIButton *keyView = [UIButton buttonWithType:UIButtonTypeSystem];
        [keyboardView addSubview:keyView];
        [keyView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [keyView setTitle:key forState:UIControlStateNormal];
        
        [keyView addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

       [keyView.titleLabel setFont:[UIFont systemFontOfSize:30]];
        //键约束
        [keyView mas_makeConstraints:^(MASConstraintMaker *make) {

                make.width.equalTo(keyboardView.mas_width).with.multipliedBy(.25f);
                make.height.equalTo(keyboardView.mas_height).with.multipliedBy(0.25);
                //按照行和列添加约束，这里添加行约束
                switch (rowNum) {
                    case 1:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.15f);
//                        keyView.backgroundColor = [UIColor colorWithRed:205 green:205 blue:205 alpha:1];
                    }
                        break;
                    case 2:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.4f);
                    }
                        break;
                    case 3:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.65f);
                    }
                        break;
                    case 4:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);
                    }
                        break;
//                    case 5:
//                    {
//                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);
//                    }
//                        break;
                    default:
                        break;
                }
                //按照行和列添加约束，这里添加列约束
                switch (colNum) {
                    case 1:
                    {
                        make.left.equalTo(keyboardView.mas_left);
                    }
                        break;
                    case 2:
                    {
                        make.right.equalTo(keyboardView.mas_centerX);
                    }
                        break;
                    case 3:
                    {
                        make.left.equalTo(keyboardView.mas_centerX);
                    }
                        break;
                    case 4:
                    {
                        make.right.equalTo(keyboardView.mas_right);

                    }
                        break;
                    default:
                        break;
                }
            
        }];
    }
}


- (void)click :(UIButton *)button{

    NSLog(@"%@",button.titleLabel.text);
    double num1;
    double num2;
    NSString *str1;
    

    if([button.titleLabel.text  isEqual: @"DEL"]){
        str1= self.balance;
        if (str1.length>=1) {
            str1 = [str1 substringToIndex:(str1.length-1)];
        }if(str1.length==0){
            str1  = @"0.00";
        }
        
        self.balance =str1;
        self.amountlabel.text=self.balance;
        self.balance = nil;
        return ;
    }
    
    if([button.titleLabel.text  isEqual: @"C"]){
        self.amountlabel.text =@"0.00";
        self.balance = nil;
        return ;
    }
    if(self.balance.length == 10&&[button.titleLabel.text  isEqual: @"+"])
    {
        self.input_amt =self.balance;
        self.balance = nil;
        return ;
    }else   if([button.titleLabel.text  isEqual: @"+"]){
        
              self.input_amt =self.balance;
               self.balance = nil;
                return ;
        
        }
    if(self.balance.length == 10)
    {
    return ;
    }
    if([button.titleLabel.text  isEqual: @"="]){
        
        if(self.input_amt != nil&&self.ouput_amt==nil){
            num1 = [self.balance doubleValue];
            num2 = [self.input_amt doubleValue];
            num1=num2+num1;
            self.ouput_amt =[NSString stringWithFormat:@"%.2f",num1];
            NSLog(@"%@",self.ouput_amt);
            self.amountlabel.text = self.ouput_amt;
            self.input_amt = nil;
            self.balance = nil;
            
        }
        return ;
    }
    
    str1 =button.titleLabel.text;
    if(self.balance == nil){
        self.balance =str1;
    }else{
         str1= [self.balance stringByAppendingString:str1];
    }
   
    NSLog(@"%@",str1);
    self.balance =str1;
    self.ouput_amt = nil;
    self.amountlabel.text =self.balance;

}
- (void)qr_Pay{
    ScanImageViewController *scanImage =[[ScanImageViewController alloc]init];
    scanImage.delegate = self;
    if([self.amountlabel.text  isEqual: @"0.00"])
    {
        //STEP 1
        NSString *title = @"提示";
        NSString *message = @"请输入收款金额";
        NSString *okButtonTitle = @"OK";
        
        //step 2 action
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *okCtrl = [UIAlertAction actionWithTitle:okButtonTitle
                                                         style:UIAlertActionStyleCancel
                                                       handler:nil];
        [ self presentViewController:alertController animated:YES completion:nil ] ;
        //step 3 action
        [alertController addAction:okCtrl];
        return;
    }else if(self.amountlabel.text != nil){
        scanImage.amt = self.amountlabel.text;
    }
    self.nv = [[UINavigationController alloc]initWithRootViewController:scanImage];
    //模态跳转
    
    [self presentViewController:self.nv animated:YES completion:nil];
    NSLog(@"scanImageButton");
 
}
-(void)qrCollection{
   
    if([self.amountlabel.text  isEqual: @"0.00"])
    {
        //STEP 1
        NSString *title = @"提示";
        NSString *message = @"请输入收款金额";
        NSString *okButtonTitle = @"OK";
        
        //step 2 action
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *okCtrl = [UIAlertAction actionWithTitle:okButtonTitle
                                                         style:UIAlertActionStyleCancel
                                                       handler:nil];
        [ self presentViewController:alertController animated:YES completion:nil ] ;
        //step 3 action
        [alertController addAction:okCtrl];
        return;
    }
    self.maskButton = [[UIButton alloc]initWithFrame:self.view.bounds];

    self.maskButton.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
    //蒙板注意事项
    [self.tabBarController.view addSubview: self.maskButton];
    [self.maskButton addTarget:self action:@selector(dismaskView :) forControlEvents:UIControlEventTouchUpInside];
    UIButton *alertButton  = [[UIButton alloc]init];
    alertButton.layer.cornerRadius = 8;
    alertButton.backgroundColor = [UIColor whiteColor];
    [self.maskButton addSubview:alertButton];
    [alertButton makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        make.width.equalTo(250);
        make.height.equalTo(140);
    }];
    UILabel *alertTitle = [[UILabel alloc]init];
    alertTitle.text = @"选择支付方式";
    [alertButton addSubview: alertTitle];
    [alertTitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.centerX.equalTo(0);
    }];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.titleLabel.font =[UIFont fontWithName:@"iconfont" size:15];
    [cancelButton setTitle:@"\U0000E66E" forState:UIControlStateNormal];
    [cancelButton setTintColor:[UIColor blackColor]];
    [alertButton addSubview:cancelButton];
    [cancelButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(8);
        make.width.equalTo(20);
        make.height.equalTo(20);
        
    }];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    UIView *lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(0, 35, 250, 0.5);
    lineView.backgroundColor = [UIColor lightGrayColor];
    [alertButton addSubview:lineView];
    UIButton *payButton = [[UIButton alloc]init];
    payButton.frame = CGRectMake(0, 35, 250, 50);
    [alertButton addSubview:payButton];
 
    UIImageView  *payIcon = [[UIImageView alloc]init];
    payIcon.image = [UIImage imageNamed:@"icon_general_Pay_30x30_"];
    [payButton addSubview:payIcon];
    [payIcon makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(0);
    }];
    UILabel *payLabel = [[UILabel alloc]init];
    payLabel.text = @"支付宝方式";
    [payButton addSubview:payLabel];
    [payLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(65);
    }];
    UILabel *jumpLabel = [[UILabel alloc]init];
    jumpLabel.font = [UIFont fontWithName:@"iconfont" size:15];
    jumpLabel.text =@"\U0000E634";
    jumpLabel.textColor= [UIColor grayColor];
    [jumpLabel  sizeToFit];
    [payButton addSubview:jumpLabel];
    [jumpLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.centerY.equalTo(0);
    }];
    UIView *paylineView = [[UIView alloc]init];
    paylineView.frame = CGRectMake(10, 85, 240, 0.5);
    paylineView.backgroundColor = [UIColor lightGrayColor];
    [alertButton addSubview:paylineView];
    
    UIButton *wechatPayButton = [[UIButton alloc]init];
    wechatPayButton.frame = CGRectMake(0, 90, 250, 50);
    [alertButton addSubview:wechatPayButton];
    UIImageView  *wechatPayImage = [[UIImageView alloc]init];
    wechatPayImage.image = [UIImage imageNamed:@"icon_general_wechat_30x30_"];
    [wechatPayButton addSubview:wechatPayImage];
    [wechatPayImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(0);
    }];
    UILabel *wechatPayLabel = [[UILabel alloc]init];
    wechatPayLabel.text = @"微信方式";
    [wechatPayButton addSubview:wechatPayLabel];
    [wechatPayLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(65);
    }];
    UILabel *wechatjumpLabel = [[UILabel alloc]init];
    wechatjumpLabel.font = [UIFont fontWithName:@"iconfont" size:15];
    wechatjumpLabel.text =@"\U0000E634";
    wechatjumpLabel.textColor= [UIColor grayColor];
    [wechatjumpLabel  sizeToFit];
    [wechatPayButton addSubview:wechatjumpLabel];
    [wechatjumpLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.centerY.equalTo(0);
    }];
    [payButton addTarget:self action:@selector(aliPay) forControlEvents:UIControlEventTouchUpInside];
    
    
      [wechatPayButton addTarget:self action:@selector(wechatPay) forControlEvents:UIControlEventTouchUpInside];
   
}
-(void)dismaskView:(UIButton *) button {
    [button removeFromSuperview];
}
- (void)aliPay{

     NSLog(@"aliPay");
    [self callQRcreat:aliPay];

}
-(void)wechatPay{
     NSLog(@"wechatPay");

    [self callQRcreat:weChatcode];
}

-(void)loginView{
    loginViewController *loginVc = [[loginViewController alloc]init];
    [self presentViewController:loginVc animated:YES completion:nil];
}
-(void)cancel{
    [self.maskButton removeFromSuperview];
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)removeScanImageView{
    [self.nv dismissViewControllerAnimated:NO completion:^{
        
        CreatQRcodeviewController *creatQRvc = [[CreatQRcodeviewController alloc]init];
        creatQRvc.delegate = self;
        creatQRvc.amt = self.amountlabel.text;
        self.nv = [[UINavigationController alloc]initWithRootViewController:creatQRvc];
        [self presentViewController:self.nv animated:YES completion:nil];
    }];
 
}
- (void)removeQRcodeview{
    
    [self.nv dismissViewControllerAnimated:NO completion:^{
       
        ScanImageViewController *ScanImagevc = [[ScanImageViewController alloc]init];
        ScanImagevc.delegate = self;
        ScanImagevc.amt = self.amountlabel.text;
        self.nv = [[UINavigationController alloc]initWithRootViewController:ScanImagevc];
        [self presentViewController:self.nv animated:YES completion:nil];
    }];
    
}
#pragma mark - 通讯
-(void)callQRcreat:(NSString *)tx_code {
    NSString *webServiceUrl = @"http://www.dldhcwx.com/icmp-ums/dhc/sys/mobile.do";
    //    //参数值
    //    NSString *theCityCode = @"nanjing";
    //请求体拼接
    NSUserDefaults *mer = [NSUserDefaults standardUserDefaults];
    NSString *mer_id = [ mer objectForKey:@"mer_id"];
    DLOGP(@"%@",mer_id);
    // 启动系统风火轮
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *soapMessage = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\" ?>"
                             "<Request>"
                             "<Head>"
                             "<trace_no>6</trace_no>"
                             "<terminalno>8</terminalno>"
                             "<tanstype>%@</tanstype>"
                             "<acceptidcode>%@</acceptidcode>"
                             "<operateno>3</operateno>"
                             "</Head>"
                             "<Body>"
                             "<amt>%@</amt>"
                             "</Body>"
                             "</Request>"
                             ,tx_code,mer_id,self.amountlabel.text];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml", @"application/xml", nil];
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
        DLOGP(@"%@",dic);
        NSDictionary *dic2 = [dic objectForKey:@"Body"];
        DLOGP(@"%@",dic2);
        NSString *respcd = [dic2 objectForKey:@"respcd"];
        DLOGP(@"respcd=%@",respcd);
        NSString *RET_MSG = [dic2 objectForKey:@"RET_MSG"];
        NSString *code_url = [dic2 objectForKey:@"code_url"];
         [SVProgressHUD dismiss];
        NSString *qr_code = [dic2 objectForKey:@"qr_code"];
        if([respcd  isEqual: @"00"]){
            NSLog(@"%@",RET_MSG);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // time-consuming task
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                });
            });
            CreatQRcodeviewController *creatQRvc = [[CreatQRcodeviewController alloc]init];
            if(self.amountlabel.text != nil){
                creatQRvc.amt = self.amountlabel.text;
            }
            if(tx_code == aliPay)
            {
                creatQRvc.payFlag = 1;
                creatQRvc.qrCode = qr_code;
            }else{
                creatQRvc.payFlag = 2;
                creatQRvc.qrCode =code_url;
            }
            
            [self.maskButton removeFromSuperview];
            
            self.nv = [[UINavigationController alloc]initWithRootViewController:creatQRvc];
            [self presentViewController: self.nv animated:YES completion:nil];
        }
        DLOGP(@"RET_MSG=%@",RET_MSG);
        
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

@end
