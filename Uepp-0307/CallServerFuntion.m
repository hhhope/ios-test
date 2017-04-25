//
//  CallServerFuntion.m
//  Uepp-0307
//
//  Created by 严 on 2017/4/21.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "CallServerFuntion.h"

@implementation CallServerFuntion
-(void)callServerFution:(NSString *)tx_code merid:(NSString *)merid amt:(NSString *)amt{

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
                             ,tx_code,mer_id,amt];
    
    
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
}
@end
