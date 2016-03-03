//
//  fastNewModel.h
//  DMZJ
//
//  Created by 谅 陈 on 15/12/14.
//  Copyright © 2015年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fastNewModel : NSObject
@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSNumber *Id;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSInteger updatetime;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, strong) NSNumber *vote_amount;

@property (nonatomic,strong) NSArray *modelList;
@end
