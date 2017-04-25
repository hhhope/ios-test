//
//  ScanImageViewController.h
//  二维码生成与扫描
//
//  Created by 周鑫 on 15/11/7.
//  Copyright © 2015年 chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanImageView<NSObject>
@optional
- (void)reportScanResult:(NSString *)result;
- (void)removeScanImageView;
@end

@interface ScanImageViewController : UIViewController

@property (nonatomic,weak)id <ScanImageView>delegate;//代理方法传递数据
@property (nonatomic,copy) NSString *amt;


@end
