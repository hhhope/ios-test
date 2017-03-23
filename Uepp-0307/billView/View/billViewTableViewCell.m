//
//  billViewTableViewCell.m
//  Uepp-0307
//
//  Created by 严 on 2017/3/21.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "billViewTableViewCell.h"

@implementation billViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (UITableViewCell *)billCellWIthstyle:(NSString *)cellid
  imagename:(NSString *)imagename
    payDesc :(NSString *) payDesc
    payTime : (NSString *) payTime
    payMoney :(NSString *) payMoney
    payMoneyColor:(UIColor *) payMoneyColor
    payStat :(NSString *) payStat
    payStatColor:(UIColor *) payStatColor
    {
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];

     //交易类型图标
    UIImageView *payImage = [[UIImageView alloc]init];
    [cell addSubview:payImage];
    [payImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.centerY.equalTo(0);

    }];
    payImage.image = [UIImage imageNamed:imagename];
    //交易类型描述
    UILabel *payDescLabel = [[UILabel alloc]init];
    [cell addSubview:payDescLabel];
    payDescLabel.text = payDesc;
    payDescLabel.font = [UIFont systemFontOfSize:18];
    [payDescLabel sizeToFit];
    [payDescLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(50);
        make.top.equalTo(6);
    }];
    //交易时间
    UILabel *payTimeLabel = [[UILabel alloc]init];
    [cell addSubview:payTimeLabel];
    payTimeLabel.text = payTime;
    payTimeLabel.font = [UIFont systemFontOfSize:13];
    [payTimeLabel sizeToFit];
    [payTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-10);
        make.left.equalTo(50);
    }];
     //交易金额
    UILabel *payMoneyLabel = [[UILabel alloc]init];
    [cell addSubview: payMoneyLabel];
    payMoneyLabel.text = payMoney;
    payMoneyLabel.textColor = payMoneyColor;
    payMoneyLabel.font = [UIFont systemFontOfSize:20];
    [payMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.right.equalTo(-10);
    }];
    //交易状态
    UILabel *payStateLabel = [[UILabel alloc]init];
    [cell addSubview: payStateLabel];
    payStateLabel.text = payStat;
    payStateLabel.textColor = payStatColor;
    payStateLabel.font = [UIFont systemFontOfSize:10];
    [payStateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-10);
        make.right.equalTo(-10);
    }];
    
    return cell;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
