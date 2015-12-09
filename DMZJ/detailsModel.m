//
//  detailsModel.m
//  DMZJ
//
//  Created by 谅 陈 on 15/12/1.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "detailsModel.h"


@implementation detailsModel


@end

@implementation data


+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"list":@"listDetails",@"similar":@"similarDetails"};
}



@end

@implementation info

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id",@"Description":@"description"};
}

@end



@implementation listDetails

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

@end

@implementation similarDetails

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

@end









