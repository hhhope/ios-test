//
//  CreatQRcodeviewController.h
//  Uepp-0307
//
//  Created by 严 on 2017/3/13.
//  Copyright © 2017年 yan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CreatQRcodeviewDelegate<NSObject>
@optional
- (void)removeQRcodeview;
@end
@interface CreatQRcodeviewController : UIViewController
@property (nonatomic,copy)   NSString *qrCode;
@property (nonatomic,copy)   NSString *amt;
@property (nonatomic,assign) NSUInteger payFlag;
@property (nonatomic,weak)id <CreatQRcodeviewDelegate>delegate;//代理方法传递数据
@end
