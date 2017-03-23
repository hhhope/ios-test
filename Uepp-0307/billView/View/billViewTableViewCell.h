//
//  billViewTableViewCell.h
//  Uepp-0307
//
//  Created by 严 on 2017/3/21.
//  Copyright © 2017年 yan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface billViewTableViewCell : UITableViewCell
- (UITableViewCell *)billCellWIthstyle:(NSString *)cellid
                             imagename:(NSString *)imagename
                              payDesc :(NSString *) payDesc
                              payTime : (NSString *) payTime
                             payMoney :(NSString *) payMoney
                         payMoneyColor:(UIColor *) payMoneyColor
                              payStat :(NSString *) payStat
                          payStatColor:(UIColor *) payStatColor;
@end
