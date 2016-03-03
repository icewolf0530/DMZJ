//
//  searchLabModel.m
//  DMZJ
//
//  Created by 谅 陈 on 15/12/11.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "searchLabModel.h"

@implementation searchLabModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"seaLabData":@"data"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"seaLabData":@"searchData"};
}
@end

@implementation searchData

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

@end
