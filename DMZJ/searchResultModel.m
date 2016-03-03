//
//  searchResultModel.m
//  DMZJ
//
//  Created by 谅 陈 on 15/12/24.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "searchResultModel.h"

@implementation searchResultModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"seaData":@"data"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"seaData":@"resultData"};
}


@end

@implementation resultData

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

@end
