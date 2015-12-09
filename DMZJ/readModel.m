//
//  readModel.m
//  DMZJ
//
//  Created by 谅 陈 on 15/12/3.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "readModel.h"

@implementation readModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}
@end

@implementation pageModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"page":@"pageModel"};
}

@end

@implementation sizeModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"size":@"sizeModel"};
}

@end