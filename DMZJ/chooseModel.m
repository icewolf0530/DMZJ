//
//  chooseModel.m
//  DMZJ
//
//  Created by 谅 陈 on 15/12/7.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import "chooseModel.h"

@implementation chooseModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Arrdata":@"data"};
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"Arrdata":@"choosedata"};
}
@end

@implementation choosedata

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id":@"id"};
}



@end