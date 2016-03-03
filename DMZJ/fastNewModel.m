//
//  fastNewModel.m
//  DMZJ
//
//  Created by 谅 陈 on 15/12/14.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "fastNewModel.h"


@implementation fastNewModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"moelList":@"fastNewModel"};
}

@end
