//
//  MovieInformation.h
//  Uepp-0307
//
//  Created by 严 on 2017/3/14.
//  Copyright © 2017年 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieInformation : NSObject
@property (copy,nonatomic) NSString *year;
@property (copy,nonatomic) NSString *title;
+(instancetype)moveWithDict:(NSDictionary *)dict;
@end
