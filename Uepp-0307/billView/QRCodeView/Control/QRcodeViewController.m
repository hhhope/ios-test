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

@interface QRcodeViewController ()

//显示屏
@property UIImageView *amount;
@property UILabel  *amountTitle;
@property UILabel  *amountlabel;
@property UIButton *qrButton;
@property UIButton *massage;

@property NSString *balance;
@property NSString *ouput_amt;//金额
@property NSString *input_amt;
//扫描和收款

@property UIButton *qrCodeButton;
@property UIButton *qrReceivables;

//计算器
@property UIImageView *calculatorView;
@end

@implementation QRcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        make.left.equalTo(self.amount).offset(20);
    }];
    self.qrButton = [UIButton buttonWithType:UIButtonTypeSystem];
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
//                        [keyView setBackgroundColor:[UIColor colorWithRed:243 green:127 blue:38 alpha:1]];
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
        }
        
        self.balance =str1;
        self.amountlabel.text=self.balance;
        
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
    
//    if([button.titleLabel.text  isEqual: @"+"]){
//        
//        self.input_amt =self.balance;
//        self.balance = nil;
//        return ;
//        
//    }
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
  
    if(self.balance == nil&&self.ouput_amt == nil)
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
    }else if(self.ouput_amt != nil){
        scanImage.amt = self.ouput_amt;
    }else{
        NSLog(@"bbbb");
        scanImage.amt = self.balance;
    }
    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:scanImage];
    [self presentViewController:nv animated:YES completion:nil];
    NSLog(@"scanImageButton");
}
-(void)qrCollection{
    CreatQRcodeviewController *creatQRvc = [[CreatQRcodeviewController alloc]init];
    if(self.balance == nil&&self.ouput_amt == nil)
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
    }else if(self.ouput_amt != nil){
        creatQRvc.amt = self.ouput_amt;
    }else{
        NSLog(@"bbbb");
        creatQRvc.amt = self.balance;
    }
    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:creatQRvc];
    [self presentViewController:nv animated:YES completion:nil];
    NSLog(@"scanImageButton");
}

@end
