//
//  ADmodel.m
//  DMZJ
//
//  Created by 谅 陈 on 15/12/14.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "ADmodel.h"

@implementation ADmodel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"data":@"ADdata"};
}

@end

@implementation ADdata

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

@end