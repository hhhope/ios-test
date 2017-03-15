//
//  MovieInformation.m
//  Uepp-0307
//
//  Created by 严 on 2017/3/14.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "MovieInformation.h"

@implementation MovieInformation
+(instancetype)moveWithDict:(NSDictionary *)dict{
    MovieInformation *move = [[self alloc] init];
    
    [move setValuesForKeysWithDictionary:dict];
    
    // 遍历字典里面的所有key去模型中
    
    return move;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
@end
