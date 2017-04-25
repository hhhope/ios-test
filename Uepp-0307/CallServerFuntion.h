//
//  CallServerFuntion.h
//  Uepp-0307
//
//  Created by 严 on 2017/4/21.
//  Copyright © 2017年 yan. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface CallServerFuntion : AFHTTPSessionManager
-(void)callServerFution:(NSString *)tx_code merid:(NSString *)merid amt:(NSString *)amt;
@end
